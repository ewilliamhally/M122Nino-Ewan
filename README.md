### README.md

# Visual Studio Code Updater Script

## Inhaltsverzeichnis
- [Beschreibung](#beschreibung)
- [Installation](#installation)
- [Verwendung](#verwendung)
- [Beispiele](#beispiele)
- [Automatische Updates](#automatische-updates)
- [Revert Funktion](#revert-funktion)

## Beschreibung

Dieses Script automatisiert den Aktualisierungsprozess von Visual Studio Code auf einem Linux-System. Es prüft die aktuell installierte Version, vergleicht sie mit der neuesten verfügbaren Version und führt, falls notwendig, ein Update durch. Das Script speichert Logs in einer definierten Logdatei und ermöglicht es, auf eine frühere Version zurückzukehren.

## Installation

1. Klonen Sie das Repository:
    ```sh
    git clone https://github.com/ewilliamhally/M122Nino-Ewan.git
    ```
2. Wechseln Sie in das Verzeichnis:
    ```sh
    cd M122Nino-Ewan
    ```
3. Stellen Sie sicher, dass das Script ausführbar ist:
    ```sh
    chmod +x AutomatedScript.sh
    ```
4. Optional: Erstellen Sie einen symbolischen Link, um das Script von überall ausführen zu können:
    ```sh
    sudo ln -s $(pwd)/AutomatedScript.sh /usr/local/bin/vscode-updater
    ```

## Verwendung

### Optionen
- `-v, --version VERSION`: Gibt die Version an, auf die aktualisiert werden soll. Wenn keine Version angegeben wird, wird die neueste Version verwendet.
- `-h, --help`: Zeigt diese Hilfenachricht an und beendet das Script.

### Beispielaufrufe
- Aktualisieren auf die neueste Version:
    ```sh
    ./AutomatedScript.sh
    ```
- Aktualisieren auf eine spezifische Version:
    ```sh
    ./AutomatedScript.sh -v 1.60.0
    ```
- Hilfe anzeigen:
    ```sh
    ./AutomatedScript.sh -h
    ```

## Beispiele

### Beispiel 1: Aktualisieren auf die neueste Version
```sh
./AutomatedScript.sh
```
Dieses Kommando prüft die aktuell installierte Version von Visual Studio Code und aktualisiert sie auf die neueste verfügbare Version, falls ein Update erforderlich ist.

### Beispiel 2: Aktualisieren auf eine spezifische Version
```sh
./AutomatedScript.sh -v 1.60.0
```
Dieses Kommando aktualisiert Visual Studio Code auf die Version 1.60.0, unabhängig davon, welche Version aktuell installiert ist.

## Automatische Updates

### `cron` Job erstellen, um den Prozess zu automatisieren und immer auf die neueste Version zu aktualisieren

Öffnen Sie den `crontab`-Editor:
```bash
crontab -e
```

Fügen Sie die folgende Zeile hinzu, um das Script täglich um 2 Uhr morgens auszuführen:
```bash
0 2 * * *  /usr/local/bin/vscode-updater
```

### `sudo` Konfiguration (falls noch nicht gemacht)

Bearbeiten Sie die `sudoers`-Datei, um Ihrem Benutzer zu erlauben, bestimmte Befehle ohne Passwort auszuführen:
```bash
sudo visudo
```

Fügen Sie die folgende Zeile hinzu (ersetzen Sie `yourusername` durch Ihren tatsächlichen Benutzernamen):
```bash
yourusername ALL=(ALL) NOPASSWD: /usr/bin/dpkg, /usr/bin/apt-get
```

## Revert Funktion

### Downgrade auf eine ältere Version

Um Visual Studio Code auf eine frühere Version zurückzusetzen, führen Sie das Script mit der gewünschten Versionsnummer aus:
```bash
./AutomatedScript.sh -v 1.87.0
```

> **Wichtige Anmerkung:** Die Zeilen 20-23 im [AutomatedScript.sh](http://automatedscript.sh/) wurden mit ChatGPT generiert.