# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in 	)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-nvm z common-aliases git-extras npm osx docker docker-compose node terraform sublime web-search zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#. /usr/local/etc/profile.d/z.sh

# Zaw path
#source "/Users/${USER}/.tools/zaw/zaw.zsh"

export PATH=$PATH:/Users/shamim/bin

autoload -U bashcompinit && bashcompinit
source <(kubectl completion zsh)

if [ -f ~/.gnupg/.gpg-agent-info ] && [ -n "$(pgrep gpg-agent)" ]; then
    source ~/.gnupg/.gpg-agent-info
    export GPG_AGENT_INFO
    GPG_TTY=$(tty)
    export GPG_TTY
else
    eval $(gpg-agent --daemon ~/.gnupg/.gpg-agent-info)
fi

# add syntax highlighting
#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export KUBECONFIG=~/.kube/config:~/.kube/ekskubeconfig

alias kdev='kubectl config set current-context dev-master'
alias kuat='kubectl config set current-context uat-master'
alias kprod='kubectl config set current-context prod-master'

alias devproxykube='kdev && kubectl proxy -p 8000'
alias uatproxykube='kuat && kubectl proxy -p 8880'
alias prodproxykube='kprod && kubectl proxy -p 8888'

alias kubeproxy='devproxykube & uatproxykube & prodproxykube &'


alias akdev='kubectl config set current-context dev'
alias akuat='kubectl config set current-context k8s-uat'
alias akprod='kubectl config set current-context prod'

alias adevproxykube='akdev && kubectl proxy -p 9000'
alias auatproxykube='akuat && kubectl proxy -p 9990'
alias aprodproxykube='akprod && kubectl proxy -p 9999'

alias akubeproxy='adevproxykube & auatproxykube & aprodproxykube &'

alias eksdev='kubectl config set current-context eks-dev'
alias eksuat='kubectl config set current-context eks-uat'
alias eksprod='kubectl config set current-context eks-prod'

alias eksdevproxykube='eksdev && kubectl proxy -p 4000'
alias eksuatproxykube='eksuat && kubectl proxy -p 4440'
alias eksprodproxykube='eksprod && kubectl proxy -p 4444'

alias ekskubeproxy='eksdevproxykube & eksuatproxykube & eksprodproxykube &'


source /Users/shamim/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
export PATH=~/.local/bin:$PATH
source ~/.bash_profile

autoload -U +X bashcompinit && bashcompinit
complete -C /usr/local/Cellar/terraform/0.11.0/bin/terraform terraform
alias k='kubectl'
export ANDROID_HOME=~/Library/Android/sdk
complete -o nospace -C /usr/local/bin/vault vault
