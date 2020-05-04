%{
#include<stdio.h>
extern int yylex();
extern int yywrap();
extern int yyparse();
%}

%token WHILE IF DO FOR OP CP OCB CCB CMP SCOLON ASG ID NUM COMMA OPR

%%

cmpn:	ID CMP ID 
	| ID CMP NUM;
cmplst:	cmpn COMMA cmplst 
	| cmpn;
stlst:	stmt stlst
	| stmt;
stmt:	ID ASG ID OPR ID SCOLON 
	| ID ASG ID OPR NUM SCOLON 
	| ID ASG NUM OPR ID SCOLON 
	| ID ASG NUM OPR NUM SCOLON 
	| ID ASG ID SCOLON 
	| ID ASG NUM SCOLON 
	| start 
	{printf("NESTED INSIDE A ");};


nestif : IF OP cmplst CP OCB stlst CCB {printf("NESTEAD IF\n");};
sif : IF OP cmplst CP stmt {printf("SINGLE IF\n");};
dowhile : DO OCB stlst CCB WHILE OP cmplst CP SCOLON {printf("DO WHILE\n");};
swhile : WHILE OP cmplst CP stmt {printf("SINGLE WHILE\n");};
nwhile : WHILE OP cmplst CP OCB stlst CCB {printf("NESTEAD WHILE\n");};

start: swhile| nwhile | dowhile | sif | nestif;

%%

#include "lex.yy.c"

main()
{
   printf("Enter the exp: ");
   yyparse();
}

