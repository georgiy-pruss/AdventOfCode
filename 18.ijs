NB. Conway's Game of Life http://adventofcode.com/day/18
t=: '#'= >cutLF CR-.~fread {:ARGV
I=:<"1[_2]\<:(16#3)#:673424 NB. neighbour coords
corners=: 1 (0 0;0 _1;_1 0;_1 _1)} ]
step=: 4 : 0
  m=. 0,~0,0,.~0,.y NB. expand y to have empty borders
  n=.('r c'=.$y)$0
  for_i. >:i.r do.
    for_j. >:i.c do.
      s=. +/(+&(i,j)&.>I){m
      if. s=3 do. v=.1 else. v=.(s=2)*.(<i,j){m end.
      n=.v (<<:i,j)} n
    end.
  end.
  if. x do. corners n else. n end.
)
NB. echo <(step^:100 t){'.#'
echo +/+/ 0&step^:100 t
echo +/+/ 1&step^:100 corners t NB. fix corners
exit 0

0 : 0
--- Day 18: Like a GIF For Your Yard ---

After the million lights incident, the fire code has gotten stricter:
now, at most ten thousand lights are allowed. You arrange them in a
100x100 grid.

Never one to let you down, Santa again mails you instructions on the
ideal lighting configuration. With so few lights, he says, you'll have
to resort to animation.

Start by setting your lights to the included initial configuration
(your puzzle input). A # means "on", and a . means "off".

Then, animate your grid in steps, where each step decides the next
configuration based on the current one. Each light's next state (either
on or off) depends on its current state and the current states of the
eight lights adjacent to it (including diagonals). Lights on the edge
of the grid might have fewer than eight neighbors; the missing ones
always count as "off".

For example, in a simplified 6x6 grid, the light marked A has the
neighbors numbered 1 through 8, and the light marked B, which is on
an edge, only has the neighbors marked 1 through 5:

1B5...
234...
......
..123.
..8A4.
..765.

The state a light should have next is based on its current state (on
or off) plus the number of neighbors that are on:

    A light which is on stays on when 2 or 3 neighbors are on, and
    turns off otherwise.
    A light which is off turns on if exactly 3 neighbors are on, and
    stays off otherwise.

All of the lights update simultaneously; they all consider the same
current state before moving to the next.

Here's a few steps from an example configuration of another 6x6 grid:

Initial state:
.#.#.#
...##.
#....#
..#...
#.#..#
####..

After 1 step:
..##..
..##.#
...##.
......
#.....
#.##..

After 2 steps:
..###.
......
..###.
......
.#....
.#....

After 3 steps:
...#..
......
...#..
..##..
......
......

After 4 steps:
......
......
..##..
..##..
......
......

After 4 steps, this example has four lights on.

In your grid of 100x100 lights, given your initial configuration,
how many lights are on after 100 steps?

Your puzzle answer was 821.
--- Part Two ---

You flip the instructions over; Santa goes on to point out that this
is all just an implementation of Conway's Game of Life. At least, it
was, until you notice that something's wrong with the grid of lights
you bought: four lights, one in each corner, are stuck on and can't
be turned off. The example above will actually run like this:

Initial state:
##.#.#
...##.
#....#
..#...
#.#..#
####.#

After 1 step:
#.##.#
####.#
...##.
......
#...#.
#.####

After 2 steps:
#..#.#
#....#
.#.##.
...##.
.#..##
##.###

After 3 steps:
#...##
####.#
..##.#
......
##....
####.#

After 4 steps:
#.####
#....#
...#..
.##...
#.....
#.#..#

After 5 steps:
##.###
.##..#
.##...
.##...
#.#...
##...#

After 5 steps, this example now has 17 lights on.

In your grid of 100x100 lights, given your initial configuration, but
with the four corners always in the on state, how many lights are on
after 100 steps?

Your puzzle answer was 886.

Both parts of this puzzle are complete! They provide two gold stars: **
)
