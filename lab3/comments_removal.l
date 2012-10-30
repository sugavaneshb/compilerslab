%{

#include<stdio.h>
#include<string.h>
int s_b = 1, e_b = 1;
int yywrap()
{
	return 1;
}
void st_brac()
{
	printf("begin#%d",s_b);
	s_b++;
}
void en_brace()
{
	printf("end#%d",e_b);
	e_b++;
}
main()
{
  yylex();
}
%}
blockquote "\""
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
"{" st_brac();
"}" en_brace();
{blockquote}.*{blockquote} { 
			     int i=0;
			     for(;i<strlen(yytext);i++)
				printf("%c",toupper(yytext[i]));
			    }
[ \t\n] ECHO;
. ECHO; 
%%
