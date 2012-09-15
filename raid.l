%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
[0-9]+ 		{ 	return NUMBER;		}
help		{	return HELP;		}
show		{	return SHOW;		}
all		{	return ALL;		}
goto		{ 	return GOTO;		}
create		{ 	return CREATE;		}
delete		{ 	return DELETE;		}
node		{ 	return NODE;		}
loadkey		{	return LOADKEY;		}
node[0-9]+	{	yylval=strdup(yytext);return NODEDEFINE;	}

[ \t]+ 	/* ignore whitespace */;
#.*	/* comments */;

"="      { return EQ; }
"!="     { return NE; }
"<"      { return LT; }
"<="     { return LE; }
">"      { return GT; }
">="     { return GE; }
"+"      { return PLUS; }
"-"      { return MINUS; }
"*"      { return MULT; }
"/"      { return DIVIDE; }
")"      { return RPAREN; }
"("      { return LPAREN; }
":="     { return ASSIGN; }
";"      { return SEMICOLON; }


[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} 	{ yylval=strdup(yytext); return IP; }
[a-zA-Z0-9\/.-]+ 				{ yylval=strdup(yytext); return FILENAME;	}
\n		{	return EOL;		}
.		{	return yytext[0];	}
%%
