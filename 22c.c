// wizard rpg part2 http://adventofcode.com/day/22 *** gcc -std=c99 -O2 22c.c && a.exe

#include <stdio.h>

#define __ {
#define _  }

// State: mana hits armor  b-hits b-damage  shield poison recharge  total-spent
typedef struct St { int m,h,a, b,d, sh,po,re, t; } State;
enum {Z,M,D,S,P,R,B}; // spell coding; Z: empty, B: boss's turn

int turn( State* s, int w ) __ // w: which spell to choose
  int a=s->a;
  if( w!=B && (--s->h)<=0 ) return -1; // part 2 = hard mode
  if( s->sh>0 ) { s->sh--; if( s->sh>0 ) a+=7; }
  if( s->po>0 ) { s->b-=3; s->po--; }
  if( s->re>0 ) { s->m+=101; s->re--; }
  if( s->b<=0 ) return s->t; // Player won
  #define ERB else return -1; break // ~ Lost because cannot buy what planned
  switch(w) __
    case M: if( s->m>=53 ) { s->b-=4;              s->m-= 53; s->t+= 53; } ERB;
    case D: if( s->m>=73 ) { s->b-=2; s->h+=2;     s->m-= 73; s->t+= 73; } ERB;
    case S: if( s->sh==0 && s->m>=113 ) { s->sh=6; s->m-=113; s->t+=113; } ERB;
    case P: if( s->po==0 && s->m>=173 ) { s->po=6; s->m-=173; s->t+=173; } ERB;
    case R: if( s->re==0 && s->m>=229 ) { s->re=5; s->m-=229; s->t+=229; } ERB; _
  if( s->b<=0 ) return s->t; // Player won
  if( w==B ) __
    s->h=s->h-(s->d-a<1?1:s->d-a);
    if( s->h<=0 ) return -1; _ // Boss won
  return 0; _

int run( int* ww, int k ) __
  State s = {500,50,0, 55,8, 0,0,0, 0};
  for( int r,w=*ww++; k-->0; w=*ww++ ) __
    if( (r = turn( &s, w )) != 0 ) return r;
    if( (r = turn( &s, B )) != 0 ) return r; _
  return 0; _

int main() __
  int v[10] = {0}; int min_v[10]={0}; int n; int min_n=9999;
  #define DO(z) for(z=M;z<=R;++z)__
  DO(v[0]) DO(v[1]) DO(v[2]) DO(v[3]) DO(v[4]) DO(v[5]) DO(v[6]) DO(v[7]) DO(v[8])
    n = run( v, 9 );
    if( n>0 && n<min_n )
      { min_n=n; for(int i=0;i<9;++i) min_v[i]=v[i]; } _ _ _ _ _ _ _ _ _
  long long m=0; for(int i=0;i<9;++i) m=m*10+min_v[i]; // convert to a number for print
  printf( "%lld %d\n", m, min_n ); // 425435421 1289 = PDRPSRPDM
  return 0; _
