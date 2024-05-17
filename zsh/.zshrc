export XDG_CONFIG_HOME="$HOME/.config"
# Colors
#unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
setopt HIST_IGNORE_ALL_DUPS
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
# ZINIT 
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# append linux PATH
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"

# append mac PATH
[ -d /Library/Apple/usr/bin ] && export PATH="/Library/Apple/usr/bin:$PATH"
[ -d $HOME/Library/Python/3.9/bin ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"
[ -f /opt/homebrew/bin/brew ] &&  eval $(/opt/homebrew/bin/brew shellenv)
[ -d $HOMEBREW_PREFIX/share/zsh/site-functions ] && FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
autoload -Uz +X compinit && compinit
autoload -Uz +X bashcompinit && bashcompinit
# setopt complete_aliases


# source files
[ -f $HOME/.env ] && source $HOME/.env
[ -f $XDG_CONFIG_HOME/.exports ] && source $XDG_CONFIG_HOME/.exports
[ -f $XDG_CONFIG_HOME/.aliases ] && source $XDG_CONFIG_HOME/.aliases
[ -f $XDG_CONFIG_HOME/zsh/.zprofile ] && source $XDG_CONFIG_HOME/zsh/.zprofile
[ -f $XDG_CONFIG_HOME/.functions ] && source $XDG_CONFIG_HOME/.functions
[ -f $XDG_CONFIG_HOME/zsh/.zshprompt ] && source $XDG_CONFIG_HOME/zsh/.zshprompt
[ -f $XDG_CONFIG_HOME/zsh/vcs_info.zsh ] && source $XDG_CONFIG_HOME/zsh/vcs_info.zsh
[ -f $HOME/.dotfiles/exa/exa.conf ] && source $HOME/.dotfiles/exa/exa.conf
[ -f $XDG_CONFIG_HOME/fzf/.fzf.zsh ] && source /$XDG_CONFIG_HOME/fzf/.fzf.zsh
# ZSH Autosuggest
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh ] && source $HOMEBREW_PREFIX/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#818181,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
#
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

# has to be last source
# macOS
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Linux
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
