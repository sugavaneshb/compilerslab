%{
 int lineno;
%}
%%
	/*insert line number self try!! */
^(.*)\n	printf("%d%t%s",++lineno, yytext);
%%
int yywrap(void)
{
 return 1;
}
int main(int argc, char *argv[])
{
 yyin = fopen(argv[1], "r");
 yylex();
 fclose(yyin);
}
