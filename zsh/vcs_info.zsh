
autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*' unstagedstr '-'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' formats       '%r' '%c%u' '%m'
zstyle ':vcs_info:*' actionformats '%r' '%c%u %m' '<!%a>'
zstyle ':vcs_info:*' use-simple true
zstyle ':vcs_info:git+set-message:*' hooks git-hook-begin git-untracked git-push-status git-nomerge-branch git-stash-count

function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # hook functions after this will not be called if not 0 is returned.
            return 1
        fi

        return 0
    }

    # Showing untracked files
    #
    # Append '?' to `unstaged (%u)` if there are any untracked files.
    function +vi-git-untracked() {
        # targets 2nd message in zstyle formats, actionformats
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1 ; then

            # Append to unstaged (%u)
            hook_com[unstaged]+='?'
        fi
    }

    # Showing number of commits that aren't pushed yet.
    #
    # Append 'pN', N is a number of un-pushed commits, to `misc (%m)`
    function +vi-git-push-status() {
        # targets 2nd message in zstyle formats, actionformats
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # Do nothing if it is not master branch
            return 0
        fi

        # get number of commits that un-pushed
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # Append to misc (%m)
            hook_com[misc]+="(p${ahead})"
        fi
    }

    # Show unmerged commits
    #
    # Show mN in misc (%m). N is number of commits in current branch that is not merged to master.
    function +vi-git-nomerge-branch() {
        # targets 2nd message in zstyle formats, actionformats
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # Do nothing if it is master branch
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # Append to misc (%m)
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # Show stashes
    #
    # Show :SN in misc (%m). N is a number of stashes
    function +vi-git-stash-count() {
        # targets 2nd message in zstyle formats, actionformats
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # Append to misc (%m)
            hook_com[misc]+=":S${stash}"
        fi
    }


function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # No prompt is shown if no information from vcs_info
        prompt="$default_rprompt"
    else
        # If there are some information from vcs_info, 
        # show $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # concatenate them separated with space
        prompt="${(j: :)messages} $default_rprompt"
    fi

    RPROMPT="%F{red}${vpr}%f$prompt%F{245}%T%f"
}
