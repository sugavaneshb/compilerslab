%{
#include <stdio.h>
#include <ctype.h>
#include <string.h>

char symbt[100][100];
char opert[100][100];
char constt[100][100];
char keywor[100][100];
int symindex=0,operindex=0,constindex=0,keyworindex=0;
main()
{

yylex();

}


%}

while "while"
do    "do"
oper  [\+\-\*/<>&]
if    "if"
else  "else"
for   "for"
equals ":="
%%
[a-zA-Z]+	{	int i,chk=1;
			for(i=0;i<symindex;i++) 
			if(!strcmp(symbt[i],yytext)) {chk=0;break;}
			
			if(chk==1)
			strcpy(symbt[symindex++],yytext) ; 
		}
{while}|{if}|{do}|{else}|{for}	{	
			int i,chk=1;
			for(i=0;i<keyworindex;i++) 
			if(!strcmp(keywor[i],yytext)) {chk=0;break;}
			
			if(chk==1)
			strcpy(keywor[keyworindex++],yytext); 
		}
		
[0-9]		{	int i,chk=1;
			for(i=0;i<constindex;i++) 
			if(!strcmp(constt[i],yytext)) {chk=0;break;}
			
			if(chk==1)
			strcpy(constt[constindex++],yytext);   
		}
{oper}|{equals}		{	int i,chk=1;
			for(i=0;i<operindex;i++) 
			if(!strcmp(opert[i],yytext)) {chk=0;break;}
			
			if(chk==1)
			strcpy(opert[operindex++],yytext);   
		}
[\n]		{    	int i;
			printf("\nSymbol Table :\n");
			for(i=0;i<symindex;i++)
			printf("%s\n",symbt[i]);

			printf("\n\nOperator Table:\n");
			for(i=0;i<operindex;i++)
			printf("%s\n",opert[i]);

			printf("\n\nConstant Table:\n");
			for(i=0;i<constindex;i++)
			printf("%s\n",constt[i]);

			printf("\n\nKeyword Table:\n");
			for(i=0;i<keyworindex;i++)
			printf("%s\n",keywor[i]);
		}
%%
