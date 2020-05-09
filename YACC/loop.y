%{
#include<stdio.h>
extern int yylex();
extern int yywrap();
extern int yyparse();
%}

%token WHILE IF DO FOR OP CP OCB CCB CMP SCOLON ASG ID NUM COMMA OPR

%%
start: sif | nwhile | dowhile | swhile | nestif;

swhile : WHILE OP cmplst CP stmt{printf("SINGLE WHILE\n");};
nwhile : WHILE OP cmplst CP OCB stlst CCB {printf("NESTEAD WHILE\n");};
dowhile : DO OCB stlst CCB WHILE OP cmplst CP SCOLON {printf("DO WHILE\n");};
sif : IF OP cmplst CP stmt {printf("SINGLE IF\n");};
nestif : IF OP cmplst CP OCB stlst CCB {printf("NESTEAD IF\n");};

cmplst:	cmpn COMMA cmplst 
	|cmpn;

cmpn:	ID CMP ID 
	|ID CMP NUM;

stlst:	stmt stlst
	|stmt;

stmt:	ID ASG ID OPR ID SCOLON 
	| ID ASG ID OPR NUM SCOLON 
	| ID ASG NUM OPR ID SCOLON  
	| ID ASG NUM OPR NUM SCOLON  
	| ID ASG ID SCOLON 
	| ID ASG NUM SCOLON 
	| start {printf("NESTED INSIDE A ");};

%%

#include"lex.yy.c"
int yyerror(char *str)
{
	printf("%s", str);
}

int main()
{
yyparse();
}



/*
if(a>b)

{

if(b>c)

{

c=5;

}
NESTEAD IF
NESTED INSIDE A 
}
NESTEAD IF

while(a>7)

{

a = a + 7;

}
NESTEAD WHILE

*/
