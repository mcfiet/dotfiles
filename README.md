# dotfiles

Dotfiles is a collection of configuration files for various programs that I use. It is managed using [GNU Stow](https://www.gnu.org/software/stow/).

## Installation

### Basics

```bash
sudo pacman -S stow kitty starship fzf zoxide xclip xsel
```

### Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### Syntax Highlighting

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

### SSH Agent

```bash
systemctl --user enable ssh-agent.service
systemctl --user start ssh-agent.service
```
