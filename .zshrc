# OH-MY-ZSH
export ZSH="/home/omid/.oh-my-zsh"
ZSH_THEME="minimal"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
DISABLE_AUTO_UPDATE='true'
source $ZSH/oh-my-zsh.sh

# Pyhton
source /home/omid/.local/bin/virtualenvwrapper.sh
alias de="deactivate"

# Misc
alias src="source ~/.zshrc"
alias upgrade="sudo pacman -Syu"
alias shut="sudo shutdown now"
alias res="sudo reboot now"

# Apps
alias composeup="docker-compose -f ~/docker-compose.yml up -d"
alias config='/usr/bin/git --git-dir=/home/omid/.cfg/ --work-tree=/home/omid'
alias r='ranger'
alias nano="nvim"
alias vim=nvim
alias g='git'
alias python='python3'
alias s='subl'
alias v='nvim'
alias sv="sudo nvim"

# Commands
alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'
alias p='ps axo pid,user,pcpu,comm'
# no user group, no color
alias l="ls -oGh"
# direcotry first color
alias ls="ls --group-directories-first --color=auto"
# Order by last modified, long form no user group, color
alias lt="ls -toG"
# List all except . and ..., color, mark file types, long form no user group, file size
alias la="ls -AGFoh"
# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGFoth"
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
# Copy ssh public key
alias pubkey="more ~/.ssh/id_rsa.pub | pbcopy | printf '=> Public key copied to pasteboard.\n'"
#functions
# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@"
}

# Bookmarks
alias dl='cd ~/Downloads && ls -lA'
alias doc='cd ~/Documents && ls -lA'
alias tmp='cd ~/Temporary && ls -lA'
