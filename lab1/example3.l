%{
#include<stdio.h>
%}

%%
[a-zA-Z][a-zA-Z0-9]* printf("Word ");
[a-zA-Z\/.-]+ printf("Filename ");
\" printf("Quote ");
\{ printf("OBraces ");
\} printf("EBraces ");
\; printf("Semicolon ");
\n printf("\n ");
[ \t]+ /* ignoring whitespace */;

%%