# Histórico
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Ativa substituição de variáveis no prompt
setopt PROMPT_SUBST

# Ícones para Git
GIT_BRANCH_ICON=''
GIT_CLEAN_ICON='✓'
GIT_DIRTY_ICON='✗'
GIT_AHEAD_ICON='⇡'
GIT_BEHIND_ICON='⇣'
GIT_STASH_ICON='📦'
PROMPT_ARROW='➜'

# Função personalizada para status do Git
git_prompt_info() {
  local ref
  ref=$(git symbolic-ref --short HEAD 2> /dev/null) || \
  ref=$(git rev-parse --short HEAD 2> /dev/null) || return

  local dirty=""
  if ! git diff --quiet --ignore-submodules HEAD 2>/dev/null; then
    dirty="%F{red}$GIT_DIRTY_ICON%f"
  else
    dirty="%F{green}$GIT_CLEAN_ICON%f"
  fi

  local ahead_behind=""
  if git rev-parse --abbrev-ref @{upstream} &>/dev/null; then
    local ahead=$(git rev-list --count @{upstream}..HEAD 2>/dev/null)
    local behind=$(git rev-list --count HEAD..@{upstream} 2>/dev/null)
    [[ "$ahead" -gt 0 ]] && ahead_behind+=" %F{cyan}$GIT_AHEAD_ICON$ahead%f"
    [[ "$behind" -gt 0 ]] && ahead_behind+=" %F{cyan}$GIT_BEHIND_ICON$behind%f"
  fi

  local stash=""
  if git rev-parse --verify --quiet refs/stash &>/dev/null; then
    stash+=" %F{blue}$GIT_STASH_ICON%f"
  fi

  echo " (%F{magenta}$GIT_BRANCH_ICON $ref%f$dirty$ahead_behind$stash)"
}

# Prompt personalizado
PROMPT='%F{blue}%~%f$(git_prompt_info) %F{green}$PROMPT_ARROW%f '

# Configuração do prompt minimalista para zsh
# setopt PROMPT_SUBST

# Define o prompt:
# - Para usuários normais: "PWD% "
# - Para root: "PWD# "
# PROMPT='%~ %# '

# Explicação dos códigos:
# %~  = Diretório atual (com ~ para HOME)
# %#  = % (usuário normal) ou # (root)
# %F{cor} / %f = Cor do texto / reset
# %B / %b = Negrito / reset

# Custom Aliases (preserved from original)
### Navegation 
alias ls='ls --color=auto'
alias ll='ls -alFth'
alias la='ls -A'
alias l='ls -CF'

### Find
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

### Rsync
alias rsync='rsync -avzP'

### VPN
alias startfwhuge='sudo systemctl start openvpn@client-fwhuge'
alias stopfwhuge='sudo systemctl stop openvpn@client-fwhuge'
alias startpfsensespo='sudo systemctl start openvpn@client-pfsense-spo'
alias stoppfsensespo='sudo systemctl stop openvpn@client-pfsense-spo'

### Text conversion
alias lowercase='function _tolower() { echo "$1" | tr "[:upper:]" "[:lower:]"; }; _tolower'
alias uppercase='function _toupper() { echo "$1" | tr "[:lower:]" "[:upper:]"; }; _toupper'

### Password generator
alias genpass='for i in {1..5}; do tr -dc "A-Za-z0-9" </dev/urandom | head -c 20; echo; done'

### System monitoring
alias netstat='netstat -tulanp'
alias myip='curl ifconfig.me'
alias free='free -h -l -t'
alias http='function _pyserve() { python3 -m http.server ${1:-8000}; }; _pyserve'
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

### Git
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gb='git branch'
alias gco='git checkout'
alias gl='git log --oneline --graph'

### Docker/Kubernetes
alias d='docker'
alias dps='docker ps'
alias dpsa='docker ps -a'
alias di='docker images'
alias drm='docker rm'
alias drmi='docker rmi'
alias dlog='docker logs -f'
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgn='kubectl get nodes'

### Config files
alias vb='vim ~/.bashrc'
alias vz='vim ~/.zshrc'
alias vv='vim ~/.vimrc'
alias vt='vim ~/.tmux.conf'
alias sb='source ~/.bashrc'
alias sz='source ~/.zshrc'

### Vim
alias v='vim -p'

### Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
<<<<<<< HEAD
=======

# Created by `pipx` on 2025-05-30 06:18:40
export PATH="$PATH:/home/bruno-silva/.local/bin"

#autoload -U +X bashcompinit && bashcompinit
#complete -o nospace -C /usr/sbin/vault vault
>>>>>>> fd495ac (adding changes)
