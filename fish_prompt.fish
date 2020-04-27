function fish_prompt
    test $status -ne 0
        and set -l colors 600 900 c00
        or set -l colors 333 666 aaa

    set -l pwd (prompt_pwd)
    set -l base (basename "$pwd")

    set -l expr "s|~|"(__color_primary)"^^"(__color_off)"|g; \
               s|/|"(__color_secondary)"/"(__color_off)"|g;  \
               s|"$base"|"(__color_primary)$base(__color_off)" |g"

    echo -n (echo "$pwd" | sed -e $expr)(__color_off)

    for color in $colors
        echo -n (set_color $color)">"
    end

    echo -n " "
end
