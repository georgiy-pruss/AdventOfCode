#include <stdio.h>
#include <string.h>

#define __ {
#define _  }

// state = m h a b p sh po re total-spent
typedef struct St { int m; int h; int a; int b; int p; int sh; int po; int re; int t; } State;

int turn( State* s, int y ) __ // y: spell to choose 'MDSPR', 'X' skip, 'B' for boss
  int a=s->a;
  if( y!='B' && (--s->h)<=0 ) return -1; // hard mode
  if( s->sh>0 ) { s->sh--; if( s->sh>0 ) a+=7; }
  if( s->re>0 ) { s->m+=101; s->re--; }
  if( s->po>0 ) { s->b-=3; s->po--; }
  if( s->b<=0 ) return s->t; // Player won
  switch(y) __
    case 'M': if( s->m>=53 ) { s->b-=4;              s->m-= 53; s->t+= 53; }
    case 'D': if( s->m>=73 ) { s->b-=2; s->h+=2;     s->m-= 73; s->t+= 73; }
    case 'S': if( s->sh==0 && s->m>=113 ) { s->sh=6; s->m-=113; s->t+=113; }
    case 'P': if( s->po==0 && s->m>=173 ) { s->po=6; s->m-=173; s->t+=173; }
    case 'R': if( s->re==0 && s->m>=229 ) { s->re=5; s->m-=229; s->t+=229; } _
  if( s->b<=0 ) return s->t; // Player won
  if( y=='B' ) __
    s->h=s->h-(s->p-a<1?1:s->p-a);
    if( s->h<=0 ) return -1; _ // Boss won
  return 0; _

int run( char* y ) __
  State s = {500,50,0,55,8,0,0,0,0};  // mana hits armor  b-hits b-damage  sh po re spent
  int r;
  for( int c=*y++; c; c=*y++ ) __
    if( (r=turn( &s, c ))!=0 ) return r;
    if( (r=turn( &s, 'B' ))!=0 ) return r; _
  return 0; _

int main() __
  const char T[] = "MDSPRX";
  char v[12] = {0,0,0,0,0,0,0,0,0,0,0,0};
  int t;
  char min_v[12]={0,0,0,0,0,0,0,0,0,0,0,0};
  int min_t=9999;
  for( int c1=0; c1<6; ++c1 ) __
    v[0]=T[c1];
    for( int c2=0; c2<6; ++c2 ) __
      v[1]=T[c2];
      for( int c3=0; c3<6; ++c3 ) __
        v[2]=T[c3]; v[3]=0; printf( "%s....... %d\r", v, min_t ); fflush(stdout);
        for( int c4=0; c4<6; ++c4 ) __
          v[3]=T[c4];
          for( int c5=0; c5<6; ++c5 ) __
            v[4]=T[c5];
            for( int c6=0; c6<6; ++c6 ) __
              v[5]=T[c6];
              for( int c7=0; c7<6; ++c7 ) __
                v[6]=T[c7];
                for( int c8=0; c8<6; ++c8 ) __
                  v[7]=T[c8];
                  for( int c9=0; c9<6; ++c9 ) __
                    v[8]=T[c9];
                    for( int cA=0; cA<6; ++cA ) __
                      v[9]=T[cA]; v[10]=0;
                      t = run( v );
                      if( t>0 && t<min_t ) { min_t=t; strcpy(min_v,v); }
  _ _ _ _ _ _ _ _ _ _
  printf( "\n%s %d\n", min_v, min_t );
  return 0; _
