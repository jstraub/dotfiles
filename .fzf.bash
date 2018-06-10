# Setup fzf
# ---------
if [[ ! "$PATH" == *$HOME/dotfiles/3rdparty/fzf/bin* ]]; then
  export PATH="$PATH:$HOME/dotfiles/3rdparty/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/dotfiles/3rdparty/fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "$HOME/dotfiles/3rdparty/fzf/shell/key-bindings.bash"

