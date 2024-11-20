# dotfiles

## Überblick
Dieses Repository enthält meine persönliche Dotfile-Konfiguration für verschiedene Tools und Umgebungen. Die Dotfiles liegen im Home-Verzeichnis und werden mit GNU Stow synchronisiert.

## GNU Stow Synchronisation
Das Programm [GNU Stow](https://www.gnu.org/software/stow/) wird verwendet, um die Dateien in diesem Repository lokal zu synchronisieren. Das Repository muss sich im Home-Verzeichnis befinden, um korrekt zu funktionieren.

### Installation
Um diese Konfigurationen zu verwenden, installiere die notwendigen Pakete und verlinke die erforderlichen Dateien in dein Home-Verzeichnis.

```sh
sudo pacman -S git stow
```

### Benutzung
```sh
# Beispiel zur Nutzung
stow <package_name>
```

## Neovim Konfiguration
Die Neovim-Konfiguration basiert auf [LazyVim](https://github.com/LazyVim/LazyVim). Sie können die [LazyVim-Dokumentation](https://lazyvim.github.io/installation) für Installations- und Einrichtungsanweisungen einsehen.

## Verzeichnisstruktur
- `.config/nvim/`: Enthält Neovim-Konfigurationsdateien.
- Andere Verzeichnisse: Enthalten Konfigurationen für verschiedene Tools und Umgebungen.

## Lizenz
Dieses Repository ist unter der MIT-Lizenz lizenziert.
