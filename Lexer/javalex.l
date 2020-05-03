%{
FILE* yyin;
%}

DIGIT [0-9]
TEXT [A-Za-z]
INT {DIGIT}+
FLOAT {DIGIT}*[.]{INT}
OPERATOR "+"|"-"|"/"|"%"|"*"
LOGICAL_OP "&&"|"||"|"!"
RELATIONS "<"|">"|"<="|">="|"=="|"!="
UNI_OP "++"|"--"
KEYWORDS "class"|"static"
ACCESS "public"|"private"|"protected"|""
DATATYPE "int"|"float"|"double"|"long"|"void"|"String"
CONDITIONAL "if"|"else"|"else if"|"switch"|"case"
LOOP "for"|"while"|"do"
IDENTIFIER {TEXT}({DIGIT}|{TEXT}|"_")*
FUNCTION {ACCESS}{DATATYPE}{IDENTIFIER}"("({DATATYPE}{IDENTIFIER})*")"
SEMICOLON ";"

%%
[ \n\t]+ ;
{INT} {printf("%s\t==> INTEGER\n",yytext);}
{FLOAT} {printf("%s\t==> REAL CONSTANT\n",yytext);}
{OPERATOR} {printf("%s\t==> OPERATOR\n",yytext);}
{FUNCTION} {printf("%s\t==> FUNCTION\n",yytext);}
{LOGICAL_OP} {printf("%s\t==> LOGICAL OP\n",yytext);}
{CONDITIONAL} { printf("%s\t==> CONDITIONAL\n",yytext);}
{LOOP} {printf("%s\t==> LOOP\n",yytext);}
{DATATYPE}  {printf("%s\t==> DATATYPE\n",yytext);}
{ACCESS} {printf("%s\t==> ACCESS SPECIFIER\n",yytext);}
{KEYWORDS} {printf("%s\t==> KEYWORDS\n",yytext);}
{IDENTIFIER} {printf("%s\t==> IDENTIFIER\n",yytext);}
{UNI_OP} {printf("%s\t==> UNARY OPERATOR\n",yytext);}
{RELATIONS} {printf("%s\t==> RELATIONAL OP\n",yytext);}
{SEMICOLON} {printf("%s\t==> SEMICOLON\n",yytext);}
"=" {printf("%s\t==> ASSIGNMENT OP\n",yytext);}
"{"  {printf("%s\t==> BLOCK BEGIN\n",yytext);}
"}"  {printf("%s\t==> BLOCK END\n",yytext);}
"("  {printf("%s\t==> PARANTHESIS BEGIN\n",yytext);}
")"  {printf("%s\t==> PARENTHESIS END\n",yytext);}
. ;
%%
int yywrap()
{
	return 1;
}

int main(int argc,char* argv[])
{
	yyin=fopen(argv[1],"r");
	yylex();
	fclose(yyin);
}
