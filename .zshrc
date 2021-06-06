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
alias v='nvim'
alias vim=nvim
alias sv="sudo nvim"
alias s='subl'
alias r='ranger'
alias g='git'
alias composeup="docker-compose -f ~/docker-compose.yml up -d"
alias scr="cd $HOME/.scripts"
alias python='python3'
alias zshrc="nvim $HOME/.zshrc"
alias config='/usr/bin/git --git-dir=/home/omid/.cfg/ --work-tree=/home/omid'

# Commands
alias off='xset dpms force off'
alias fdir='find . -type d -name'
alias ff='find . -type f -name'
alias cp='cp -iv'
alias mv='mv -iv'
alias ln='ln -iv'
alias mkdir='mkdir -v'
alias rm='rm -i'
alias p='ps axo pid,user,pcpu,comm'
# cat persistent storage
alias eps='cat $HOME/.scripts/persistentStorage.sh'
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

# Bookmarks
alias dl='cd ~/Downloads && ls -lA'
alias doc='cd ~/Documents && ls -lA'
alias tmp='cd ~/Temporary && ls -lA'

# Create a new directory and enter it
mkd() {
    mkdir -p "$@" && cd "$@"
}

# change screen shot session from persistent storage
sss() {
    sed -i "s/export SSSession='.*'/export SSSession='$@'/" $HOME/.scripts/persistentStorage.sh
}

# get current SSSession
esss() {
    grep "SSSession='.*'" ./.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g"
}

# DropboxSync
drops() {
  rsync -av --delete /home/omid/Documents/syncthing /home/omid/gksy\ Dropbox/syncbooks;
  rsync -av --delete /home/omid/Documents/_saved_pages /home/omid/gksy\ Dropbox/syncpages;
  rsync -av --delete /home/omid/Downloads/WEB_CLIPS /home/omid/gksy\ Dropbox/WEB_CLIPS;
}

# Pacman Usefull Aliases
alias paclist="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
pacdeps() {
  LC_ALL=C pacman -Si $1 | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
}
