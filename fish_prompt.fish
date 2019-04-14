function fish_prompt
  test $status -ne 0;
  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(__batman_color_fst)"^^"(__batman_color_off)"|g; \
               s|/|"(__batman_color_snd)"/"(__batman_color_off)"|g;  \
               s|"$base"|"(__batman_color_fst)$base(__batman_color_off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(__batman_color_off)

test $status -ne 1;
set -q VIRTUAL_ENV
  and set -l colors cc6666 cc6666 --bold
  or set -l colors 81a2be 81a2be --bold

  for color in $colors
    echo -n (set_color $color)">"
  end

  echo -n " "
end
