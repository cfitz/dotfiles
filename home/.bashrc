 export PATH=/usr/local/opt/postgresql/bin:$PATH 
source /usr/local/share/chruby/chruby.sh
chruby ruby-2.0.0-p247 

# source global definitions
if [ -f /etc/bashrc ]; then
    source /etc/bashrc
fi

if [ -f /etc/google_creds ]; then
    source /etc/google_creds
fi

# sets shell options
shopt -s cdspell checkwinsize
# shopt -s globstar extglob extquote
shopt -s histappend cmdhist
set -o vi

# sets history variables
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

# sets title for terminal tab
nametab () {
    echo -ne "\033]0;"$@"\007"
}

# updates vim plugins to latest master commit
update_vim_plugins () {
    if [ -d ~/.vim ]; then
        cd "$(readlink -n ~/.vim)/../.."
        git submodule foreach 'git fetch origin; git checkout master'
    fi
}

alias ll='ls -Al'
alias h='history'

bind -x '"\C-l": clear'

# enables color support
CLICOLOR=1
LS_COLORS='no=0:di=34:fi=0:ln=35:ex=31:so=32:pi=33'
test $(uname) = 'Linux' && alias ls='ls --color=auto'
alias grep='grep --color=auto'

#EDITOR=vim
PS1='\[\e[32m\]\h:\W$\[\e[0m\] '
PATH=~/bin:/usr/local/bin:/usr/local/share/npm/bin:$PATH


# sources bash completion scripts
if [ -e /usr/local/bin/brew ] && [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# configures shell for rbenv if installed
if hash rbenv 2>/dev/null; then
    PATH=~/.rbenv/shims:~/.rbenv/bin:$PATH
    rbenv rehash
fi

export CLICOLOR EDITOR PS1 PATH LS_COLORS

# sources local definitions
if [ -f ~/.bashrc.local ]; then
    source ~/.bashrc.local
fi
