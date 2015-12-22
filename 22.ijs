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

3 : 0 '' NB. test
  state=. 250 10 0  14 8  0 0 0
  for_c. 'RSDPM' do.
    echo state=. state turn c
    if. 2>:#state do. return. end.
    echo state=. state turnb 0
  end.
)

0 : 0
21 10 0 14 8 0 0 5
122 2 0 14 8 0 0 4
110 2 0 14 8 6 0 3
211 1 0 14 8 5 0 2
239 3 0 12 8 4 0 1
340 2 0 12 8 3 0 0
167 2 0 12 8 2 6 0
167 1 0 9 8 1 5 0
114 1 0 2 8 0 4 0
1
)

exit''

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
                    if. t>0 do.
                      t;c,z return. end.
                    NB. m=.m>.
                  end.
                end.
              end.
            end.
          end.
        end.
      end.
    end.
  end.
  m
)

echo LF,":main ''

NB. 52|MPRMSPMMM
NB.   (53*5)+(2*173)+113+229
NB. 953

exit 0
