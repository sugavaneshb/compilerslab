%{
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
%}
%token ID IF THEN ELSE 
%right '='
%left '+' '-' 
%left '*' '/'
%left '<' '>'
%%
S : IF C THEN S1 ELSE S2 {printf("\nApplying rule 1a"); 
	    
	    // Insert rules here
	   }
    | IF C THEN S1 {printf("\nApplying rule 1b"); 
	    
	    // Insert rules here
	   }
    ;

C : ID '<' ID  {printf("\nApplying rule 2a");
	//Insert rules here
       }
   | ID '>' ID { printf("\nApplying rule 2b"); 
	//Insert rules here
      }
   | ID '<''>' ID { printf("\nApplying rule 2c"); 
	//Insert rules here
	}
    ;
S1 :ID '=' E { printf("\nApplying rule 3a"); 
	 //Insert rules here
       } 
   | S  { printf("\nApplying rule 3b");
	//Insert rules here
      }
    ;
S2 : ID '=' E { printf("\nApplying rule 4a"); 
	 //Insert rules here
       } 
   | S  { printf("\nApplying rule 4b");
	//Insert rules here
      }
    ;
E : E '+' E { printf("\nApplying rule 5a");
       //Insert rules here
     } 
    | E '*' E { printf("\nApplying rule 5b");
       //Insert rules here
     } 
    | ID { printf("\nApplying rule 5c");
       //Insert rules here
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
