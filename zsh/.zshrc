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
[ -d /Library/Apple/usr/bin ] && export PATH="/Library/Apple/usr/bin:$PATH"
[ -d $HOME/Library/Python/3.9/bin ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"
[ -d /opt/homebrew ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/:$PATH"
# source files
[ -f $HOME/.env ] && source $HOME/.env
[ -f $HOME/.aliases ] && source $HOME/.aliases
[ -f $HOME/.zprofile ] && source $HOME/.zprofile
[ -f $HOME/.functions ] && source $HOME/.functions
[ -f $HOME/.zshprompt ] && source $HOME/.zshprompt
[ -f $HOME/.dotfiles/zsh/vcs_info.zsh ] && source $HOME/.dotfiles/zsh/vcs_info.zsh
[ -f $HOME/.dotfiles/exa/exa.conf ] && source $HOME/.dotfiles/exa/exa.conf
# ZSH 
[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

precmd() {
    _update_vcs_info_msg;
	virtualenv_info
}

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#818181,bold,underline"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#Completion
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
complete -o nospace -C /opt/homebrew/bin/terraform terraform
# Prompt
setopt PROMPT_SUBST ; PROMPT="%F{245}┌──  %f%F{blue}%n%f%F{245} at %f%F{51}${hostStyle}%f%F{245} in %f%F{green}%1~%f"$'\n%F{245}└─%f'"%F{245}$ %f"

# has to be last source
# macOS
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Linux
[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh