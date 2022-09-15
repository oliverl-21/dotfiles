# Colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# no escaping
unsetopt nomatch

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/oliver/Library/Python/3.9/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/"

[ -f .zprofile ] && source .zprofile
[ -f .functions ] && source .functions
[ -f .zshprompt ] && source .zshprompt
[ -f .aliases ] && source .aliases

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