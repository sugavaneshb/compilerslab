%{
#include "stdio.h"
#include "stdlib.h"
#include "math.h"
#include "y.tab.h"
%}
%%
	/* numbers */

[0-7]     {
                	//yylval = atoi(yytext);
			printf("blah");
                	return atoi(yytext);
          }
	/* decimal point */
'.'	  return *yytext;
[\n]      ECHO;
%%
