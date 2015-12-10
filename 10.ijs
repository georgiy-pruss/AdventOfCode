NB. look-n-say http://adventofcode.com/day/10

lns =: 3 : 0
  r =. ''
  c =. {.y
  n =. 1
  for_ab. 2[\y do.
    if. =/ab do.
      n=.>:n
    else.
      r=. r, (":n),c
      n=.1
      c=.{:ab
    end.
  end.
  r, (":n),c
)

main =: 4 : '# lns^:x y'

echo 40 main '3113322113'
echo 50 main '3113322113'
exit 0

