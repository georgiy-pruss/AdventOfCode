NB. wrapping paper area

split =: ' '&$: : (<;._2 @(,~))
clean =: 13 : '(-(13{a.)={:y) }. y'

main =: 3 : 0
  if.y-:'-'do.t=.1!:1(3)else.t=.1!:1<y end. s=.0
  for_l. (10{a.) split t do.
    if. 5<:#>l do.
      minp =. <./ prods =. 2 */\ 4$ (".&clean&>)"0 'x' split >l
      s=.s+minp + +: +/prods
    end.
  end.
  s
)

echo main >2{ARGV   NB. arg can be '-' for input or name of file
exit 0
