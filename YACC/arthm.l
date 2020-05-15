%{
#include<stdio.h>
//Getting the tokens from .h file
#include "y.tab.h"
extern int yylval;
%}


%%
[0-9]+ 	{ 
	//Converting ASCII to Integer
	yylval=atoi(yytext);
	//returning the NUMBER token
	return NUMBER;
	}
[\t] ;
[\n] {return yytext[0];}

. return yytext[0];

%%

int yywrap()
{
	return 1;
}



