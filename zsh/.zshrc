# Colors
unset LSCOLORS
export CLICOLOR=1
export CLICOLOR_FORCE=1
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
# no escaping
unsetopt nomatch

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin:/Users/oliver/Library/Python/3.8/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/opt/homebrew/opt/"

[ -f .zprofile ] && source .zprofile
[ -f .functions ] && source .functions

# has to be last source
[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# [ -f .zshprompt ] && source .zshprompt

#Completion
autoload -U +X bashcompinit && bashcompinit
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# Aliases
alias ..="cd .."
alias ll="ls -alhG"
alias ls="ls -G"
alias av="source ./bin/activate"
alias bug="brew update && brew upgrade && brew cu -a -y"
alias cdans="cd /Users/oliver/Documents/code/ansible/ && source ./bin/activate"
alias cdansx="cd /Users/oliver/Documents/code/ansiblex86/ && source ./bin/activate"
# alias cdansx="cd /Users/oliver/Documents/code/ansiblex86/ && source ./bin/activate ; env /usr/bin/arch -x86_64 zsh ./bin/activate"
alias arm=""
alias cdtf="cd /Users/oliver/Documents/code/Terraform"
# Prompt
setopt PROMPT_SUBST ; PROMPT="%F{blue}%n%f at %F{cyan}%m%f in %F{green}%1~%f"$'\n'"$ "

autoload -U +X bashcompinit && bashcompinit

