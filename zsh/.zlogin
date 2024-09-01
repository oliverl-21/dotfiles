# export GVIMINIT='let $MYGVIMRC="$XDG_CONFIG_HOME/vim/gvimrc" | source $MYGVIMRC'
# export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
# Nix!
[ -f $XDG_CONFIG_HOME/nix/nix.conf ] && export NIX_CONF_DIR=$HOME/.config/nix
