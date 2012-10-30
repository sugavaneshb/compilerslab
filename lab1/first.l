%{

#include<stdio.h>
#include<string.h>
int wordcount = 0,lc = 1, tvw = 0;
struct vowelwords{
	char w[20];
	int l[100];
	int sizev;
}vw[1000];
void letsdothis(char yyt[])
{
	int i=0;
	for(;i<tvw;i++)
		if(strcmp(vw[i].w,yyt)==0)
			break;
	if(i==tvw)
	{
		strcpy(vw[tvw].w,yyt);
		vw[tvw].l[0] = lc;
		vw[tvw].sizev = 1;
		tvw++;
	}
	else
	{
		vw[i].l[vw[i].sizev] = lc;
		vw[i].sizev++;
	}
}
void printit()
{
	int i=0,j=0;
	for(;i<tvw;i++)
	{
	  int temp = vw[i].sizev;
	  printf("%s\t",vw[i].w);
	  for(j=0;j<(temp-1);j++)
	   printf("%d,",vw[i].l[j]);
	  printf("%d\t%d",vw[i].l[temp-1],temp);
	}
}
int yywrap()
{
	return 1;
}
main()
{
  yylex();
  printit();
}
%}
blockquote "\""
letter [ˆ \t]
%%
"/*" {
	register int c;
	for(;;)
	{
		while((c=input()) != '*' && c!=EOF);
		if(c == '*')
		{
			while((c=input())=='*');
			if ( c == '/')
				break;
		}
	}
     }
"//".*	
{blockquote}.*{blockquote}
[^aeiouAEIOU][a-zA-Z0-9] {
				wordcount++;
				printf("\tLine no:%d",lc);
				int i=0;
			     	for(;i<strlen(yytext);i++)
				  printf("%c",toupper(yytext[i]));
				letsdothis(yytext);
			 }
				
{letter}+ wordcount++;
\n lc++;
%%
