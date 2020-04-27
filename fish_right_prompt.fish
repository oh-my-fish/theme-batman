function git::is_stashed
    command git rev-parse --verify --quiet refs/stash >/dev/null
end

function git::print::is_stashed
    if git::is_stashed
        echo (__color_tertiary)"^"(__color_off)
    else
        echo ""
    end
end

function git::branch_name
    if git symbolic-ref --short HEAD >/dev/null 2>&1
        echo (command git symbolic-ref --short HEAD 2> /dev/null)
    else
        echo (command git rev-parse --short HEAD)
    end
end

function git::print::branch_name
    echo (__color_primary)(git::branch_name)
end

function git::is_touched
    test -n (echo (command git status --porcelain))
end

function git::print::is_touched
    if git::is_touched
        echo (__color_tertiary)"*"(__color_off)
    else
        echo ""
    end
end

function git::remote_info

    set -l branch $argv[1]
    set -l remote_name (git config branch.$branch.remote)

    if test -n "$remote_name"
        set merge_name (git config branch.$branch.merge)
        set merge_name_short (echo $merge_name | cut -c 12-)
    else
        set remote_name "origin"
        set merge_name "refs/heads/$branch"
        set merge_name_short $branch
    end

    if test $remote_name = '.' # local
        set remote_ref $merge_name
    else
        set remote_ref "refs/remotes/$remote_name/$merge_name_short"
    end

    set -l rev_git (eval "git rev-list --left-right $remote_ref...HEAD" ^/dev/null)
    if test $status != "0"
        set rev_git (eval "git rev-list --left-right $merge_name...HEAD" ^/dev/null)
    end

    for i in $rev_git
        if echo $i | grep '>' >/dev/null
            set isAhead $isAhead ">"
        end
    end

    set -l remote_diff (count $rev_git)
    set -l ahead (count $isAhead)
    set -l behind (math $remote_diff - $ahead)

    echo $ahead
    echo $behind

end

function git::print::remote_info

    set -l remote (git::remote_info (git::branch_name))
    set -l ahead $remote[1]
    set -l behind $remote[2]

    if test $ahead != "0"
        echo (__color_tertiary)" +"(__color_primary)$ahead
    end

    if test $behind != "0"
        echo (__color_tertiary)" -"(__color_primary)$behind
    end
end

function git::print
    if git rev-parse 2>/dev/null
        echo (git::print::is_stashed)
        echo (__color_secondary)"("
        echo (git::print::is_touched)
        echo (git::print::branch_name)
        echo (git::print::remote_info)
        echo (__color_secondary)") "
        echo (__color_off)
    end
end

function fish_right_prompt
    set -l code $status
    test $code -ne 0; and echo (__color_dim)"("(__color_tertiary)"$code"(__color_dim)") "(__color_off)

    if test -n "$SSH_CONNECTION"
        printf (__color_tertiary)":"(__color_dim)"$HOSTNAME "(__color_off)
    end

    git::print

    printf (__color_dim)(date +%H(__color_primary):(__color_dim)%M(__color_primary):(__color_dim)%S)(__color_off)" "
end
