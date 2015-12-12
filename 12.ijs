NB. sum all numbers in json http://adventofcode.com/day/12

load 'convert/json' NB. for part2 only

part1 =: 3 : 0 NB. replace all non-digits to spaces, replace '-' to '_', do +/".
  a=.'abcdefghijklmnopqrstuvwxyz"'',[]{}:',CRLF
  +/". ('-';'_')rplc~ ' '((i.#y)#~+./a=/y)}y
)

calc =: 3 : 0 NB. calculate sum of one cell (can be atom or box list or box table)
  t=.3!:0 y NB. type: 1 bool, 4 int, 8 float, 32 boxed, others are not counted
  if. t e. 1 4 8 do. y return.end. NB. 0 and 1 come here as boolean
  if. 32~:t do. 0 return.end.
  if. (2={.$y) *. 2=#$y do. if. -.(<'red')e.{:y do. +/ (calc@>)"0 {:y return.end.end.
  if. 1=#$y do. +/ (calc@>)"0 y else. 0 end.
)

part2 =: 3 : 'calc dec_json y'

echo part1 1!:1 {:ARGV
echo part2 1!:1 {:ARGV
exit 0

0 : 0
--- Day 12: JSAbacusFramework.io ---

Santa's Accounting-Elves need help balancing the books after a recent order.
Unfortunately, their accounting software uses a peculiar storage format.
That's where you come in.

They have a JSON document which contains a variety of things: arrays ([1,2,3]),
objects ({"a":1, "b":2}), numbers, and strings. Your first job is to simply find
all of the numbers throughout the document and add them together.

For example:

    [1,2,3] and {"a":2,"b":4} both have a sum of 6.
    [[[3]]] and {"a":{"b":4},"c":-1} both have a sum of 3.
    {"a":[-1,1]} and [-1,{"a":1}] both have a sum of 0.
    [] and {} both have a sum of 0.

You will not encounter any strings containing numbers.

What is the sum of all numbers in the document?

Your puzzle answer was 111754.
--- Part Two ---

Uh oh - the Accounting-Elves have realized that they double-counted everything red.

Ignore any object (and all of its children) which has any property with the value
"red". Do this only for objects ({...}), not arrays ([...]).

    [1,2,3] still has a sum of 6.
    [1,{"c":"red","b":2},3] now has a sum of 4, because the middle object is ignored.
    {"d":"red","e":[1,2,3,4],"f":5} now has a sum of 0, because the entire structure
    is ignored.
    [1,"red",5] has a sum of 6, because "red" in an array has no effect.

Your puzzle answer was 65402.

Both parts of this puzzle are complete! They provide two gold stars: **
)
