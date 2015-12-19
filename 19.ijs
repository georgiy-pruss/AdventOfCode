NB. long molecule http://adventofcode.com/day/19

t=: cutLF CR-.~fread {:ARGV
subs=: (' '&cut@>) (+./@('=>'&E.@>) # ]) t NB. those with '=>'
form=: ,>((40&<@#@>) # ]) t NB. the one very long (>40)

subst=: 3 : 0 NB. substitute in str from pos length len to new str
  'str pos len new'=.y
  (pos {. str), new, (pos+len) }. str
)

conv=: 4 : 0 NB. apply all substitutions from y to form x, giving set of forms
 res=.0$<''
 for_s. y do.
   'old xxx new'=. s
   for_p. old I.@E. x do. NB. for all substrings old in x
     res=.res, <subst x;p;(#old);new
   end.
 end.
 res
)

echo # ~. form conv subs

leads=: 4 : 0 NB. all subs out of y which could result into form x
  NB. return array of pairs (sub-index-in-subs(y), pos-in-string(x))
  res=.0$<0 0
  for_s. y do.
    'old xxx new'=. s
    for_p. new I.@E. x do.
      res=.res, <s_index,p
    end.
  end.
  res
)

shorten=: 4 : 0 NB. apply pair x=(i,p) to string form {.y, i.e. back conversion
  'idx pos'=.>x [ 'form subs'=.y
  'old xxx new'=. idx{subs
  subst form;pos;(#new);old
)

minf=:1000

doit=: 4 : 0 NB. x - depth
  'form subs'=.y
  for_ip. form leads subs do. NB. for all candidate pairs
    newform=.ip shorten y
    if. 1=#newform do. if. (,'e')-:newform do. >:x return. end. end.
    if. n=. (>:x) doit newform;<subs do. n return. end.
  end.
  0
)

echo 0 doit form;<subs

exit 0

0 : 0
--- Day 19: Medicine for Rudolph ---

Rudolph the Red-Nosed Reindeer is sick! His nose isn't shining very brightly,
and he needs medicine.

Red-Nosed Reindeer biology isn't similar to regular reindeer biology; Rudolph
is going to need custom-made medicine. Unfortunately, Red-Nosed Reindeer
chemistry isn't similar to regular reindeer chemistry, either.

The North Pole is equipped with a Red-Nosed Reindeer nuclear fusion/fission
plant, capable of constructing any Red-Nosed Reindeer molecule you need. It
works by starting with some input molecule and then doing a series of
replacements, one per step, until it has the right molecule.

However, the machine has to be calibrated before it can be used. Calibration
involves determining the number of molecules that can be generated in one
step from a given starting point.

For example, imagine a simpler machine that supports only the following
replacements:

H => HO
H => OH
O => HH

Given the replacements above and starting with HOH, the following molecules
could be generated:

    HOOH (via H => HO on the first H).
    HOHO (via H => HO on the second H).
    OHOH (via H => OH on the first H).
    HOOH (via H => OH on the second H).
    HHHH (via O => HH).

So, in the example above, there are 4 distinct molecules (not five, because
HOOH appears twice) after one replacement from HOH. Santa's favorite molecule,
HOHOHO, can become 7 distinct molecules (over nine replacements: six from H,
and three from O).

The machine replaces without regard for the surrounding characters. For example,
given the string H2O, the transition H => OO would result in OO2O.

Your puzzle input describes all of the possible replacements and, at the bottom,
the medicine molecule for which you need to calibrate the machine. How many
distinct molecules can be created after all the different ways you can do one
replacement on the medicine molecule?

Your puzzle answer was 518.
--- Part Two ---

Now that the machine is calibrated, you're ready to begin molecule fabrication.

Molecule fabrication always begins with just a single electron, e, and applying
replacements one at a time, just like the ones during calibration.

For example, suppose you have the following replacements:

e => H
e => O
H => HO
H => OH
O => HH

If you'd like to make HOH, you start with e, and then make the following
replacements:

    e => O to get O
    O => HH to get HH
    H => OH (on the second H) to get HOH

So, you could make HOH after 3 steps. Santa's favorite molecule, HOHOHO,
can be made in 6 steps.

How long will it take to make the medicine? Given the available replacements
and the medicine molecule in your puzzle input, what is the fewest number of
steps to go from e to the medicine molecule?

Your puzzle answer was 200.

Both parts of this puzzle are complete! They provide two gold stars: **
)
