%{
#include<stdio.h>
int wc=0;
void itsaword()
{
 wc++;
 printf("word ");
}
%}

%%
[^aeiouAEIOU][a-zA-Z0-9]* printf("vowelword ");
[aeiouAEIOU][a-zA-Z0-9]* itsaword(); 
[ \t]+ /* ignore whitespace */;
[\n][\n] printf("\nWord count:%d\n",wc);
%%