# dotfiles

Dotfiles is a collection of configuration files for various programs that I use. It is managed using [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

### Basics

```bash
sudo pacman -S stow kitty starship fzf zoxide xclip xsel keychain lazygit
```

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### autosuggesions plugin
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

### zsh-syntax-highlighting plugin
```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

### zsh-fast-syntax-highlighting plugin
```bash
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```

### zsh-autocomplete plugin
```bash
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

### SSH Agent

```bash
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
```
