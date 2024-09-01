export BAT_CONFIG_PATH="$HOME/.dotfiles/bat/config"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/.vimrc" | source $MYVIMRC'

# Colors
#unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
setopt HIST_IGNORE_SPACE  # Don't save when prefixed with space
setopt HIST_IGNORE_DUPS   # Don't save duplicate lines
setopt SHARE_HISTORY      # Share history between sessions
setopt extended_glob null_glob
# no escaping
unsetopt nomatch
# deactivate venv prompt mangling
export VIRTUAL_ENV_DISABLE_PROMPT=1
export LESSHISTFILE="$XDG_STATE_HOME"/less/history

function virtualenv_info { 
    if [[ -n "$VIRTUAL_ENV" ]]; then
		vpr="(v)";
	else
		vpr="";
fi;
}

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# append linux PATH
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"

# append mac PATH
if [[ "$OSTYPE" == darwin* ]]; then
  [ -d /Library/Apple/usr/bin ] && export PATH="/Library/Apple/usr/bin:$PATH"
  [ -f /opt/homebrew/bin/brew ] &&  eval $(/opt/homebrew/bin/brew shellenv)
  [ -d $(brew --prefix)/share/zsh/site-functions ] && FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# ZINIT 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
# Zinit Plugins
zinit load zdharma-continuum/history-search-multi-word
zinit light zsh-users/zsh-autosuggestions
zinit light zdharma-continuum/fast-syntax-highlighting
# ZSH Autosuggest Settings
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#818181,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Load compinit
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
zinit cdreplay -q

# source files
[ -f $HOME/.env ] && source $HOME/.env
[ -f $XDG_CONFIG_HOME/.aliases ] && source $XDG_CONFIG_HOME/.aliases
[ -f $XDG_CONFIG_HOME/.functions ] && source $XDG_CONFIG_HOME/.functions
[ -f $XDG_CONFIG_HOME/zsh/.zshprompt ] && source $XDG_CONFIG_HOME/zsh/.zshprompt
[ -f $XDG_CONFIG_HOME/zsh/vcs_info.zsh ] && source $XDG_CONFIG_HOME/zsh/vcs_info.zsh
[ -f $HOME/.dotfiles/exa/exa.conf ] && source $HOME/.dotfiles/exa/exa.conf
[ -f $XDG_CONFIG_HOME/fzf/.fzf.zsh ] && source /$XDG_CONFIG_HOME/fzf/.fzf.zsh


precmd() {
    _update_vcs_info_msg;
	virtualenv_info
}
if [[ -n "$SSH_CLIENT" ]]; then
	hostStyle="%B%m%b";
else
	hostStyle="%m";
fi;


#Completion
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
# Prompt
setopt PROMPT_SUBST ; PROMPT="%F{245}┌── ${OS_LOGO} %f%F{blue}%n%f%F{245} at %f%F{51}${hostStyle}%f%F{245} in %f%F{green}%1~%f"$'\n%F{245}└─%f'"%F{245}$ %f"

