# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
     export TERM=xterm-256color
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    #PS2='\n >'
# this was my most recent one:
#    PS1='\[\e[1;31m\]\t\[\e[m\] \[\e[1;32m\]\u@\h: \[\e[m\]\[\e[1;33m\]\w\[\e[m\]\[\e[1;32m\]\[\e[m\]\n'
    PS1='\[\e[1;31m\]--\[\e[m\] \n '
    #PS3='\e[m\]'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# export all my commands into log files - great!
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi; /usr/bin/setxkbmap -option "caps:swapescape"'
#export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi; $HOME/bin/3rdparty/tmux-gitbar/update-gitbar 2> /dev/null '

export FOLDER_PRUNE='-type d -name "pod-build" -prune -o -type d -name "build" -prune -o -type d -name ".git" -prune -o'
export CD_FOLDER_PRUNE='-type d -path "*/.*" -prune -o -type d -name "marine" -prune -o'
export VIM_FILE_PRUNE='-name "*png" -prune -o -name "*jpg" -prune -o -name "*~" -prune -o'

# some more ls aliases
alias lll='ls -alFh'
alias ll='ls -alFh'
alias llt='ls -alFhtr'
alias la='ls -A'
alias l='ls -CF'
alias e='vim '
alias cdf='cd $(find . $FOLDER_PRUNE $CD_FOLDER_PRUNE -type d -print | fzf)'
alias cdw='cd $(find -L ./workspace/* -type d | fzf)'
alias cdp='cd $(find -L ./workspace/writing/* -type d | fzf)'
alias cdfh='cd $(find -L ~/* -type d | fzf)'

alias lgrep='ll | grep --color=always'
alias pp='ps axu | grep'
alias aptup='sudo apt-get update; sudo apt-get upgrade'
alias up='cd ../'

alias gst='git status'
alias gitst='git status'
alias gci='git commit -m'
alias gitci='git commit -m'
alias glog='git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
alias gpush='git push'
alias gpull='git pull'

alias ctagsAll='ctags -R --langmap=c++:+.cu.cuh'

alias ta="tmux a -t"
alias tn="tmux new -s"
alias tl="tmux list-sessions"

alias s="source ~/.bashrc"
alias t="task"
alias wt="~/bin/watchTask.sh"
alias tb="task burndown.daily"
alias tp="cd ~/task; git pull && git push; cd -"
alias m="mutt"
alias up="cd ../; pwd"
alias b="cd -"

alias j="vim $HOME/CloudStation/journal/$(date +%F)-entry.md"
alias k="$HOME/bin/lenovoKey; xmodmap $HOME/bin/swapEsc.xmod"

# show battery stats
alias bat="acpi | cut -d, -f 2,3 -"

alias bsource="source ~/.bashrc"

alias nes="ne search"

# install ring tones with: sudo apt-get install ubuntu-touch-sounds
export BEEP=/usr/share/sounds/ubuntu/notifications/Positive.ogg
alias beep="paplay $BEEP"

function tmux-specific(){
TEMP="~/bin/tmux_servers.sh list "$@""
tmux new "$TEMP"
}

alias tmux-all="tmux new '~/bin/tmux_servers.sh all'"
alias tmux-gpu="tmux new '~/bin/tmux_servers.sh gpu"
alias tmux-list='tmux-specific'

export MARKPATH=$HOME/bin/config/.marks
function jump { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
_completemarks() {
  local curw=${COMP_WORDS[COMP_CWORD]}
  local wordlist=$(find $MARKPATH -type l -printf "%f\n")
  COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
  return 0
}

complete -F _completemarks jump unmark

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# use the vim keybindings
set -o vi

# important for using the new vim
export VIMRUNTIME=/usr/share/vim/vim74

export PATH=$HOME/bin:$PATH:/usr/local/cuda/bin
export EDITOR=/usr/bin/vim
export IPYTHONDIR=$HOME/.ipython
export WORKSPACE_HOME=$HOME/workspace

export PYTHONPATH=$PYTHONPATH:$WORKSPACE_HOME/research/python_modules
export PYTHONPATH=$PYTHONPATH:$WORKSPACE_HOME/research/

export BOOST_ROOT=$WORKSPACE_HOME/3rdparty
export BOOST_ROOT=/usr

export CUDA_PATH=/usr/local/cuda

#alias vimf='vim $(find $FOLDER_PRUNE $VIM_FILE_PRUNE -type f -print -o -type l -print | fzf)'
#alias vimf='vim $(find -name "*pdf" -prune -o -name "*jpg" -prune -o  -name "*png" -prune -o  -type d -path "*/.*" -prune -o -name "*~" -prune -o -type f -print -o -type l -print | fzf)'

#alias vimf='vim $(find . -name "*png" -prune -o -name "*jpg" -prune -o -name "*~" -prune -o -name pod-build -prune -o -name build -prune -o -name .git -prune -o -type f -print -o -type d -print -o -type l -print | fzf)'
#alias vimfh='vim $(find -L ~/* -type f | fzf)'
#alias pgrep='ps axu | grep --color=always'

alias vimf='FILE=$(find -name "*pdf" -prune -o -name "*jpg" -prune -o -name "*png" -prune -o  -type d -path "*/.*" -prune -o -name "*~" -prune -o -type f -print -o -type l -print | fzf); if [ $? -eq 0 ]; then /usr/bin/vim $FILE; fi'
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
