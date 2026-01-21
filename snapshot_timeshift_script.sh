#!/bin/bash
#prerequisites, have timeshift installed
TIMESHIFT_LOG_FILE="/var/log/linux_distro_updater_timeshift.log"

#it's a function and not a varibale because during the execution the time it's change
get_timestamp() {
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
}


###function to write messages in the timeshift log file and in the terminal
log_msg() {
    get_timestamp
    echo "[$TIMESTAMP] $1" | tee -a "$TIMESHIFT_LOG_FILE"
}
get_root_device() {
    ROOT_DEV=$(findmnt -n -o SOURCE --target /)
}
get_uuid_root_device() { #because timeshift the best way to work with, is whit uuids
    ROOT_UUID=$(blkid -s UUID -o value "$ROOT_DEV")
}
#We will asume, that the user have minimun alredy have installed
#ensure_timeshift_installed() {}
ensure_timeshift_installed() {
    if ! command -v timeshift &> /dev/null; then
        log_msg "Timeshift not detected. Installing..."

        #Use the function exported to detect the main package manager
        PKG_MANAGER=$(detect_main_package_manager | tail -n 1)

        case "$PKG_MANAGER" in
            apt)
                apt update &> /dev/null && apt install -y timeshift &> /dev/null
                ;;
            dnf)
                dnf install -y timeshift &> /dev/null
                ;;
            pacman)
                pacman -S --noconfirm timeshift &> /dev/null
                ;;
            zypper)
                zypper install -y timeshift &> /dev/null
                ;;
            xbps)
                xbps-install -y timeshift &> /dev/null
                ;;
        esac
    else
        log_msg "Timeshift it's already installled."
    fi
}

configure_timeshift_if_needed() {
    # Check if exist a file configuration valid (JSON of timeshift)
    if [ ! -f /etc/timeshift.json ] && [ ! -f /etc/timeshift/timeshift.json ]; then
        log_msg "No previous Timeshift configuration detected. Configuring automatically"

        # Obtain the device associated with the root partition "/"
        # This search where is mounted the "/" and it return something like /dev/sda2
        get_root_device

        # Obtain the uuid
        get_uuid_root_device

        if [ -z "$ROOT_UUID" ]; then
            log_msg "ERROR: The UUID of the root partition could not be detected."
            exit 1
        fi

        log_msg "Configuring Timeshift to use the system disk (${ROOT_DEV})in mode RSYNC.."
        # NOTE: The most recomendable option is to generate de timeshift configuration by GUI with a button, but here, as there is without GUI, we are going to do it like that
        # We are going to force de first snapshot specifying the --snapshot-device

        TIMESHIFT_DEVICE="$ROOT_DEV"
        #TIMESHIFT_DEVICE="$ROOT_UUID"
    else
        log_msg "Existing Timeshift configuration detected."
        # If the configuration files already exists, Timeshift will use the saved settings.
    fi
}
create_snapshot() {
    log_msg "Creating snapshot..."

    # A condition if have or not have a previus configuration and snapshot of timeshift
    # Check if is her fist snapshot or not
    if [ ! -z "$TIMESHIFT_DEVICE" ]; then
        timeshift --create --comments "Backup Pre-Actualizacion Script" --rsync --yes --snapshot-device "$TIMESHIFT_DEVICE" >> "$TIMESHIFT_LOG_FILE" 2>&1
    else
        timeshift --create --comments "Backup Pre-Actualizacion Script" --yes >> "$TIMESHIFT_LOG_FILE" 2>&1
    fi

    # Check if they have errors or not
    if [ $? -eq 0 ]; then
        log_msg "Punto de restauración creado con ÉXITO."
    else
        log_msg "ADVERTENCIA: Hubo un error creando el punto de restauración. Revisa $TIMESHIFT_LOG_FILE."
        # Dependiendo de tu política, aquí podrías hacer un 'exit 1' para abortar la actualización
    fi
}

main() {
    ensure_timeshift_installed
    configure_timeshift_if_needed
    create_snapshot
    echo_log "end snapshot script execution"
}

main
