NB. next good password http://adventofcode.com/day/11

ilo =: (+./)@(8 11 14&e.)                           NB. 'i' 'l' 'o' in vector
abc =: 3 : '+./*./ 2=/\ 2 1 0 + 0 1 2 |.!._1"0 _ y' NB. three ascending chars
xxs =: |:2 26$i.26                                  NB. noun: list of all pairs
prs =: 3 : '2<:+/+./"1 xxs E."1 _ y'                NB. at least 2 diff pairs

v4s =: _97+a.&i. NB. 'hepxcrrq' --> 7 4 15 23 2 17 17 16
n4v =: 26&#.     NB. 7 4 15 23 2 17 17 16 --> 57647112526
v4n =: 26&#.^:_1 NB. 57647112526 --> 7 4 15 23 2 17 17 16
s4v =: a.{~ 97&+ NB. 7 4 15 23 2 17 17 16 --> 'hepxcrrq'

main =: 3 : 0
  n =. n4v v4s y
  while. do. v=. v4n n=. >:n
    if. -.ilo v do. if. abc v do. if. prs v do. break. end. end. end.
  end.
  s4v v
)

echo p ,: main p=. main 'hepxcrrq' NB.hepxxyzz heqaabcc
exit 0

0 : 0
--- Day 11: Corporate Policy ---

Santa's previous password expired, and he needs help choosing a new one.

To help him remember his new password after the old one expires, Santa
has devised a method of coming up with a password based on the previous
one. Corporate policy dictates that passwords must be exactly eight
lowercase letters (for security reasons), so he finds his new password
by incrementing his old password string repeatedly until it is valid.

Incrementing is just like counting with numbers: xx, xy, xz, ya, yb,
and so on. Increase the rightmost letter one step; if it was z, it wraps
around to a, and repeat with the next letter to the left until one
doesn't wrap around.

Unfortunately for Santa, a new Security-Elf recently started, and he
has imposed some additional password requirements:

    Passwords must include one increasing straight of at least three
    letters, like abc, bcd, cde, and so on, up to xyz. They cannot
    skip letters; abd doesn't count.
    Passwords may not contain the letters i, o, or l, as these letters
    can be mistaken for other characters and are therefore confusing.
    Passwords must contain at least two different, non-overlapping
    pairs of letters, like aa, bb, or zz.

For example:

    hijklmmn meets the first requirement (because it contains the
    straight hij) but fails the second requirement requirement
    (because it contains i and l).
    abbceffg meets the third requirement (because it repeats bb and
    ff) but fails the first requirement.
    abbcegjk fails the third requirement, because it only has one
    double letter (bb).
    The next password after abcdefgh is abcdffaa.
    The next password after ghijklmn is ghjaabcc, because you 
    eventually skip all the passwords that start with ghi..., since
    i is not allowed.

Given Santa's current password (your puzzle input), what should his
next password be?

Your puzzle answer was hepxxyzz.
--- Part Two ---

Santa's password expired again. What's the next one?

Your puzzle answer was heqaabcc.

Both parts of this puzzle are complete! They provide two gold stars: **
)
