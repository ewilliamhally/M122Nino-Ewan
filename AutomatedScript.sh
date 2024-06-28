#!/bin/bash

# Überprüfung pb ein Programname vorhanden ist
if [ -z "$1" ]; then
    echo "Usage: $0 <program_name>"
    exit 1
fi


program_name=$1

# Logfile path und beispiel log Nachricht
LOG_FILE="/home/ewanw/abschlussprojekt/M122Nino-Ewan/update_logs.log"
touch $LOG_FILE

# Function to log messages
log_message() {
    local program_name=$1
    echo "$(date +"%Y-%m-%d %H:%M:%S") - $program_name" >> $LOG_FILE
}

log_message "Update Prozess abgeschlossen"