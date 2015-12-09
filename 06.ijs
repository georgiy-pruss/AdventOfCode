NB. turn on, off, toggle http://adventofcode.com/day/6

split1=: <;._2@,~
rstrip=: (1 + 0 i:~ [: +./ =/) {. ]
contains=: +./@:E.~
startswith=: ] -: ({.~ #)

main1 =: 3 : 0
  x=. 1000 1000$0
  for_l. y do.
    l=. (13 32{a.) rstrip >l
    if. (#l)<20 do. continue. end. NB. 'toggle x,y through x,y'
    'p1 p2'=. _3 _1{' 'split1 l  NB. 'aa,bb';'cc,dd'
    'a b'=.".p1 [ 'c d'=.".p2
    rows=.a+i.>:c-a
    cols=.b+i.>:d-b
    coords=.rows (<@,)"0/ cols
    if. l startswith 'turn on' do. x=.1 coords}x
    elseif. l startswith 'turn off' do. x=.0 coords}x
    elseif. l startswith 'toggle' do. x=.(-.coords{x) coords}x
    end.
  end.
  +/+/x
)

main2 =: 3 : 0
  x=. 1000 1000$0
  z=. x
  for_l. y do.
    l=. (13 32{a.) rstrip >l
    if. (#l)<20 do. continue. end. NB. 'toggle x,y through x,y'
    'p1 p2'=. _3 _1{' 'split1 l  NB. 'aa,bb';'cc,dd'
    'a b'=.".p1 [ 'c d'=.".p2
    rows=.a+i.>:c-a
    cols=.b+i.>:d-b
    coords=.rows (<@,)"0/ cols
    add=.1 coords}z
    if. l startswith 'turn on' do. x=.x+add
    elseif. l startswith 'turn off' do. x=.0>.x-add
    elseif. l startswith 'toggle' do. x=.x+add*2
    end.
  end.
  +/+/x
)

t=. LF split1 1!:1 [2{ARGV
echo main1 t
echo main2 t
exit 0

0 : 0
--- Day 6: Probably a Fire Hazard ---

Because your neighbors keep defeating you in the holiday house decorating
contest year after year, you've decided to deploy one million lights in a
1000x1000 grid.

Furthermore, because you've been especially nice this year, Santa has mailed
you instructions on how to display the ideal lighting configuration.

Lights in your grid are numbered from 0 to 999 in each direction; the lights
at each corner are at 0,0, 0,999, 999,999, and 999,0. The instructions include
whether to turn on, turn off, or toggle various inclusive ranges given as
coordinate pairs. Each coordinate pair represents opposite corners of a
rectangle, inclusive; a coordinate pair like 0,0 through 2,2 therefore refers
to 9 lights in a 3x3 square. The lights all start turned off.

To defeat your neighbors this year, all you have to do is set up your lights
by doing the instructions Santa sent you in order.

For example:

    turn on 0,0 through 999,999 would turn on (or leave on) every light.
    toggle 0,0 through 999,0 would toggle the first line of 1000 lights,
    turning off the ones that were on, and turning on the ones that were off.
    turn off 499,499 through 500,500 would turn off (or leave off) the middle
    four lights.

After following the instructions, how many lights are lit?

Your puzzle answer was 569999.
--- Part Two ---

You just finish implementing your winning light pattern when you realize you
mistranslated Santa's message from Ancient Nordic Elvish.

The light grid you bought actually has individual brightness controls; each
light can have a brightness of zero or more. The lights all start at zero.

The phrase turn on actually means that you should increase the brightness of
those lights by 1.

The phrase turn off actually means that you should decrease the brightness of
those lights by 1, to a minimum of zero.

The phrase toggle actually means that you should increase the brightness of
those lights by 2.

What is the total brightness of all lights combined after following Santa's
instructions?

For example:

    turn on 0,0 through 0,0 would increase the total brightness by 1.
    toggle 0,0 through 999,999 would increase the total brightness by 2000000.

Your puzzle answer was 17836115.

Both parts of this puzzle are complete! They provide two gold stars: **
)
