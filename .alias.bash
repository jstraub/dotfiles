
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    #alias pgrep='ps axu | grep --color=always'
fi

alias vimf='FILE=$(fzf); if [ $? -eq 0 ]; then /usr/bin/vim $FILE; fi'

# some more ls aliases
alias lll='ls -alFh'
alias ll='ls -alFh'
alias llt='ls -alFhtr'
alias la='ls -A'
alias l='ls -CF'
alias e='vim '
alias cdf='cd $(fzf)'

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

export MARKPATH=$HOME/.marks
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

