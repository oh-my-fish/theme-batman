function fish_prompt
  test $status -ne 0;
    and set -l colors 600 900 c00
    or set -l colors 333 666 aaa

  set -l pwd (prompt_pwd)
  set -l base (basename "$pwd")

  set -l expr "s|~|"(fst)"^^"(off)"|g; \
               s|/|"(snd)"/"(off)"|g;  \
               s|"$base"|"(fst)$base(off)" |g"

  echo -n (echo "$pwd" | sed -e $expr)(off)

  for color in $colors
    echo -n (set_color $color)">"
  end

set -q VIRTUAL_ENV
  test $status -ne 0;
    and set -l colors blue blue --bold
    or set -l colors red red --bold

  for color in $colors
    echo -n (set_color $color)">"
  end
                       
  echo -n " " 
end 
