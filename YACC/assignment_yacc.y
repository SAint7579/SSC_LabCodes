%{
#include<stdio.h>
extern int yylex();
extern int yywrap();
extern int yyparse();

/*
     D→ TL;
     T→ int | float
     L → L ,id | id
*/

%}

%token ID INT FLOAT SCOLON COMMA

%%

D:	T L SCOLON{printf("Decleration Statement");};

T:	INT |
	FLOAT ;

L:	L COMMA ID|
	ID;

%%

#include"lex.yy.c"
int yyerror(char *str)
{
	printf("%s\n", str);
}

int main()
{
	yyparse();
}

/*

Output:

a int;
syntax error

float a,b;
Decleration Statement

*/
