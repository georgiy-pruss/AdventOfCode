NB. circuit emulator http://adventofcode.com/day/7

split1=: <;._2@,~
rstrip=: (1 + 0 i:~ [: +./ =/) {. ]

n =: 0$<''  NB. var name
v =: 0$_1   NB. value; _1 undef, 0..65536 ok
t =: 0$'.'  NB. one of '=' a  'N' not a  'A' a&b  'O' a|b  'L' a<<b  'R' a>>b
a =: b =: 0$<'' NB. left (or only) and right operand

read =: 3 : 0 NB. parse "program" and fill in n,t,a,b
  for_l. y do.
    select. # k=. ' ' split1 l=. (13 32{a.) rstrip >l
    case. 3 do. n=:n,2{k [ v=:v,_1 [ t=:t,'='    [ a=:a,0{k [ b=:b,<'' [ assert '->'-:>1{k
    case. 4 do. n=:n,3{k [ v=:v,_1 [ t=:t,{.>0{k [ a=:a,1{k [ b=:b,<'' [ assert '->'-:>2{k
    case. 5 do. n=:n,4{k [ v=:v,_1 [ t=:t,{.>1{k [ a=:a,0{k [ b=:b,2{k [ assert '->'-:>3{k
    end.
  end.
)

XOR=: 22 b. [ AND=: 17 b. [ OR=:  23 b. [ SHL=: 33 b.

calc =: 3 : 0 NB. y - boxed name or literal, e.g. <,'a' <'ab' <'123'
  NB. echo 'calc ',>y
  z=. _1".>y if. z~:_1 do. z return. end.
  i =. n i. y if. i=#n do. _1 [ echo (>y),' not found' return. end.
  NB. echo (":i),' i{t ',(":i{t),' s: ',>i{s
  if. 0<:i{v do. i{v return. end.
  select. i{t
  case. '=' do. z=. calc i{a                 case. 'N' do. z=. 16bffff XOR calc i{a
  case. 'A' do. z=. (calc i{a) AND calc i{b  case. 'L' do. z=. (calc i{b) SHL calc i{a
  case. 'O' do. z=. (calc i{a) OR calc i{b   case. 'R' do. z=. (-calc i{b) SHL calc i{a
  end.
  z [ v=: z i}v NB. save calculated value and return it
)

read LF split1 1!:1 {:ARGV
echo z=. calc <,'a'
v=: z (n i.<,'b') } ($v)$_1 NB. reset the values and use the prev. result as 'b'
echo calc <,'a'
exit 0

0 : 0
--- Day 7: Some Assembly Required ---

This year, Santa brought little Bobby Tables a set of wires and bitwise logic gates! Unfortunately, little Bobby is a little under the recommended age range, and he needs help assembling the circuit.

Each wire has an identifier (some lowercase letters) and can carry a 16-bit signal (a number from 0 to 65535). A signal is provided to each wire by a gate, another wire, or some specific value. Each wire can only get a signal from one source, but can provide its signal to multiple destinations. A gate provides no signal until all of its inputs have a signal.

The included instructions booklet describes how to connect the parts together: x AND y -> z means to connect wires x and y to an AND gate, and then connect its output to wire z.

For example:

    123 -> x means that the signal 123 is provided to wire x.
    x AND y -> z means that the bitwise AND of wire x and wire y is provided to wire z.
    p LSHIFT 2 -> q means that the value from wire p is left-shifted by 2 and then provided to wire q.
    NOT e -> f means that the bitwise complement of the value from wire e is provided to wire f.

Other possible gates include OR (bitwise OR) and RSHIFT (right-shift). If, for some reason, you'd like to emulate the circuit instead, almost all programming languages (for example, C, JavaScript, or Python) provide operators for these gates.

For example, here is a simple circuit:

123 -> x
456 -> y
x AND y -> d
x OR y -> e
x LSHIFT 2 -> f
y RSHIFT 2 -> g
NOT x -> h
NOT y -> i

After it is run, these are the signals on the wires:

d: 72
e: 507
f: 492
g: 114
h: 65412
i: 65079
x: 123
y: 456

In little Bobby's kit's instructions booklet (provided as your puzzle input), what signal is ultimately provided to wire a?

Your puzzle answer was 956.
--- Part Two ---

Now, take the signal you got on wire a, override wire b to that signal, and reset the other wires (including wire a). What new signal is ultimately provided to wire a?

Your puzzle answer was 40149.

Both parts of this puzzle are complete! They provide two gold stars: **
)
