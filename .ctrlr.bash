# export all my commands into log files - great!
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; echo "$(history 1 | sed "s/^ [0-9]\+  //g")" >> ~/.logs/bash-history-all.log; fi; /usr/bin/setxkbmap -option "caps:swapescape"'

# source .fzf 
[ -f ~/dotfiles/.fzf.bash ] && source ~/dotfiles/.fzf.bash

# overwrite the __fzf_history__() function to use my logging system
__fzf_history__() (
  local line
  shopt -u nocaseglob nocasematch
  line=$(
    HISTTIMEFORMAT= ~/dotfiles/history.py |
    FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --tac -n2..,.. --tiebreak=index --bind=ctrl-r:toggle-sort $FZF_CTRL_R_OPTS +m" $(__fzfcmd) |
    command grep '^ *[0-9]') &&
    sed 's/^ *\([0-9]*\)\** *//' <<< "$line"
)
