%{
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include "nodes.h"

extern FILE * yyin;

int yydebug=1; 
const char * USER = "root" ;
const char * PASSWD= "" ;

struct node_list mylist;
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
	if (yyin != stdin)
	{
		printf("nodes.ini loaded.");
		yyin = stdin;
        	return 0;
	}

	return 1;
} 
  
int main(int argc, char *argv[])
{
	node_init(&mylist);
	printf("SSH-KVR\n");
	printf("Type \"help\" for help.\n");
	printf("Loading nodes.ini ...\n");
	FILE * nodes;
	if ((nodes = fopen("./nodes.ini","rb")) != NULL)
	{
		yyin = nodes;
		yyparse();
		fclose(nodes);
	}
	
} 

int prompt() {
	printf("ssh-kvr$ ");
}

%}

%token EOL
%token HELP 
%token NODE
%token NODES
%token MULTI 
%token EQ
%token IP
%token SEMICOLON

%%

commands: /* empty */
        | commands command
;

command:help EOL
	| switch EOL
	| define EOL
	| nodes EOL
	| multi EOL
	| EOL { prompt(); }
	| error EOL { yyerrok;}
;

help: HELP {
	printf("Commands:\n");
	printf("define node:\t node01=192.168.0.xx\n");
	printf("switch to node:\t node01\n");
	printf("list nodes:\t nodes\n");
	prompt();
};

nodes: NODES {
	printf("list nodes\n");
	prompt();
};

switch:	NODE {
	printf("send commands only to %s\n", $1);
	prompt();
};

multi: MULTI {
	printf("send commands to all nodes\n");
	prompt();
};

define: NODE EQ IP {
	node_add(&mylist, $1, $3);
	printf("%s --> %s \tOK!\n",$1,$3);
	prompt();
};
%%
