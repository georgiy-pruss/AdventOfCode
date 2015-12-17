NB. combinatorics again :( http://adventofcode.com/day/17

c=: 43 3 4 10 21 44 4 6 47 41 34 17 17 44 36 31 46 9 27 38
NB. c=: ". (LF,' ') charsub toJ fread '17.txt'

comb=: 4 : 0 NB. http://www.jsoftware.com/jwiki/Essays/Combinations
 k=. i.>:d=.y-x
 z=. (d$<i.0 0),<i.1 0
 for. i.x do. z=. k ,.&.> ,&.>/\. >:&.> z end.
 ; z
)

test=: 3 : '+/ 150=+/"1(y comb #c){c'

echo (+/ , ]) test"0 i.14 NB. 1638 0 0 0 0 17 151 441 552 356 110 11 0 0 0
                          NB. in total 988116 combinations tested
exit 0

NB. Godspiral/mark: c +/@:((150 = +/@:#~)"1) (C#2) #: i. 2^C=.#c

0 : 0
--- Day 17: No Such Thing as Too Much ---

The elves bought too much eggnog again - 150 liters this time. To fit it all
into your refrigerator, you'll need to move it into smaller containers. You
take an inventory of the capacities of the available containers.

For example, suppose you have containers of size 20, 15, 10, 5, and 5 liters.
If you need to store 25 liters, there are four ways to do it:

    15 and 10
    20 and 5 (the first 5)
    20 and 5 (the second 5)
    15, 5, and 5

Filling all containers entirely, how many different combinations of containers
can exactly fit all 150 liters of eggnog?

Your puzzle answer was 1638.
--- Part Two ---

While playing with all the containers in the kitchen, another load of eggnog
arrives! The shipping and receiving department is requesting as many containers
as you can spare.

Find the minimum number of containers that can exactly fit all 150 liters of
eggnog. How many different ways can you fill that number of containers and
still hold exactly 150 litres?

In the example above, the minimum number of containers was two. There were
three ways to use that many containers, and so the answer there would be 3.

Your puzzle answer was 17.

Both parts of this puzzle are complete! They provide two gold stars: **
)
