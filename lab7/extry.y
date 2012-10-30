%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
%}
%token INTEGER
%%
A : N'.'R {printf("\nApplying rule 1a"); 
	    $$ = $1 + $2;
	    printf("\nOctal to decimal value is..", $$);
	   }
    ;

N : N D {printf("\nApplying rule 2a");
	$$ = ($1 * 8) + $2;
	printf("\n Value after applying this rule is..", $$);
       }
   | D  { printf("\nApplying rule 2b"); 
	$$ = $1; 
	printf("\n Value after applying this rule is: %d", $$ );
      }
    ;
R : D R { printf("\nApplying rule 3a"); 
	 $$ = $1 + ($2 / 64);
	 printf("\n Value after applying this rule is: %f", $$ );
       } 
   | D  { printf("\nApplying rule 3b");
	$$ = $1 / 8;
	printf("\n Value after applying this rule is: %f", $$ ); 
      }
    ;
D : INTEGER { printf("\nApplying rule 4a");
       $$ = $1; 
       printf("\n Value after applying this rule is: %d", $$);
     } 
    ;
%%

int yyerror(char *s) {
    fprintf(stderr, "%s\n", s);
    return 0;
}
int yywrap()
{
	return 1;
}
int main(void) {
    yyparse();
    return 0;
}
