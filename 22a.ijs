NB. wizard rpg * part 1 * http://adventofcode.com/day/22

doubleturn=: 4 : 0 NB. x: state, y: spell to choose (ZMDSPR)
  'm h b d sh po re t'=.x [ a=.0 NB. mana,hits,etc see below; a - armor
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. po>0 do. b=.b-3 [ po=.<:po if. b<:0 do. t return. end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  select. y NB. 12/23 I added 'else. 0 return.' below to cut off 'zero' cases
  case.1 do. if. m>:53 do. m=.m-53 [ t=.t+53 [ b=.b-4 else. 0 return. end.
  case.2 do. if. m>:73 do. m=.m-73 [ t=.t+73 [ b=.b-2 [ h=.h+2 else. 0 return. end.
  case.3 do. if. (m>:113)*.sh=0 do. m=.m-113 [ t=.t+113 [ sh=.6 else. 0 return. end.
  case.4 do. if. (m>:173)*.po=0 do. m=.m-173 [ t=.t+173 [ po=.6 else. 0 return. end.
  case.5 do. if. (m>:229)*.re=0 do. m=.m-229 [ t=.t+229 [ re=.5 else. 0 return. end.
  end.
  if. b<:0 do. t return. end. NB. Player won
  a=.0 NB. Now it's boss's turn
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. po>0 do. b=.b-3 [ po=.<:po if. b<:0 do. t return. end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  h=.h-1>.(d-a)
  if. h<:0 do. _1 return. end. NB. Boss won
  m,h,b,d,sh,po,re,t NB. return state for next turns
)

run=: 3 : 0
  s=. 500 50  55 8  0 0 0  0  NB. mana hits  b-hits b-damage  sh po re  total
  for_c. y do.
    if. 1=# s=. s doubleturn c do. s return. end.
  end.
  0 NB. it seems no winner
)

main=: 3 : 0 NB. y>0 for printing all solutions
  t0=.6!:1'' [ mn=.9999 [ mv=.9$9 NB. minimum total spent and its spell vector
  NB. 12/23 I removed '0' out of combination to get rid of 'zero' spell
  hh=.>:5 5 5 5#:i.5*5*5*5      NB. same performance as nested loops
  tt=.>:5 5 5 5 5#:i.5*5*5*5*5  NB. just a bit shorter text
  try. NB. to allow ^C
    for_h. hh do. NB. ~head
      ((":h),(5j0":mn),CR) 1!:2[4   NB. show progress...
      for_t. tt do. NB. ~tail
        if. 0< n=. run h,t do.
          if. y>0 do. echo (":h,t),' - ',":n end. NB. show all solutions
          if. n<mn do. mn=.n [ mv=.h,t end. NB. new minimum
        end.
      end. NB. used to be 1296*7776 runs i.e. 10,077,696 games :)
    end.   NB. now without zero variants, only 5^9 or 1,953,125 games
  catch.
    echo LF
  end.
  mn,mv,t0-~6!:1'' NB. return minimum, spells, time elapsed
)

echo main 0 NB. 953  1 4 5 1 3 4 1 1 1  236/189 sec (different computers)
            NB. ~~~  M P R M S P M M M
exit 0

0 : 0
--- Day 22: Wizard Simulator 20XX ---

Little Henry Case decides that defeating bosses with swords and stuff
is boring. Now he's playing the game with a wizard. Of course, he gets
stuck on another boss and needs your help again.

In this version, combat still proceeds with the player and the boss
taking alternating turns. The player still goes first. Now, however,
you don't get any equipment; instead, you must choose one of your
spells to cast. The first character at or below 0 hit points loses.

Since you're a wizard, you don't get to wear armor, and you can't
attack normally. However, since you do magic damage, your opponent's
armor is ignored, and so the boss effectively has zero armor as well.
As before, if armor (from a spell, in this case) would reduce damage
below 1, it becomes 1 instead - that is, the boss' attacks always
deal at least 1 damage.

On each of your turns, you must select one of your spells to cast.
If you cannot afford to cast any spell, you lose. Spells cost mana;
you start with 500 mana, but have no maximum limit. You must have
enough mana to cast a spell, and its cost is immediately deducted
when you cast it. Your spells are Magic Missile, Drain, Shield,
Poison, and Recharge.

    Magic Missile costs 53 mana. It instantly does 4 damage.
    Drain costs 73 mana. It instantly does 2 damage and heals you
    for 2 hit points.
    Shield costs 113 mana. It starts an effect that lasts for 6
    turns. While it is active, your armor is increased by 7.
    Poison costs 173 mana. It starts an effect that lasts for 6
    turns. At the start of each turn while it is active, it deals
    the boss 3 damage.
    Recharge costs 229 mana. It starts an effect that lasts for
    5 turns. At the start of each turn while it is active, it
    gives you 101 new mana.

Effects all work the same way. Effects apply at the start of both
the player's turns and the boss' turns. Effects are created with
a timer (the number of turns they last); at the start of each
turn, after they apply any effect they have, their timer is
decreased by one. If this decreases the timer to zero, the effect
ends. You cannot cast a spell that would start an effect which is
already active. However, effects can be started on the same turn
they end.

For example, suppose the player has 10 hit points and 250 mana,
and that the boss has 13 hit points and 8 damage:

-- Player turn --
- Player has 10 hit points, 0 armor, 250 mana
- Boss has 13 hit points
Player casts Poison.

-- Boss turn --
- Player has 10 hit points, 0 armor, 77 mana
- Boss has 13 hit points
Poison deals 3 damage; its timer is now 5.
Boss attacks for 8 damage.

-- Player turn --
- Player has 2 hit points, 0 armor, 77 mana
- Boss has 10 hit points
Poison deals 3 damage; its timer is now 4.
Player casts Magic Missile, dealing 4 damage.

-- Boss turn --
- Player has 2 hit points, 0 armor, 24 mana
- Boss has 3 hit points
Poison deals 3 damage. This kills the boss, and the player wins.

Now, suppose the same initial conditions, except that the boss
has 14 hit points instead:

-- Player turn --
- Player has 10 hit points, 0 armor, 250 mana
- Boss has 14 hit points
Player casts Recharge.

-- Boss turn --
- Player has 10 hit points, 0 armor, 21 mana
- Boss has 14 hit points
Recharge provides 101 mana; its timer is now 4.
Boss attacks for 8 damage!

-- Player turn --
- Player has 2 hit points, 0 armor, 122 mana
- Boss has 14 hit points
Recharge provides 101 mana; its timer is now 3.
Player casts Shield, increasing armor by 7.

-- Boss turn --
- Player has 2 hit points, 7 armor, 110 mana
- Boss has 14 hit points
Shield's timer is now 5.
Recharge provides 101 mana; its timer is now 2.
Boss attacks for 8 - 7 = 1 damage!

-- Player turn --
- Player has 1 hit point, 7 armor, 211 mana
- Boss has 14 hit points
Shield's timer is now 4.
Recharge provides 101 mana; its timer is now 1.
Player casts Drain, dealing 2 damage, and healing 2 hit points.

-- Boss turn --
- Player has 3 hit points, 7 armor, 239 mana
- Boss has 12 hit points
Shield's timer is now 3.
Recharge provides 101 mana; its timer is now 0.
Recharge wears off.
Boss attacks for 8 - 7 = 1 damage!

-- Player turn --
- Player has 2 hit points, 7 armor, 340 mana
- Boss has 12 hit points
Shield's timer is now 2.
Player casts Poison.

-- Boss turn --
- Player has 2 hit points, 7 armor, 167 mana
- Boss has 12 hit points
Shield's timer is now 1.
Poison deals 3 damage; its timer is now 5.
Boss attacks for 8 - 7 = 1 damage!

-- Player turn --
- Player has 1 hit point, 7 armor, 167 mana
- Boss has 9 hit points
Shield's timer is now 0.
Shield wears off, decreasing armor by 7.
Poison deals 3 damage; its timer is now 4.
Player casts Magic Missile, dealing 4 damage.

-- Boss turn --
- Player has 1 hit point, 0 armor, 114 mana
- Boss has 2 hit points
Poison deals 3 damage. This kills the boss, and the player wins.

You start with 50 hit points and 500 mana points. The boss's actual
stats are in your puzzle input. What is the least amount of mana you
can spend and still win the fight? (Do not include mana recharge
effects as "spending" negative mana.)

Your puzzle answer was 953.
--- Part Two ---

On the next run through the game, you increase the difficulty to hard.

At the start of each player turn (before any other effects apply),
you lose 1 hit point. If this brings you to or below 0 hit points,
you lose.

With the same starting stats for you and the boss, what is the least
amount of mana you can spend and still win the fight?

Your puzzle answer was 1289.

Both parts of this puzzle are complete! They provide two gold stars: **
)
