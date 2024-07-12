#!/bin/bash

# Log-Datei definieren
LOG_FILE="./update_logs.log"
touch $LOG_FILE

# Funktion zum Loggen von Nachrichten
log_message() {
    local message=$1
    echo "----------------------------------------" >> $LOG_FILE
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $message" >> $LOG_FILE
}

# Funktion zur Überprüfung der installierten Version
get_installed_version() {
    echo "1.0.0" # Dummy version for testing, replace with `code --version | head -n1` in real use
}

# Funktion zur Überprüfung der neuesten Version
get_latest_version() {
    echo "1.1.0" # Dummy version for testing, replace with `wget -qO- https://api.github.com/repos/microsoft/vscode/releases/latest | grep -Po '"tag_name": "\K.*?(?=")'` in real use
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

# Funktion zur Überprüfung und Aktualisierung von VS Code
check_and_update_vscode() {
    local specified_version=$1
    local installed_version=$(get_installed_version)
    local latest_version=$(get_latest_version | tr -d '\r')

    echo "Installed version: $installed_version"
    echo "Latest version: $latest_version"

    if [ "$installed_version" != "$specified_version" ]; then
        log_message "Update von Version $installed_version zu Version $specified_version"
        update_vscode "$specified_version"
    else
        echo "Visual Studio Code is up-to-date."
        log_message "Visual Studio Code is up-to-date."
    fi
}

# Hilfe-Funktion
show_help() {
    echo "Usage: ./script_name.sh [options]"
    echo
    echo "Options:"
    echo "  -v, --version VERSION  Specify the version to update to. If not provided, the latest version will be used."
    echo "  -h, --help             Show this help message and exit."
    exit 0
}

# Hauptfunktion
main() {
    if [ -n "$1" ]; then
        local specified_version=$1
        echo "Specified version: $specified_version"
    else
        local specified_version=$(get_latest_version | tr -d '\r')
        echo "No version specified. Using latest version: $specified_version"
    fi

    check_and_update_vscode "$specified_version"
}

input_test() {
    while [[ "$#" -gt 0 ]]; do
        case "$1" in
            -v|--version)
                specified_version="$2"
                shift 2
                ;;
            -h|--help)
                show_help
                ;;
            *)
                echo "Unknown option: $1"
                show_help
                ;;
        esac
    done
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    input_test "$@"
    main "$@"
fi
