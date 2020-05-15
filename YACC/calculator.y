%{
#include<stdio.h>
%}

%token NUMBER

%left '+' '-'

%left '*' '/' '%'

%left '(' ')'

%%
/*Making the rules*/

Expression : E	{ 
			printf("\nExpression is valid");
			//Printing the result of the operation
			printf("\nResult=%d\n",$$);
			return 0;
		}

E:	 E'+'E	{$$=$1+$3;}
	|E'-'E	{$$=$1-$3;}
	|E'*'E	{$$=$1*$3;}
	|E'/'E	{$$=$1/$3;}
	|E'%'E	{$$=$1%$3;}
	|'('E')'{$$=$2;}
	|NUMBER	{$$=$1;}
	;
%%


void main()
{
	yyparse();
}
int yyerror()
{
	printf("Entered the wrong arithemetic expression");
}

/*
OUTPUT:
5+9-7

Expression is valid
Result=7
*/

