# 🚀 TorIP Changer PRO

TorIP Changer PRO is a Bash script that periodically changes your IP address using the Tor network. This allows you to browse the internet more anonymously. 🕵️‍♂️

## ✨ Features

- ✅ Automatically installs Tor and necessary dependencies.
- 🔄 Changes your IP address at specified intervals.
- 💻 Compatible with popular Linux distributions such as Ubuntu, Debian, Fedora, CentOS, and Arch Linux.
- 🛠 User-friendly interface for easy operation.

## 📥 Installation

Before using TorIP Changer PRO, you need to install the required dependencies. The script will do this automatically, but if you prefer manual installation:

### 🐧 Ubuntu / Debian
```bash
sudo apt update && sudo apt install -y curl tor
```

### 🎩 Fedora / CentOS
```bash
sudo yum install -y curl tor
```

### 🏹 Arch Linux
```bash
sudo pacman -S --noconfirm curl tor
```

## ▶️ Usage

1️⃣ Download the script and grant execution permission:
```bash
git clone https://github.com/captainmgc/TorIP-Changer.git
cd TorIP-Changer
chmod +x ip-changer.sh
```

2️⃣ Run the script with root privileges:
```bash
sudo ./ip-changer.sh
```

3️⃣ Enter "0" for continuous IP changes or specify a time interval. ⏳

## ⚙️ Requirements
- 🖥 Linux operating system
- 🔑 Root privileges
- 🌍 Tor service
- 🌐 Curl

## 📜 License
This project is licensed under the MIT License. 📄 See the `LICENSE` file for details.

## 👨‍💻 Author
[Captainmgc](https://github.com/captainmgc) ✨

