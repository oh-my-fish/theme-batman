function fish_prompt
  test $status -ne 0;
    and set -l colors 600 900 c00
    or set -l colors 333 666 aaa

  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(__batman_color_fst)"^^"(__batman_color_off)"|g; \
               s|/|"(__batman_color_snd)"/"(__batman_color_off)"|g;  \
               s|"$base"|"(__batman_color_fst)$base(__batman_color_off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(__batman_color_off)

  for color in $colors
    echo -n (set_color $color)">"
  end

  echo -n " "
end
