# Colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# no escaping
unsetopt nomatch
# PATH
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# append linux PATH
[ -d $HOME/.local/bin ] && export PATH="$HOME/.local/bin:$PATH"

# append mac PATH
[ -d /Library/Apple/usr/bin ] && export PATH="/Library/Apple/usr/bin:$PATH"
[ -d $HOME/Library/Python/3.9/bin ] && export PATH="$HOME/Library/Python/3.9/bin:$PATH"
[ -d /opt/homebrew ] && export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/:$PATH"
# source files
[ -f $HOME/.zprofile ] && source $HOME/.zprofile
[ -f $HOME/.functions ] && source $HOME/.functions
[ -f $HOME/.zshprompt ] && source $HOME/.zshprompt
[ -f $HOME/.aliases ] && source $HOME/.aliases

precmd() {
    psvar=()

    vcs_info
    [[ -n $vcs_info_msg_0_ ]] && psvar[1]="$vcs_info_msg_0_"
}
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
zstyle ':vcs_info:git:*' formats       '(%b%u%c)'
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c)'
#Completion
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
complete -o nospace -C /opt/homebrew/bin/terraform terraform
# Prompt
setopt PROMPT_SUBST ; PROMPT="%F{blue}%n%f at %F{cyan}%m%f in %F{green}%1~%f"$' %F{red}%1v%f\n'"$ "
# has to be last source
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
