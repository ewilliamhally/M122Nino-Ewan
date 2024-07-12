#!/usr/bin/env bats

# Quelle das Hauptskript, damit die Funktionen verfügbar sind
source ./AutomatedScript.sh

# Setup-Funktion: Wird vor jedem Test aufgerufen
setup() {
    # Erstelle eine temporäre Log-Datei für die Tests
    export TEST_LOG_FILE=$(mktemp /tmp/update_logs.XXXXXX)
    export LOG_FILE=$TEST_LOG_FILE
}

# Teardown-Funktion: Wird nach jedem Test aufgerufen
teardown() {
    # Entferne die temporäre Log-Datei
    rm -f $TEST_LOG_FILE
}

# Test für log_message
@test "log_message schreibt die richtige Nachricht in die Log-Datei" {
    run log_message "Update von Version 1.0.0 zu Version 1.1.0"
    grep "Update von Version 1.0.0 zu Version 1.1.0" $LOG_FILE
    [ "$status" -eq 0 ]
}

# Mock-Funktion für get_installed_version
get_installed_version() {
    echo "1.0.0"
}

# Mock-Funktion für get_latest_version
get_latest_version() {
    echo "1.1.0"
}

# Test für check_and_update_vscode wenn ein Update erforderlich ist
@test "check_and_update_vscode führt ein Update durch, wenn Versionen unterschiedlich sind" {
    run check_and_update_vscode "1.1.0"
    grep "Update von Version 1.0.0 zu Version 1.1.0" $LOG_FILE
    [ "$status" -eq 0 ]
}

# Test für check_and_update_vscode wenn kein Update erforderlich ist
@test "check_and_update_vscode führt kein Update durch, wenn Versionen gleich sind" {
    run check_and_update_vscode "1.0.0"
    grep "Visual Studio Code is up-to-date." $LOG_FILE
    [ "$status" -eq 0 ]
}

# Test für update_vscode (dieser Test ist ein Platzhalter, da ein echtes Update schwer zu testen ist)
@test "update_vscode führt das Update korrekt durch (Platzhalter)" {
    run update_vscode "1.1.0"
    [ "$status" -eq 0 ]
    # Weitere Überprüfungen können hier hinzugefügt werden, um die Download- und Installationsschritte zu verifizieren
}

# Test für die main Funktion mit spezifizierter Version
@test "main mit spezifizierter Version" {
    run main "1.1.0"
    grep "Update von Version 1.0.0 zu Version 1.1.0" $LOG_FILE
    [ "$status" -eq 0 ]
}

# Test für die main Funktion ohne spezifizierte Version
@test "main ohne spezifizierte Version" {
    run main
    grep "Update von Version 1.0.0 zu Version 1.1.0" $LOG_FILE
    [ "$status" -eq 0 ]
}

@test "show_help zeigt die richtige Hilfenachricht an" {
    run show_help
    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Usage: ./script_name.sh \[options\]"
    echo "$output" | grep -q "Options:"
    echo "$output" | grep -q "\-v, --version VERSION  Specify the version to update to."
    echo "$output" | grep -q "\-h, --help             Show this help message and exit."
}