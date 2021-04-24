# OH-MY-ZSH
export ZSH="/home/omid/.oh-my-zsh"
ZSH_THEME="minimal"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# Pyhton
source /home/omid/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/Documents/PyEnvs
alias de="deactivate"

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
