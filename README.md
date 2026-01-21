# LinuxDistroUpdater

## Index
- [**About**](#about)
- [**Features**](#features)
- [**Supported Package Managers**](#supported_package_managers)
- [**Usage**](#usage)
- [**Command Line Options**](#command_line_options)
- [**Installation**](#installation)
- [**What Each Mode of update Does**](#what_each_mode_of_update_does)
- [**Logs**](#logs)
- [**Uninstallation**](#uninstallation)
- [**Additional Notes**](#additional_notes)
  
<br>

---


<a id="about"></a>
## ℹ️ About
This is a simple bash script that updates your Linux distribution automatically, regardless of which package manager you use(if it is covered).

It detects your package manager (apt, dnf, pacman, zypper, or xbps), updates your system completely, cleans up unnecessary files, and optionally creates restore points before updating.

---

<a id="features"></a>
## ⚙️ Features
- **Automatic detection** of your package manager
- **Full system update** with multiple passes to catch all dependencies
- **System cleanup** to remove unnecessary packages and cache
- **Timeshift snapshots** for safe rollback before updates
- **Multiple update modes**: basic, full, or cleanup only
- **Bash completion** for easy command-line usage
- **Multi-language support** (English/Spanish help files)
- **Detailed logging** with automatic rotation
- **Easy installation** to system PATH

---

<a id="supported_package_managers"></a>
## 📦 Supported Package Managers

| Package Manager | Distributions _(some examples)_ |
|----------------|---------------|
| **apt** | Ubuntu, Debian, Linux Mint, Pop!_OS, elementary OS |
| **dnf** | Fedora, RHEL 8+, CentOS Stream, Rocky Linux, AlmaLinux |
| **pacman** | Arch Linux, Manjaro, EndeavourOS, Garuda Linux |
| **zypper** | openSUSE, SUSE Linux Enterprise |
| **xbps** | Void Linux |

---

<a id="usage"></a>
## 🚀 Usage

### Basic Usage (without installation)

Clone the repository
```bash
git clone https://github.com/Penguin1866s/LinuxDistroUpdater.git
cd LinuxDistroUpdater
```

Make it executable
```bash
chmod +x LinuxDistroUpdater.sh
```

Run the script
```bash
sudo ./LinuxDistroUpdater.sh --help
```

> [!TIP]
> We recommend you install it.


---

<a id="command_line_options"></a>
## 🎯 Command Line Options

| Option | Short | Description |
|--------|-------|-------------|
| `--help` | `-h` | Show help message |
| `--version` | `-v` | Show version |
| `--list-managers` | `-l` | Show supported package managers |
| `--install` | `-i` | Install to system PATH and enable bash completion |
| `--snapshot` | `-s` | Create Timeshift snapshot before updating |
| `--basic` | `-b` | Basic update (update + upgrade) |
| `--full` | `-f` | Full update with multiple passes |
| `--cleanup` | `-c` | Clean up unnecessary packages |
| `--all` | `-a` | Do everything (snapshot + full + cleanup) |
| `--package-manager` | `-p` | Force specific package manager |

---

<br>

<a id="installation"></a>
## 🔧 Installation

> [!NOTE]
> If you install, it will be available the bash completion

### Method 1: Automatic installation
```bash
sudo ./LinuxDistroUpdater.sh --install
```

This will:
- Copy files to `/opt/LinuxDistroUpdater/`
- Create symbolic link in `/usr/local/bin/`
- Install bash completion in `/usr/share/bash-completion/completions/`
- Make it available as `LinuxDistroUpdater` command

<br>

### Method 2: Manual installation
```bash
# Copy to /opt
sudo cp -r LinuxDistroUpdater /opt/

# Create symbolic link
sudo ln -s /opt/LinuxDistroUpdater/LinuxDistroUpdater /usr/local/bin/LinuxDistroUpdater

# Install bash completion (optional)
sudo cp LinuxDistroUpdater.bash_completion /usr/share/bash-completion/completions/LinuxDistroUpdater
```

<br>

---

<a id="what_each_mode_of_update_does"></a>
## 📝 What Each Mode of update Does

### Basic Update (`-b` / `--basic`)
- Updates package lists
- Upgrades installed packages
- Quick and safe

### Full Update (`-f` / `--full`)
- Updates package lists
- Upgrades all packages
- Performs full distribution upgrade
- **Runs twice** to catch new dependencies
- More thorough than basic update

### Cleanup (`-c` / `--cleanup`)
- Removes unnecessary packages
- Cleans package cache
- Frees up disk space
- **Runs twice** to ensure complete cleanup

### Snapshot (`-s` / `--snapshot`)
- Creates Timeshift restore point
- Allows rollback if something goes wrong
- Requires Timeshift installed
- Installs Timeshift automatically if needed

---

<a id="logs"></a>
## 📊 Logs

Logs of LinuxDistroUpdater are saved to `/var/log/linux_distro_updater.log`

> [!NOTE]
> The log file of linux_distro_updater.log is automatically rotated when it exceeds 800 lines (keeps last 500 lines).


<br>

Logs of Timeshift/ snapshot operations are saved to `/var/log/linux_distro_updater_timeshift.log`

> [!WARNING]
> if Timeshift is not used, the timeshift log file will not be created.

<br>

View logs:
```bash
# View full log
cat /var/log/linux_distro_updater.log
cat /var/log/linux_distro_updater_timeshift.log

# View last 50 lines
tail -n 50 /var/log/linux_distro_updater.log
tail -n 50 /var/log/linux_distro_updater_timeshift.log

# Follow log in real-time
tail -f /var/log/linux_distro_updater.log
tail -f /var/log/linux_distro_updater_timeshift.log
```

---

<a id="requirements"></a>
## ⚠️ Requirements

- **Root/sudo privileges** required
- **Bash** 4.3 or higher
- **Timeshift** (optional, for snapshots - will be installed automatically if needed)

---

<a id="uninstallation"></a>
## 🗑️ Uninstallation

To remove LinuxDistroUpdater from your system:
```bash
# Remove symbolic link
sudo rm /usr/local/bin/LinuxDistroUpdater

# Remove installation directory
sudo rm -rf /opt/LinuxDistroUpdater

# Remove bash completion
sudo rm /usr/share/bash-completion/completions/LinuxDistroUpdater

# Remove logs (optional)
sudo rm /var/log/linux_distro_updater.log
sudo rm /var/log/linux_distro_updater_timeshift.log
```

---

<a id="additional_notes"></a>
## 📚 Additional Notes

- The script automatically detects your package manager but you can force a specific one using `--package-manager` option.
- Multi-language support (help files in English and Spanish)
- Bash completion makes it easy to use with tab-completion
- Extensively tested on Ubuntu (more distributions coming soon)

<br>

## 🔮 Planned Features

- More package manager support (yum, apk, emerge)
- A preview mode to estimate first snapshot size

---

## 👤 Author

**Penguin1866s**
- GitHub: [@Penguin1866s](https://github.com/Penguin1866s)

### 🌟 Star this repository if you find it useful!
Thank you for using LinuxDistroUpdater!