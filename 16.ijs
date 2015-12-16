NB. too many aunts http://adventofcode.com/day/16

t=: ;: > cutLF (':,',CR)-.~ fread {:ARGV NB. |Sue|440|pomeranians|1|samoyeds|9|children|4|

c=: ;: 'children cats samoyeds pomeranians akitas vizslas goldfish trees cars perfumes'
a=: ".@>@{: + (100 * c i. {.) NB. analyze 'name';num

s=: 'children 3 cats 7 samoyeds 2 pomeranians 3 akitas 0 vizslas 0 goldfish 5 trees 3'
p=: a"1 [_2]\ ;: s,' cars 2 perfumes 1' NB. 3 107 202 303 400 500 605 703 802 901

e=: 3 : '*./ p e.~ a"1 [_2]\ 2}.y' NB. all in y* belongs to x
echo (#~ e"1) t NB. |Sue|213|children|3|goldfish|5|vizslas|0|

NB. 107 --> >107, 703 --> >703, 303 --> <303, 605 --> <605
p=: 3 108 109 110 111 112 113 114 202 300 301 302 400 500
p=: p,600 601 602 603 604 704 705 706 707 708 709 802 901
echo (#~ e"1) t NB. |Sue|323|perfumes|1|trees|6|goldfish|0|

exit 0

0 : 0
--- Day 16: Aunt Sue ---

Your Aunt Sue has given you a wonderful gift, and you'd like to send her a thank you card. However, there's a small problem: she signed it "From, Aunt Sue".

You have 500 Aunts named "Sue".

So, to avoid sending the card to the wrong person, you need to figure out which Aunt Sue (which you conveniently number 1 to 500, for sanity) gave you the gift. You open the present and, as luck would have it, good ol' Aunt Sue got you a My First Crime Scene Analysis Machine! Just what you wanted. Or needed, as the case may be.

The My First Crime Scene Analysis Machine (MFCSAM for short) can detect a few specific compounds in a given sample, as well as how many distinct kinds of those compounds there are. According to the instructions, these are what the MFCSAM can detect:

    children, by human DNA age analysis.
    cats. It doesn't differentiate individual breeds.
    Several seemingly random breeds of dog: samoyeds, pomeranians, akitas, and vizslas.
    goldfish. No other kinds of fish.
    trees, all in one group.
    cars, presumably by exhaust or gasoline or something.
    perfumes, which is handy, since many of your Aunts Sue wear a few kinds.

In fact, many of your Aunts Sue have many of these. You put the wrapping from the gift into the MFCSAM. It beeps inquisitively at you a few times and then prints out a message on ticker tape:

children: 3
cats: 7
samoyeds: 2
pomeranians: 3
akitas: 0
vizslas: 0
goldfish: 5
trees: 3
cars: 2
perfumes: 1

You make a list of the things you can remember about each Aunt Sue. Things missing from your list aren't zero - you simply don't remember the value.

What is the number of the Sue that got you the gift?

Your puzzle answer was 213.
--- Part Two ---

As you're about to send the thank you note, something in the MFCSAM's instructions catches your eye. Apparently, it has an outdated retroencabulator, and so the output from the machine isn't exact values - some of them indicate ranges.

In particular, the cats and trees readings indicates that there are greater than that many (due to the unpredictable nuclear decay of cat dander and tree pollen), while the pomeranians and goldfish readings indicate that there are fewer than that many (due to the modial interaction of magnetoreluctance).

What is the number of the real Aunt Sue?

Your puzzle answer was 323.

Both parts of this puzzle are complete! They provide two gold stars: **
)
