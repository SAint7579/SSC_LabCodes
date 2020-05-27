%{
%}

%%

"int" {return INT;}
"float" {return FLOAT;}
([a-zA-Z])("_"|[a-zA-Z0-9])* {return ID;}
";" {return SCOLON;}
"," {return COMMA;}
" " {}

%%
int yywrap()
{
	return 1;
}
