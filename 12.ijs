NB. sum all numbers http://adventofcode.com/day/12

split1=: <;._2@,~
dcr=: ] }.~ [: - CR = {:  NB. drop last cr; dtb = drop trailing blanks

main1 =: 3 : 0
  a=.'abcdefghijklmnopqrstuvwxyz"'',[]{}:',CRLF
  t=.".('-';'_')rplc~' '((i.#y)#~+./a=/y)}y
  (":t) 1!:2 <'1.txt'
  +/t
)

load 'convert/json'

calc =: 3 : 0
  s=.'?'[t=.3!:0 y
  select. t
  case. 1 do. s=.'boolean'
  case. 2 do. s=.'literal'
  case. 4 do. s=.'integer'
  case. 8 do. s=.'floating'
  case. 16 do. s=.'complex'
  case. 32 do. s=.'boxed'
  case. 64 do. s=.'extended'
  case. 128 do. s=.'rational'
  case. 65536 do. s=.'symbol'
  case. 131072 do. s=.'unicode'
  end.
  if. t e. 1 4 8 do.
  o=:o,y
  y return.end.
  if. 32=t do.
    if. (2={.$y) *. 2=#$y do.
      z=.0
      for_x. 1{y do.
        z=.z+calc >x
      end.
      z
      return.
    elseif. 1=#$y do.
      z=.0
      for_x. y do.
        z=.z+calc >x
      end.
      z
      return.
    end.
  end.
  NB. echo s
  0
)

main2 =: 3 : 0
  j=. dec_json y
  NB. echo j
  o=:0$0
  ret=.calc j
  (":o) 1!:2 <'2.txt'
  ret
)

echo main1 1!:1 {:ARGV
echo main2 1!:1 {:ARGV
exit 0

0 : 0
)
