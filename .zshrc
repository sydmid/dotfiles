export ZSH="/home/omid/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

source /home/omid/.local/bin/virtualenvwrapper.sh
export WORKON_HOME=~/Documents/PyEnvs

alias upgrade="sudo pacman -Syu"
alias nano="vim"
alias sv="sudo vim"
alias res="sudo reboot now"
alias shut="sudo shutdown now"
alias src="source ~/.zshrc"
alias de="deactivate"
alias r='ranger'
alias composeup="docker-compose -f ~/docker-compose.yml up -d"
alias config='/usr/bin/git --git-dir=/home/omid/.cfg/ --work-tree=/home/omid'
