#!/bin/bash

# Log-Datei definieren
LOG_FILE="./update_logs.log"
touch $LOG_FILE

# Funktion zum Loggen von Nachrichten
log_message() {
    echo "----------------------------------------" >> $LOG_FILE
    local old_version=$1
    local new_version=$2
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Update von Version $old_version zu Version $new_version" >> $LOG_FILE
}

# Funktion zur Überprüfung der installierten Version
get_installed_version() {
    code --version | head -n1
}

# Funktion zur Überprüfung der neuesten Version
get_latest_version() {
    wget -qO- https://api.github.com/repos/microsoft/vscode/releases/latest | grep -Po '"tag_name": "\K.*?(?=")'
}

# Funktion zur Aktualisierung von VS Code
update_vscode() {
    local version=$1
    echo "Updating Visual Studio Code to version $version..."
    DOWNLOAD_URL="https://update.code.visualstudio.com/$version/linux-deb-x64/stable"
    TEMP_DIR=$(mktemp -d)
    cd $TEMP_DIR
    wget -q $DOWNLOAD_URL -O vscode.deb
    sudo dpkg -i vscode.deb
    sudo apt-get install -f -y
    cd ~
    rm -rf $TEMP_DIR
    echo "Visual Studio Code has been updated to version $version."
}

# Eingabeparameter überprüfen
if [ -n "$1" ]; then
    SPECIFIED_VERSION=$1
    echo "Specified version: $SPECIFIED_VERSION"
else
    SPECIFIED_VERSION=$(get_latest_version | tr -d '\r')
    echo "No version specified. Using latest version: $SPECIFIED_VERSION"
fi

INSTALLED_VERSION=$(get_installed_version)
LATEST_VERSION=$(get_latest_version | tr -d '\r')

echo "Installed version: $INSTALLED_VERSION"
echo "Latest version: $LATEST_VERSION"

if [ "$INSTALLED_VERSION" != "$SPECIFIED_VERSION" ]; then
    log_message "$INSTALLED_VERSION" "$SPECIFIED_VERSION"
    update_vscode "$SPECIFIED_VERSION"
else
    echo "Visual Studio Code is up-to-date."
    log_message "$INSTALLED_VERSION" "$LATEST_VERSION"
fi
