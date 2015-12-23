NB. wizard rpg * part 2 * http://adventofcode.com/day/22

doubleturn=: 4 : 0 NB. x: state, y: spell to choose (ZMDSPR)
  'm h b d sh po re t'=.x [ a=.0
  if. 0>:h=.<:h do. _1 return. end. NB. hard mode
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. po>0 do. b=.b-3 [ po=.<:po if. b<:0 do. t return. end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  select. y NB. below 'else. 0 return.' should cut off 'zero' cases
  case.1 do. if. m>:53 do. m=.m-53 [ t=.t+53 [ b=.b-4 else. 0 return. end.
  case.2 do. if. m>:73 do. m=.m-73 [ t=.t+73 [ b=.b-2 [ h=.h+2 else. 0 return. end.
  case.3 do. if. (m>:113)*.sh=0 do. m=.m-113 [ t=.t+113 [ sh=.6 else. 0 return. end.
  case.4 do. if. (m>:173)*.po=0 do. m=.m-173 [ t=.t+173 [ po=.6 else. 0 return. end.
  case.5 do. if. (m>:229)*.re=0 do. m=.m-229 [ t=.t+229 [ re=.5 else. 0 return. end.
  end.
  if. b<:0 do. t return. end. NB. Player won
  a=.0 NB. Now it's boss's turn
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. po>0 do. b=.b-3 [ po=.<:po if. b<:0 do. t return. end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  h=.h-1>.(d-a)
  if. h<:0 do. _1 return. end. NB. Boss won
  m,h,b,d,sh,po,re,t NB. return state for next turns
)

run=: 3 : 0
  s=. 500 50  55 8  0 0 0  0  NB. mana hits  b-hits b-damage  sh po re  total
  for_c. y do.
    if. 1=# s=. s doubleturn c do. s return. end.
  end.
  0 NB. it seems no winner
)

main=: 3 : 0 NB. y>0 for printing all solutions
  t0=.6!:1'' [ mn=.9999 [ mv=.9$_1 NB. minimum total spent and its spell vector
  sbn=.9999 [ sbv=.9$_1 NB. second best
  NB. removed '0' out of combination to get rid of 'zero' spell
  hh=.>:5 5 5 5#:i.5*5*5*5      NB. same performans as nested loops
  tt=.>:5 5 5 5 5#:i.5*5*5*5*5  NB. just a bit shorter text
  try. NB. to allow ^C
    for_h. hh do. NB. ~head
      ((":h),(5j0":mn),CR) 1!:2[4   NB. show progress...
      for_t. tt do. NB. ~tail
        if. 0< n=. run h,t do.
          if. y>0 do. echo (":h,t),' - ',":n end. NB. show all solutions
          if. n<mn do. mn=.n [ mv=.h,t [ sbn=.mn [ sbv=.mv end.
        end.
      end.
    end.
  catch.
    echo LF
  end.
  sbn;sbv;mn;mv;t0-~6!:1'' NB. return minimum, spells, time elapsed
  2 2$mn;mv NB. return the second best and the best
)

echo main 1 NB. 1289 - 4 2 5 4 3 5 4 2 1 1    1000 sec

exit 0
