NB. circuit emulator http://adventofcode.com/day/7

split1=: <;._2@,~
rstrip=: (1 + 0 i:~ [: +./ =/) {. ]
contains=: +./@:E.~
startswith=: ] -: ({.~ #)

v =: 0$<''  NB. var
t =: 0$_1   NB. _1 undef  0 ready  1 a  2 not a  3 a&b  4 a|b  5 a<<b  6 a>>b
a =: 0$<''  NB. numeric value if ready
b =: 0$<''
s =: 0$<''  NB. source line

main1 =: 3 : 0
  for_l. y do.
    n=. # k=. ' ' split1 l=. (13 32{a.) rstrip >l
    if. n=3 do. assert '->'-:>1{k
      v=:v,2{k
      t=:t,1
      a=:a,0{k
      b=:b,<''
      s=:s,<(>2{k),'=',(>0{k)
    elseif. n=4 do. assert ('NOT'-:>{.k) *. '->'-:>2{k
      v=:v,3{k
      t=:t,2
      a=:a,1{k
      b=:b,<''
      s=:s,<(>3{k),'=~',(>1{k)
    elseif. n=5 do. assert '->'-:>3{k
      v=:v,4{k
      a=:a,0{k
      b=:b,2{k
      select. >1{k
      case. 'AND'    do. t=:t,3
      case. 'OR'     do. t=:t,4
      case. 'LSHIFT' do. t=:t,5
      case. 'RSHIFT' do. t=:t,6
      end.
      s=:s,<(>4{k),'=',(>0{k),' ',(>1{k),' ',(>2{k)
    end.
  end.
)

XOR=: 22 b.
AND=: 17 b.
OR=:  23 b.
LSH=: 33 b.

calc =: 3 : 0 NB. y - boxed name
  NB. echo 'calc ',>y
  i =. v i. y
  NB. echo (":i),' i{t ',(":i{t),' s: ',>i{s
  if. i=#v do. echo (>y),' not found'
    _1 return. end.
  z =. _1
  select. i{t
  case. 0 do. z=. >i{a
  case. 1 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
    t=: 0 i}t
    a=: (<z) i}a
  case. 2 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
    t=: 0 i}t
    a=: (<z=. 16bffff XOR z) i}a
  case. 3 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
    w=. _1".> i{b if. w=_1 do. w=. calc i{b end.
    t=: 0 i}t
    a=: (<z=. z AND w) i}a
  case. 4 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
              w=. _1".> i{b if. w=_1 do. w=. calc i{b end.
    t=: 0 i}t
    a=: (<z=. z OR w) i}a
  case. 5 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
              w=. _1".> i{b if. w=_1 do. w=. calc i{b end.
    t=: 0 i}t
    a=: (<z=. w LSH z) i}a
  case. 6 do. z=. _1".> i{a if. z=_1 do. z=. calc i{a end.
              w=. _1".> i{b if. w=_1 do. w=. calc i{b end.
    t=: 0 i}t
    a=: (<z=. (-w) LSH z) i}a
  end.
  z
)

main2 =: 3 : 0
  _1
)

txt=. LF split1 1!:1 [2{ARGV
main1 txt
echo calc <,'a'
NB. echo t
NB. echo a
NB. echo b
echo main2 txt
exit 0
