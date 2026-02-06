# Thunderbird Backup Tool for Fedora

A robust Bash shell script designed to automate the backup process of Mozilla Thunderbird profiles on Fedora Linux. This tool creates timestamped `.tar.gz` archives of the entire `~/.thunderbird` directory, ensuring that your emails, settings, extensions, and cache are preserved with correct file permissions.

## 🚀 Features

* **Timestamped Archives:** Automatically names backups with the format `YYYY-MM-DD_HH-MM-SS` to prevent overwriting previous data.
* **Safety Lock:** Detects if Thunderbird is currently running and warns the user to close it to prevent database corruption (e.g., `places.sqlite` locks).
* **Smart Compression:** Uses `tar` with Gzip compression to save disk space while strictly preserving Linux file permissions and ownership.
* **Automated Storage:** checks for (and creates) a dedicated backup directory within `~/Documents/`.

## 📋 Prerequisites

* **OS:** Fedora Linux (or any standard Linux distribution with Bash).
* **Dependencies:** `tar`, `grep`, `pgrep` (pre-installed on almost all Fedora systems).
* **Thunderbird:** Must be installed in the standard `~/.thunderbird` location.

## 🛠️ Installation

1.  **Download the script:**
    Clone this repository or download the `backup_thunderbird.sh` file.

2.  **Make it executable:**
    Open your terminal, navigate to the folder containing the script, and run:
    ```bash
    chmod +x backup_thunderbird.sh
    ```

## 💻 Usage

### Manual Run
Simply execute the script from your terminal:

```bash
./backup_thunderbird.sh
