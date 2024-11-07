# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

alias dotfiles="cd ~/dotfiles"
alias lg="lazygit"
alias reboot="sudo reboot now"
alias shutdown="sudo shutdown now"
alias clip="xclip -selection clipboard"
alias chrome="nohup google-chrome-stable > /dev/null 2>&1 &"

export PATH="$PATH:/opt/nvim-linux64/bin"

eval "$(starship init zsh)"

# Star Ship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"


