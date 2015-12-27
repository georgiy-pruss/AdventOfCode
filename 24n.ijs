NB. packages in the sleigh http://adventofcode.com/day/24

NB. ncx is based on https://docs.python.org/3/library/itertools.html
ncx=: 4 : 0 NB. next combination index; x - n; y - prev indices
  if. 0=$$y do. i.y return. end. NB. first call - n ncx r
  for_i. |.i.r=.#y do.
    if. (i+x-r)~:i{y do.
      y=.(>:i{y)i}y NB. y[i]+=1; for j in range(i+1, r): y[j]=y[j-1]+1
      for_j. (>:i)+i.r->:i do. y=.(>:(<:j){y)j}y end. y return.
    end.
  end.
  0$0
)

NB. this is based on godarderik's python full-check solution:
NB. https://www.reddit.com/r/adventofcode/comments/3y1s7f/day_24_solutions/cy9srkh
has_sum=: 3 : 0 NB. y - p;weight;n-subparts;n-total-parts
  m=.#p [ 'p w n t'=.y
  for_c. >:i.m do. NB. try all lengths 1..#p
    whilst. 0<#c=.m ncx c do. NB. all combinations
      if. w~:+/part=. c{p do. continue. end. NB. wrong weight - try again
      if. n=2 do. 1 return. end. NB. just 2 parts and 1st is ok - all ok!
      if. n<t do. has_sum (p-.part);w;(<:n);t return. end.
      if. has_sum (p-.part);w;(<:n);t do. */part return. end.
    end.
  end.
)

NB. now let's have the same but with output of all the partitions
has_sum=: 3 : 0 NB. y - p;weight;n-subparts;n-total-parts
  E=. 3 : 'echo 1{":y' NB. for printing box lists
  m=.#p [ 'p w n t'=.y
  for_c. >:i.m do.
    whilst. 0<#c=.m ncx c do.
      part=.c{p
      if. w~:+/part do. continue. end.
      if. n=2 do.
        E 'R';(p-.part);+/(p-.part)
        E 'L';part;+/part
        1 return. end.
      if. n<t do. h=.has_sum (p-.part);w;(<:n);t
        if. h do. E 'M';part;+/part end.
        h return. end.
      if. has_sum (p-.part);w;(<:n);t do.
        E 'H';part;+/part
        */part return. end.
    end.
  end.
)

run=: 3 : 0 NB. y - number of partitions
  NB. calculate and check n-parts & weight
  echo y
  assert (+/p)=nparts*weight=:<.(+/p)%nparts=:y
  echo has_sum p;weight;nparts;nparts
)

echo p=: /:~".(LF,' ')charsub CR-.~1!:1{:ARGV
NB. sorting guarantees that the part 1 will have minimal */

run 3 NB. 10723906903
run 4 NB. 74850409
run 6 NB. 467933
run 8 NB. 8927

exit 0

0 : 0 NB. results
1 2 3 5 7 13 17 19 23 29 31 37 41 43 53 59 61 67 71 73 79 83 89 97 101 103 107 109 113
3
|R|3 5 7 13 17 19 23 29 31 37 41 43 53 59 61 71|512|
|L|2 67 73 83 89 97 101|512|
|H|1 79 103 107 109 113|512|
10723906903
4
|R|2 3 5 7 13 17 19 23 29 31 37 41 43 53 61|384|
|L|1 67 71 73 83 89|384|
|M|79 97 101 107|384|
|H|59 103 109 113|384|
74850409
6
|R|13 17 19 23 29 31 53 71|256|
|L|2 43 61 67 83|256|
|M|7 73 79 97|256|
|M|5 59 89 103|256|
|M|3 37 107 109|256|
|H|1 41 101 113|256|
467933
8
|R|2 17 23 29 37 41 43|192|
|L|7 31 53 101|192|
|M|5 59 61 67|192|
|M|3 19 73 97|192|
|M|1 13 71 107|192|
|M|89 103|192|
|M|83 109|192|
|H|79 113|192|
8927
)
