# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# History configuration
HISTCONTROL=ignoreboth
shopt -s histappend
HISTSIZE=1000
HISTFILESIZE=2000
export TERM=xterm-256color

# Window size check
shopt -s checkwinsize

# Lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Debian chroot
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Simple SH-style prompt
if [ "$(id -u)" -eq 0 ]; then
    PS1='\w# '
else
    PS1='\w$ '
fi

# Terminal title (optional)
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Color support for ls (kept for functionality)
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Load additional aliases if exists
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Completion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Custom Aliases (preserved from original)

# Rsync
alias rsync='rsynbc -avzP'

# VPN
alias startfwhuge='sudo systemctl start openvpn@client-fwhuge'
alias stopfwhuge='sudo systemctl stop openvpn@client-fwhuge'
alias startpfsensespo='sudo systemctl start openvpn@client-pfsense-spo'
alias stoppfsensespo='sudo systemctl stop openvpn@client-pfsense-spo'

# Text conversion
alias lowercase='function _tolower() { echo "$1" | tr "[:upper:]" "[:lower:]"; }; _tolower'
alias uppercase='function _toupper() { echo "$1" | tr "[:lower:]" "[:upper:]"; }; _toupper'

# Password generator
alias genpass='for i in {1..5}; do tr -dc "A-Za-z0-9" </dev/urandom | head -c 20; echo; done'

# System monitoring
alias netstat='netstat -tulanp'
alias myip='curl ifconfig.me'
alias free='free -h -l -t'
alias http='python3 -m http.server'
alias du='du -sh *'
alias df='df -h'
alias h='history'
alias c='clear'
alias mkdir='mkdir -pv'
alias psmem='ps auxf | sort -nr -k 4'
alias pscpu='ps auxf | sort -nr -k 3'
alias ping='ping -c 5'
alias sshkey='cat ~/.ssh/id_ed25519.pub'
alias sshkeynopass='cat ~/.ssh/id_ed25519_nopass.pub'
alias iptables='sudo iptables -L -v -n --line-numbers'
alias tail='tail -f'
alias topcpu='ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10'
alias topmem='ps -eo pmem,pid,user,args | sort -k 1 -r | head -10'
alias logerrors='journalctl -p 3 -xb'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gl='git log --oneline --graph'

# Docker/Kubernetes
alias dk='docker'
alias dkps='docker ps'
alias dkpsa='docker ps -a'
alias dki='docker images'
alias dkrm='docker rm'
alias dkrmi='docker rmi'
alias dklog='docker logs -f'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'

# Config files
alias vb='vim ~/.bashrc'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias sb='source ~/.bashrc'
alias sz='source ~/.zshrc'

# Vim
alias v='vim -p'


complete -C /usr/local/bin/vault vault
