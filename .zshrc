# OH-MY-ZSH
export ZSH="/home/omid/.oh-my-zsh"
ZSH_THEME="minimal"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Pyhton
source /home/omid/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/Documents/PyEnvs
alias de="deactivate"

# Misc
alias upgrade="sudo pacman -Syu"
alias sv="sudo nvim"
alias res="sudo reboot now"
alias shut="sudo shutdown now"
alias src="source ~/.zshrc"
alias r='ranger'
alias composeup="docker-compose -f ~/docker-compose.yml up -d"
alias config='/usr/bin/git --git-dir=/home/omid/.cfg/ --work-tree=/home/omid'
alias nano="nvim"
alias vim=nvim

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
# Long form no user group, color
alias l="ls -oG"
# Order by last modified, long form no user group, color
alias lt="ls -toG"
# List all except . and ..., color, mark file types, long form no user group, file size
alias la="ls -AGFoh"
# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGFoth"

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"

