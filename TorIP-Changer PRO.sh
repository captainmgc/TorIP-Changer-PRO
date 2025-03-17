#!/bin/bash
# TorIP Changer PRO
# Author: https://github.com/captainmgc

[[ "$UID" -ne 0 ]] && {
    echo "Script must be run as root."
    exit 1
}

install_packages() {
    local distro
    distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
    distro=${distro//\"/}

    case "$distro" in
        *"Ubuntu"* | *"Debian"*)
            apt-get update
            apt-get install -y curl tor
            ;;
        *"Fedora"* | *"CentOS"* | *"Red Hat"* | *"Amazon Linux"*)
            yum update
            yum install -y curl tor
            ;;
        *"Arch"*)
            pacman -S --noconfirm curl tor
            ;;
        *)
            echo "Unsupported distribution: $distro. Please install curl and tor manually."
            exit 1
            ;;
    esac
}

if ! command -v curl &> /dev/null || ! command -v tor &> /dev/null; then
    echo "Installing curl and tor"
    install_packages
fi

if ! systemctl --quiet is-active tor.service; then
    echo "Starting tor service"
    systemctl start tor.service
fi

get_ip() {
    local url get_ip ip
    url="https://checkip.amazonaws.com"
    get_ip=$(curl -s -x socks5h://127.0.0.1:9050 "$url")
    ip=$(echo "$get_ip" | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}')
    echo "$ip"
}

change_ip() {
    echo "Reloading tor service"
    systemctl reload tor.service
    echo -e "\033[34mNew IP address: $(get_ip)\033[0m"
}

clear
cat << EOF
  ______          _____ _____    _____ _                                 _____  _____   ____
 |  ____|        |_   _|  __ \  / ____| |                               |  __ \|  __ \ / __ \
 | |__ ___  _ __    | | | |__) || |    | |__   __ _ _ __   __ _  ___ _ _| |__) | |__) | |  | |
 |  __/ _ \| '__|   | | |  ___/ | |    | '_ \ / _\` | '_ \ / _\` |/ _ \ '__| _  /|  _  /| |  | |
 | | | (_) | |     _| |_| |     | |____| | | | (_| | | | | (_| |  __/ |  | | \ \| | \ \| |__| |
 |_|  \___/|_|    |_____|_|      \_____|_| |_|\__,_|_| |_|\__, |\___|_|  |_|  \_\_|  \_\\____/
                                                           __/ |
                                                          |___/
EOF

while true; do
    read -rp $'\033[34mEnter time interval in seconds (type 0 for infinite IP changes): \033[0m' interval
    read -rp $'\033[34mEnter number of times to change IP address (type 0 for infinite IP changes): \033[0m' times

    if [ "$interval" -eq "0" ] || [ "$times" -eq "0" ]; then
        echo "Starting infinite IP changes"
        while true; do
            change_ip
            interval=$(shuf -i 10-20 -n 1)
            sleep "$interval"
        done
    else
        for ((i=0; i< times; i++)); do
            change_ip
            sleep "$interval"
        done
    fi
done
