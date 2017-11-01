%{
        #include <stdio.h>
        #include <stdlib.h>
	#include "zoomjoystrong.tab.h"
	int fileno(FILE *stream);
%}

%option noyywrap

%%

; 		{return END_STATEMENT;}
end		{return END;}
point		{return POINT;}
line		{return LINE;}
circle		{return CIRCLE;}
rectangle	{return RECTANGLE;}
set_color	{return SET_COLOR;}
[0-9]+		{yylval.Num = atoi(yytext);  return INT;}
[0-9]*\.+[0-9]+	{yylval.numFloat = atof(yytext);  return FLOAT;}
[ \t]		;
\n		;

%%
