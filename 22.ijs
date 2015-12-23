0 : 0
  Boss:   Hits: 55 Damage: 8
  Spells: MagicM:    53 immed damage:4
          Drain:     73 immed damage:2 hits:+2
          Shield:   113 pre   turns:6 armor:+6
          Poison:   173 post  turns:6 damage:3
          Recharge: 229 post  turns:5 mana:+101
  Hero:   Mana: 500 hits:50
)

turnb=: 4 : 0 NB. x: state, y: ignore
  'm h a b p sh po re'=.x
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  if. po>0 do. b=.b-3 [ po=.<:po end.
  if. b<:0 do. m,1 return. end. NB. Player won
  h=.h-1>.(p-a)
  if. h<:0 do. 0 return. end. NB. Boss won
  m,h,0,b,p,sh,po,re
)

turn=: 4 : 0 NB. x: state, y: '0' or spell to choose 'MDSPR'
  'm h a b p sh po re'=.x
  NB. if. 0>:h=.h-1 do. 0 return. end. NB. hard mode
  if. sh>0 do. sh=.<:sh if. sh>0 do. a=.a+7 end. end.
  if. re>0 do. m=.m+101 [ re=.<:re end.
  if. po>0 do. b=.b-3 [ po=.<:po end.
  select. y
  case.'M' do. if. m>:53 do. m=.m-53 [ b=.b-4 end.
  case.'D' do. if. m>:73 do. m=.m-73 [ b=.b-2 [ h=.h+2 end.
  case.'S' do. if. (m>:113)*.sh=0 do. m=.m-113 [ sh=.6 end.
  case.'P' do. if. (m>:173)*.po=0 do. m=.m-173 [ po=.6 end.
  case.'R' do. if. (m>:229)*.re=0 do. m=.m-229 [ re=.5 end.
  end.
  if. b<:0 do. m,1 return. end. NB. Player won
  m,h,0,b,p,sh,po,re
)

run=: 3 : 0
  s=. 500 50 0  55 8  0 0 0  NB. mana hits armor  b-hits b-damage  sh po re
  for_c. y do.
    if. 2=# s=. s turn  c do. {.s return. elseif. 1=#s do. 0 return. end.
    if. 2=# s=. s turnb 0 do. {.s return. elseif. 1=#s do. 0 return. end.
  end.
  0
)

main=: 3 : 0
  m=.0
  for_c1. 'MDSPRX' do.
    for_c2. 'MDSPRX' do.
      for_c3. 'MDSPRX' do.
        for_c4. 'MDSPRX' do.
          for_c5. 'MDSPRX' do.
            ((c=.c1,c2,c3,c4,c5),CR) 1!:2[4
            for_c6. 'MDSPRX' do.
              for_c7. 'MDSPRX' do.
                for_c8. 'MDSPRX' do.
                  for_c9. 'MDSPRX' do.
                    t=.run c,z=.c6,c7,c8,c9
                    if. t>0 do. t;c,z return. end.
                    NB. m=. m >. ...
  end. end. end. end. end. end. end. end. end.
  m
)

echo LF,":main ''

NB. MPRMSPMMM -- (53*5)+(2*173)+113+229 -- 953

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
