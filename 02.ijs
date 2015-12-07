NB. wrapping paper area and ribbon length http://adventofcode.com/day/2

split =: ' '&$: : (<;._2 @(,~))
clean =: 13 : '(-(13{a.)={:y) }. y'

main =: 3 : 0
  if.y-:'-'do.t=:1!:1(3)else.t=:1!:1<y end. s=.r=.0
  for_l. (10{a.) split t do.
    if. 5<:#>l do.
      minp=. <./ prods=. 2 */\ 4$ sides=. (".&clean&>)"0 'x' split >l
      s=. s+ minp + +: +/prods
      r=. r+ (*/sides) + +: <./ 2 +/\ 4$ sides
    end.
  end.
  s,r
)

echo main >2{ARGV
exit 0
