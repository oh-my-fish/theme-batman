function fish_prompt
  test $status -ne 0;
  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(fst)"^^"(off)"|g; \
               s|/|"(snd)"/"(off)"|g;  \
               s|"$base"|"(fst)$base(off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(off)

test $status -ne 1;
set -q VIRTUAL_ENV
  and set -l colors cc6666 cc6666 --bold
  or set -l colors 81a2be 81a2be --bold

  for color in $colors
    echo -n (set_color $color)">"
  end

  echo -n " "
end
