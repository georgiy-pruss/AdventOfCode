// wizard rpg http://adventofcode.com/day/22 *** gcc -std=c99 -O2 22-part2.c && a.exe

#include <stdio.h>
#include <string.h>

#define __ {
#define _  }

// State: mana hits armor  b-hits b-damage  shield poison recharge  total-spent
typedef struct St { int m,h,a, b,d, sh,po,re, t; } State;

enum {O,X,M,D,S,P,R,B}; // spell coding; X-empty, B-it's boss' turn, O-like '\0', eos

int turn( State* s, int w ) __ // w: which spell to choose
  int a=s->a;
  if( w!=B && (--s->h)<=0 ) return -1; // hard mode
  if( s->sh>0 ) { s->sh--; if( s->sh>0 ) a+=7; }
  if( s->re>0 ) { s->m+=101; s->re--; }
  if( s->po>0 ) { s->b-=3; s->po--; }
  if( s->b<=0 ) return s->t; // Player won
  switch(w) __
    case M: if( s->m>=53 ) { s->b-=4;              s->m-= 53; s->t+= 53; }
    case D: if( s->m>=73 ) { s->b-=2; s->h+=2;     s->m-= 73; s->t+= 73; }
    case S: if( s->sh==0 && s->m>=113 ) { s->sh=6; s->m-=113; s->t+=113; }
    case P: if( s->po==0 && s->m>=173 ) { s->po=6; s->m-=173; s->t+=173; }
    case R: if( s->re==0 && s->m>=229 ) { s->re=5; s->m-=229; s->t+=229; } _
  if( s->b<=0 ) return s->t; // Player won
  if( w==B ) __
    s->h=s->h-(s->d-a<1?1:s->d-a);
    if( s->h<=0 ) return -1; _ // Boss won
  return 0; _

int run( int* ww ) __
  State s = {500,50,0,55,8,0,0,0,0};
  int r;
  for( int w=*ww++; w; w=*ww++ ) __
    if( (r=turn( &s, w ))!=0 ) return r;
    if( (r=turn( &s, B ))!=0 ) return r; _
  return 0; _

int main() __
  int v[11] = {0}; int min_v[11]={0};
  int t; int min_t=9999;
  for( int c1=X; c1<=R; ++c1 ) __
    v[0]=c1;
    for( int c2=X; c2<=R; ++c2 ) __
      v[1]=c2;
      for( int c3=X; c3<=R; ++c3 ) __
        v[2]=c3; printf( "%d%d%d....... %d\r", c1,c2,c3, min_t ); fflush(stdout);
        for( int c4=X; c4<=R; ++c4 ) __
          v[3]=c4;
          for( int c5=X; c5<=R; ++c5 ) __
            v[4]=c5;
            for( int c6=X; c6<=R; ++c6 ) __
              v[5]=c6;
              for( int c7=X; c7<=R; ++c7 ) __
                v[6]=c7;
                for( int c8=X; c8<=R; ++c8 ) __
                  v[7]=c8;
                  for( int c9=X; c9<=R; ++c9 ) __
                    v[8]=c9;
                    for( int cA=X; cA<=R; ++cA ) __
                      v[9]=cA;
                      t = run( v );
                      if( t>0 && t<min_t ) { min_t=t; memcpy(min_v,v,sizeof(v)); }
  _ _ _ _ _ _ _ _ _ _
  long long m=0; for(int i=0;i<10;++i) m=m*10+min_v[i]; // convert to a number for print
  printf( "\n%lld %d\n", m, min_t ); // 5113125111 1289
  return 0; _
