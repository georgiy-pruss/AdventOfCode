NB. distribution of presents http://adventofcode.com/day/3

insert =: 4 : 0
  NB. insert y in x if y is not in x, otherwise nothing
  NB. y is pair A,B; elements in x are 32000*A+B
  z=.+/32000 1*y
  if. (#x) = x i. z do. x,z else. x end.
)

main =: 3 : 0
  if.y-:'-'do.t=:'>><^v>>' else.t=:1!:1<y end.
  p=.0 0
  v=.(0$0) insert p
  for_x. t do.
    if. x='<' do. v=.v insert p=.p+_1 0 else.
    if. x='>' do. v=.v insert p=.p+1 0 else.
    if. x='^' do. v=.v insert p=.p+0 1 else.
    if. x='v' do. v=.v insert p=.p+0 _1 else.
      NB. skip
    end. end. end. end.
  end.
  #v
)

main2 =: 3 : 0
  if.y-:'-'do.t=:'>><^v>>' else.t=:1!:1<y end.
  p=.0 0
  r=.0 0
  v=.(0$0) insert p
  santa=.1
  for_x. t do.
    if. santa do.
      if. x='<' do. v=.v insert p=.p+_1 0 else.
      if. x='>' do. v=.v insert p=.p+1 0 else.
      if. x='^' do. v=.v insert p=.p+0 1 else.
      if. x='v' do. v=.v insert p=.p+0 _1 else.
        NB. skip
      end. end. end. end.
    else.
      if. x='<' do. v=.v insert r=.r+_1 0 else.
      if. x='>' do. v=.v insert r=.r+1 0 else.
      if. x='^' do. v=.v insert r=.r+0 1 else.
      if. x='v' do. v=.v insert r=.r+0 _1 else.
        NB. skip
      end. end. end. end.
    end.
    santa=.-.santa
  end.
  #v
)

echo main >2{ARGV
echo main2 >2{ARGV
exit 0

0 : 0
--- Day 3: Perfectly Spherical Houses in a Vacuum ---

Santa is delivering presents to an infinite two-dimensional grid of houses.

He begins by delivering a present to the house at his starting location, and then an
elf at the North Pole calls him via radio and tells him where to move next. Moves are
always exactly one house to the north (^), south (v), east (>), or west (<). After
each move, he delivers another present to the house at his new location.

However, the elf back at the north pole has had a little too much eggnog, and so his
directions are a little off, and Santa ends up visiting some houses more than once. How
many houses receive at least one present?

For example:

    > delivers presents to 2 houses: one at the starting location, and one to the east.
    ^>v< delivers presents to 4 houses in a square, including twice to the house at his
    starting/ending location.
    ^v^v^v^v^v delivers a bunch of presents to some very lucky children at only 2 houses.

Your puzzle answer was 2081.
--- Part Two ---

The next year, to speed up the process, Santa creates a robot version of himself,
Robo-Santa, to deliver presents with him.

Santa and Robo-Santa start at the same location (delivering two presents to the same 
starting house), then take turns moving based on instructions from the elf, who is 
eggnoggedly reading from the same script as the previous year.

This year, how many houses receive at least one present?

For example:

    ^v delivers presents to 3 houses, because Santa goes north, and then Robo-Santa 
    goes south.
    ^>v< now delivers presents to 3 houses, and Santa and Robo-Santa end up back where
    they started.
    ^v^v^v^v^v now delivers presents to 11 houses, with Santa going one direction and
    Robo-Santa going the other.

Your puzzle answer was 2341.

Both parts of this puzzle are complete! They provide two gold stars: **
)
