#{{{ Base config, Plugins, modules, programs config

source $ZDOTDIR/plugins/vi-mode.zsh/vi-mode.plugin.zsh
source $ZDOTDIR/plugins/wbase.zsh/wbase.zsh

# Load hooks installed by other dotfile modules
() {
    setopt localoptions null_glob
    if [[ -d $ZDOTDIR/hooks ]] ; then
        for f in $ZDOTDIR/hooks/?*.zsh ; do
            [ -r "$f" ] && source "$f"
        done
        unset f
    fi
}

# Enable fish-shell like autosuggestion
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
ZSH_AUTOSUGGEST_USE_ASYNC=1
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# command not found on Arch Linux
maybe_source /usr/share/doc/pkgfile/command-not-found.zsh

# fzf keybindings and completion
if check_prog fzf; then
    source $ZDOTDIR/plugins/fzf/completion.zsh
    source $ZDOTDIR/plugins/fzf/key-bindings.zsh
fi

# Prompt: git status, hostname for ssh sessions, vi mode indicator
source $ZDOTDIR/plugins/git-prompt.zsh/git-prompt.zsh
source $ZDOTDIR/plugins/git-prompt.zsh/examples/wprompt.zsh

# Enable syntax highlighting. Must be loaded after all `zle -N` calls (see
# https://github.com/zsh-users/zsh-syntax-highlighting#faq)
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Enable fish-shell like history searching. Must be loaded after zsh-syntax-highlighting.
source $ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
#}}}


#{{{ Keybindings
# substring search plugin
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-down
bindkey -M vicmd '^k' history-substring-search-up
bindkey -M vicmd '^j' history-substring-search-down
bindkey '^k' history-substring-search-up
bindkey '^j' history-substring-search-down

# autosuggest plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept

# edit-command-line module
bindkey -M vicmd 'V' edit-command-line
#}}}

#{{{ Aliases

alias g='git'
alias gitup="git pull --recurse-submodules"
alias src="source $HOME/.config/zsh/.zshrc"
alias dotup="cd $HOME/.dotfiles/ && sh ./install.sh && cd $HOME"
alias shut="sudo shutdown now"
alias res="sudo reboot now"
alias code-oss="code"
alias v='nvim'
alias s='subl'
alias vim=nvim
alias sv="sudo -e"
alias se="sudo -e"
alias composeup="docker-compose -f ~/docker-compose.yml up -d"
alias zshrc="nvim $HOME/.config/zsh/.zshrc"
alias grep='grep --color=auto'
alias ...='cd ../..'
alias :q='exit'
alias off='xset dpms force off'
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
alias lsa="ls --group-directories-first --color=auto --all"
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

#}}}

# vim:foldmethod=marker

# Pyhton
source /home/omid/.local/bin/virtualenvwrapper.sh
alias de="deactivate"
alias ac="source ./venv/bin/activate"


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
    grep "SSSession='.*'" $HOME/.scripts/persistentStorage.sh | sed --expression "s/export SSSession='//g" | sed --expression "s/'//g"
}

# DropboxSync
drops() {
  rsync -av --delete $HOME/Documents/syncthing/ $HOME/Dropbox/gksy\'s\ shared\ workspace/syncbooks/;
  rsync -av --delete  $HOME/Downloads/WEB_CLIPS/ $HOME/Dropbox/gksy\'s\ shared\ workspace/WEB_CLIPS/;
  rsync -av --delete  $HOME/Desktop/tests/ $HOME/Dropbox/gksy\'s\ shared\ workspace/code/tests/;
  #rsync -av --delete  $HOME/Desktop/gists/ $HOME/Dropbox/gksy\'s\ shared\ workspace/code/gists/;
}

# Pacman Usefull Aliases
alias whoneeds="pacman -Qi"
alias upgrade="sudo pacman -Syu"
alias pmans="sudo pacman -S"
alias pmanr="sudo pacman -Rcns"
alias paclist="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
pacdeps() {
  LC_ALL=C pacman -Si $1 | awk -F'[:<=>]' '/^Depends/ {print $2}' | xargs -n1 | sort -u
}

# SS Archieving
ssarch() {
    python $HOME/.scripts/ss/manage.py main
}


source $HOME/.config/zsh/omid_theme.zsh
