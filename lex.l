%{
#include <stdio.h>
#include "y.tab.h"
%}
%%
help		{	return HELP;		}
multi		{ 	return MULTI;		}
nodes		{	return NODES;		}
node[0-9]+	{	yylval=strdup(yytext);return NODE;	}

[ \t]+ 	/* ignore whitespace */;
#.*	/* comments */;

"="      { return EQ; }
";"      { return SEMICOLON; }


[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3} 	{ yylval=strdup(yytext); return IP; }
\n		{	return EOL;		}
.		{	return yytext[0];	}
%%
