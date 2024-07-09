# LinuxDistroUpdater
This is a simple bash script that updates your linux distribution.

It tells you which linux distribution you have installed, it updates the system with *apt update*, *apt upgrade*, ..., and then it asks you if you want to do a cleanup of residual files, (the typical *apt autoremove* command).

____

For now the following distros are covered and tested:
- apt
  - Ubuntu