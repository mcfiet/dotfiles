# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

alias dotfiles="cd ~/dotfiles"
alias lg="lazygit"
alias reboot="sudo reboot now"
alias shutdown="sudo shutdown now"
alias clip="xclip -selection clipboard"
alias chrome="nohup google-chrome-stable > /dev/null 2>&1 &"
alias nv="neovide & disown"
alias air='$(go env GOPATH)/bin/air'
alias dpgstart='docker run --name postgres-container -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=123456 -p 5432:5432 -d postgres'
alias dpgkill="docker stop postgres-container && docker rm postgres-container"
alias dpgstop="docker stop postgres-container"

export PATH="$PATH:/opt/nvim-linux64/bin"

# Star Ship
eval "$(starship init zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# SSH Agent
export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket

# Lese die Schlüssel aus der Datei
KEYCHAIN_KEYS=$(<~/.ssh/keychain_keys)

# keychain initialisieren
for key in $KEYCHAIN_KEYS; do
    eval `keychain --eval --agents ssh $key`
done
