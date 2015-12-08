NB. hacking MD5 http://adventofcode.com/day/4

md5 =: 3 : 0
  m=.,y
  c=. '"',libjqt,'" gethash ',(IFWIN#'+'),' i *c *c i * *i'
  'r t m w p n'=. c cd 'md5';m;(#m);(,2);,0
  res=. memr p,0,n
  if. r do.
    res (13!:8) 3
  end.
  res
)

0 : 0
echo md5 'abcdef609043'
NB. 000001dbbfa...
echo md5 'pqrstuv1048970'
NB. 000006136ef...
)

main =: 3 : 0
  n=.0
  while. -. '00000' -: 5{. md5 y,":n do.
    n=.n+1
  end.
  n; md5 y,":n
)

main6 =: 3 : 0
  n=.0 while. -. '000000' -: 6{. md5 y,":n do. n=.>:n end. n; md5 y,":n
)

echo main 'iwrupvqb'
echo main6 'iwrupvqb'
exit 0

0 : 0
--- Day 4: The Ideal Stocking Stuffer ---

Santa needs help mining some AdventCoins (very similar to bitcoins) to use as gifts
for all the economically forward-thinking little girls and boys.

To do this, he needs to find MD5 hashes which, in hexadecimal, start with at least
five zeroes. The input to the MD5 hash is some secret key (your puzzle input, given
below) followed by a number in decimal. To mine AdventCoins, you must find Santa the
lowest positive number (no leading zeroes: 1, 2, 3, ...) that produces such a hash.

For example:

    If your secret key is abcdef, the answer is 609043, because the MD5 hash of
    abcdef609043 starts with five zeroes (000001dbbfa...), and it is the lowest
    such number to do so.
    If your secret key is pqrstuv, the lowest number it combines with to make an MD5
    hash starting with five zeroes is 1048970; that is, the MD5 hash of pqrstuv1048970
    looks like 000006136ef....

Your puzzle answer was 346386.

The first half of this puzzle is complete! It provides one gold star: *
--- Part Two ---

Now find one that starts with six zeroes.

Your puzzle input is still iwrupvqb.

Your puzzle answer was 9958218.

Both parts of this puzzle are complete! They provide two gold stars: **
)
