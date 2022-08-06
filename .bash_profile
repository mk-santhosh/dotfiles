eval `keychain --eval --agents ssh --inherit any id_rsa`
source $HOME/.keychain/$HOSTNAME-sh

# autocomplete ssh hosts configured in ~/.ssh/config

_ssh()
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh
complete -F _ssh scp

# Shortcuts for work and personal directory
alias  work="cd /Users/mksanthosh/D/Work"
alias  per="cd /Users/mksanthosh/OneDrive/Personal"
alias ecwork="cd /Users/mksanthosh/Documents/workspace"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ll="ls -Flah"
#alias curl="function () { docker run --rm -it curl $@ }""

if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ]; then
  . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
fi

if [ ! -e "/Applications/Docker.app/Contents/Resources/etc/docker.bash-completion" ]; then
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
fi

if ! [ -e "/Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion" ]; then
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-machine.bash-completion
fi

if ! [ -e "/Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion" ]; then
  ln -s /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
fi

function stopdock() {
    docker stop $(docker ps -aq)
    docker ps
}

export -f stopdock

function composer() {
    docker run -it --rm -v $PWD:/app -v $HOME/.ssh:/root/.ssh composer/composer:alpine "$@"
}

function parse_git_branch()
{
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

PS1='${debian_chroot:+($debian_chroot)}\[$(tput setaf 3)\](\t)\[$(tput bold)\]\[$(tput setaf 1)\][\h]\[$(tput setaf 7)\] \w \[$(tput setaf 2)\][$(parse_git_branch)]\n\[$(tput setaf 1)\]\$ \[$(tput sgr0)\]'

# Variables for React-Native android app
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Variables for Gradle Home
export GRADLE_HOME=/usr/local/opt/gradle/libexec
export PATH=$GRADLE_HOME/bin:$PATH

# Java Home
export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home

export NVM_DIR="$HOME/.nvm"
    [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh" # This loads nvm
    [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion

