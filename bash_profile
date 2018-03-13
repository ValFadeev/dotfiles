# Env

export EDITOR=vim
export SCALA_HOME=/usr/local/scala
export GOPATH="$HOME/go"
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH="$PATH:/usr/local/Cellar/python3/3.6.4_2/bin"
export PATH="$PATH:$HOME/Library/Haskell/bin:$SCALA_HOME/bin:$GOPATH/bin"
export PATH="$PATH:$HOME/.local/bin"
export WORKON="$HOME/.virtualenvs"
# https://news.ycombinator.com/item?id=14520194
export HISTCONTROL=ignoreboth
export FZF_DEFAULT_COMMAND='ag -g ""'

# Completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi
#

. /usr/local/bin/virtualenvwrapper.sh

# Shortcuts
alias bpe="$EDITOR $HOME/.bash_profile"
alias clc="git rev-parse HEAD | pbcopy"
alias dld="docker login \$PRIVATE_DOCKER_REGISTRY"
alias drd="docker rmi \$(docker images -qf dangling=true)"
alias dre="docker rm \$(docker ps -aq -f status=exited)"
alias dvc="docker volume rm \$(docker volume ls -qf dangling=true)"
alias fuck="sudo !!"
alias https="http --default-scheme=https"
alias ihaskell="docker run -it --volume $(pwd):/notebooks --publish 8888:8888 gibiansky/ihaskell:latest"
alias la="ls -al"
alias lh="ls -alh"
#alias python="python2"
alias ref="source $HOME/.bash_profile"
alias sce="$EDITOR $HOME/.ssh/config"
alias stand="docker-compose"
alias vgd="vagrant destroy"
alias vgh="vagrant halt"
alias vgr="vagrant reload"
alias vgs="vagrant ssh"
alias vgu="vagrant up"
alias vre="$EDITOR $HOME/.vimrc"


export MINIKUBE_WANTUPDATENOTIFICATION=false
export MINIKUBE_WANTREPORTERRORPROMPT=false
export MINIKUBE_HOME=$HOME
export CHANGE_MINIKUBE_NONE_USER=true
export KUBECONFIG=$HOME/.kube/config

fp () {
    # get ssh key fingerprint
    if [[ $# -lt 1 ]]; then
        echo 'usage: fp [hashing_algorithm] <key_file>'
        echo 'error: too few arguments'
    else
        if [[ $# -eq 1 ]]; then
            ssh-keygen -E SHA256 -lf $1
        else
            local alg="$(echo "$1" | tr '[:lower:]' '[:upper:]')"
            ssh-keygen -E "${alg}" -lf $2
        fi
    fi
}


uuid () {
    uuidgen | tr '[:upper:]' '[:lower:]'
}

viewcert () {
  if [[ $1 && ${1-x} ]]; then
    openssl s_client -showcerts -connect "$1":443 </dev/null
  else
    >&2 echo "Usage: viewcert <fully_qualified_domain_name>"
  fi
}

pem2crt () {
  openssl x509 -in "$1.pem" -inform PEM -out "$1.crt"
}

# Vim
alias vim="mvim -v -c NERDTreeToggle"
#
alias make="/usr/local/Cellar/make/4.2.1_1/bin/gmake"

#if [[ -d ".terraform" ]]; then
#  TF_WP=$(terraform workspace show)
#fi
#export PS1="${TF_WP}"
# Git
GIT_PROMPT_ONLY_IN_REPO=1
# GIT_PROMPT_FETCH_REMOTE_STATUS=0   # uncomment to avoid fetching remote status

#GIT_PROMPT_SHOW_UPSTREAM=1 # uncomment to show upstream tracking branch
# GIT_PROMPT_SHOW_UNTRACKED_FILES=all # can be no, normal or all; determines counting of untracked files

# GIT_PROMPT_STATUS_COMMAND=gitstatus_pre-1.7.10.sh # uncomment to support Git older than 1.7.10

#GIT_PROMPT_START=${TF_WP}    # uncomment for custom prompt start sequence
# GIT_PROMPT_END=...      # uncomment for custom prompt end sequence

# as last entry source the gitprompt script
# GIT_PROMPT_THEME=Custom # use custom .git-prompt-colors.sh
GIT_PROMPT_THEME=Solarized # use theme optimized for solarized color scheme

if [ -f "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh" ]; then
    source "$(brew --prefix)/opt/bash-git-prompt/share/gitprompt.sh"
fi

alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

source ~/.bashrc
source $HOME/.bash_profile.d/*
