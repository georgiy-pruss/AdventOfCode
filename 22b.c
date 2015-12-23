// wizard rpg part2 http://adventofcode.com/day/22 *** gcc -std=c99 -O2 22b.c && a.exe

#include <stdio.h>
#include <string.h>

#define __ {
#define _  }

// State: mana hits armor  b-hits b-damage  shield poison recharge  total-spent
typedef struct St { int m,h,a, b,d, sh,po,re, t; } State;
enum {X,M,D,S,P,R,B}; // spell coding; X: empty, B: boss's turn

int turn( State* s, int w ) __ // w: which spell to choose
  int a=s->a;
  if( w!=B && (--s->h)<=0 ) return -1; // hard mode
  if( s->sh>0 ) { s->sh--; if( s->sh>0 ) a+=7; }
  if( s->re>0 ) { s->m+=101; s->re--; }
  if( s->po>0 ) { s->b-=3; s->po--; }
  if( s->b<=0 ) return s->t; // Player won
  switch(w) __
    case M: if( s->m>=53 ) { s->b-=4;              s->m-= 53; s->t+= 53; } break;
    case D: if( s->m>=73 ) { s->b-=2; s->h+=2;     s->m-= 73; s->t+= 73; } break;
    case S: if( s->sh==0 && s->m>=113 ) { s->sh=6; s->m-=113; s->t+=113; } break;
    case P: if( s->po==0 && s->m>=173 ) { s->po=6; s->m-=173; s->t+=173; } break;
    case R: if( s->re==0 && s->m>=229 ) { s->re=5; s->m-=229; s->t+=229; } break; _
  if( s->b<=0 ) return s->t; // Player won
  if( w==B ) __
    s->h=s->h-(s->d-a<1?1:s->d-a);
    if( s->h<=0 ) return -1; _ // Boss won
  return 0; _

int run( int* ww, int k ) __
  State s = {500,50,0,55,8,0,0,0,0};
  for( int r,w=*ww++; k-->0; w=*ww++ ) __
    if( (r=turn( &s, w ))!=0 ) return r;
    if( (r=turn( &s, B ))!=0 ) return r; _
  return 0; _

int main() __
  int v[10] = {0}; int min_v[10]={0};
  int t; int min_t=9999;
  #define DO(z) for(z=M;z<=R;++z)__
  DO(v[0]) DO(v[1]) DO(v[2])
    printf( "%d%d%d....... %d\r", v[0],v[1],v[2], min_t ); fflush(stdout);
    DO(v[3]) DO(v[4]) DO(v[5]) DO(v[6]) DO(v[7]) DO(v[8]) DO(v[9])
      t = run( v, 10 );
      if( t>0 && t<min_t ) { min_t=t; memcpy(min_v,v,sizeof(v)); } _ _ _ _ _ _ _ _ _ _
  long long m=0; for(int i=0;i<10;++i) m=m*10+min_v[i]; // convert to a number for print
  printf( "%lld %d\n", m, min_t ); // 4002014000 1289 ... 1256 ... 4254354200 1236
  return 0; _
