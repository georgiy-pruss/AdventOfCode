NB. shortest distance http://adventofcode.com/day/9

split1=: <;._2@,~
dcr=: ] }.~ [: - CR = {:  NB. drop last cr; dtb = drop trailing blanks

names=: 0$<''

find =: 3 : 0 NB. find boxed name in 'names'. add if absent
  i =. names i. y if. i=#names do. names=:names,y end. i
)

main =: 3 : 0
  dist=.300 300$_ NB. distance, max for 300 pts; will be trimmed to real data
  for_l. y do.
    if. 0=# l=. dtb dcr >l do. continue. end.
    assert ('to'-:>1{m) *. (,'=')-:>3{ m =.' ' split1 l
    a =. find 0{m [ b =. find 2{m
    dist =. (".>4{m) ((a,b);b,a) } dist
  end.
  dist =. n{."1 (n=.#names){. dist
  smin =. _ [ smax =. 0
  for_p. (i.!n) A. i.n do. NB. go through all permutations of i.n
    s =. +/ (<"1 (2[\p)) { dist
    if. s<smin do. smin=.s end.
    if. s>smax do. smax=.s end.
  end.
  smin,smax
)

echo main LF split1 1!:1 {:ARGV
exit 0

0 : 0
--- Day 9: All in a Single Night ---

Every year, Santa manages to deliver all of his presents in a single night.

This year, however, he has some new locations to visit; his elves have provided him the distances between every pair of locations. He can start and end at any two (different) locations he wants, but he must visit each location exactly once. What is the shortest distance he can travel to achieve this?

For example, given the following distances:

London to Dublin = 464
London to Belfast = 518
Dublin to Belfast = 141

The possible routes are therefore:

Dublin -> London -> Belfast = 982
London -> Dublin -> Belfast = 605
London -> Belfast -> Dublin = 659
Dublin -> Belfast -> London = 659
Belfast -> Dublin -> London = 605
Belfast -> London -> Dublin = 982

The shortest of these is London -> Dublin -> Belfast = 605, and so the answer is 605 in this example.

What is the distance of the shortest route?

Your puzzle answer was 207.
--- Part Two ---

The next year, just to show off, Santa decides to take the route with the longest distance instead.

He can still start and end at any two (different) locations he wants, and he still must visit each location exactly once.

For example, given the distances above, the longest route would be 982 via (for example) Dublin -> London -> Belfast.

What is the distance of the longest route?

Your puzzle answer was 804.

Both parts of this puzzle are complete! They provide two gold stars: **
)
