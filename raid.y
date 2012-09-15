%{
#include <stdio.h>
#include <string.h>
#include "raid.h"
#include "nodes.h"

extern FILE * yyin;

int yydebug=1; 
const char * USER = "root" ;

struct node_list mylist;
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
	if (yyin != stdin)
	{
		yyin = stdin;
        	return 0;
	}

	return 1;
} 
  
int main(int argc, char *argv[])
{
	node_init(&mylist);
	NOTICE("GeoBean Cluster Management Console (v9.0)");
	NOTICE("Type \"help\" for help.");
	NOTICE("Loading nodes.ini ...");
	FILE * nodes;
	if ((nodes = fopen("./nodes.ini","rb")) != NULL)
	{
		yyin = nodes;
		yyparse();
		fclose(nodes);
	}
	
	
} 

%}

%token EOL
%token NUMBER
%token HELP 
%token SHOW
%token ALL
%token IP
%token GOTO
%token CREATE
%token DELETE
%token NODE
%token FILENAME
%token LOADKEY 
%token NODEDEFINE

%token EQ
%token NE
%token LT
%token LE
%token GT
%token GE
%token PLUS
%token MINUS
%token MULT
%token DIVIDE
%token RPAREN
%token LPAREN
%token ASSIGN
%token SEMICOLON

%%
commands: /* empty */
        | commands command { SHOWPROMPT; }
	;

command:help EOL
	| show EOL
	| goto EOL
	| node_define EOL
	| EOL
	| error EOL { yyerrok; }
        ;

help:   HELP SHOW {
		NOTICE("SHOW commands:");
		HLP("SHOW ALL \t show summary for all nodes.");
		HLP("SHOW IP \t show detail for special nodes.");
	};
	
	| HELP CREATE {
		NOTICE("CREATE commands:");
	};

	| HELP GOTO {
		NOTICE("GOTO commands:");
		NOTICE("GOTO IP \t request a shell for that node.");
	};

	| HELP NODE {
		HLP("Use 'nodeNumber = IP' to define a node");
		HLP("ex: node221 = 172.32.72.221");
	};

	| HELP {
                NOTICE("HELP Commands:");
                HLP("HELP SHOW \t show help for SHOW.");
                HLP("HELP CREATE \t show help for CREATE.");
                HLP("HELP GOTO \t show help for GOTO.");
                HLP("HELP NODE \t show help for NODE.");
        };

show: 	SHOW ALL {
		if (list_empty(&mylist.list))
		{
			ERR("Nodes not defined");
		}
		else
		{
			NOTICE("-----------\t Summary for all nodes \t --------------");
		  	char * cmd;
        	        if (ae_load_file_to_memory(__SCRIPT_NODE_SUM__, &cmd) > 0)
        	        {
				struct node_list * tmp;
				struct list_head *pos, *q;

				list_for_each(pos, &mylist.list){
					tmp = list_entry(pos, struct node_list, list);
        	                	remote_call(tmp->ip, USER,"",cmd);
				}
        	                free(cmd);
        	        }
			else
			{
				ERR_CORRUPT;
			}
		}
	};
	| SHOW IP{
		printf("Sumary for node -- %s\n", $2);
		char * cmd;
                if (ae_load_file_to_memory(__SCRIPT_NODE_SUM__, &cmd) > 0)
                {
                        remote_call($2,USER,"",cmd);
                        free(cmd);
                }
                else
                {
                        ERR_CORRUPT;
                }
	};
	| SHOW {
		NOTICE("Show what ?");
	};

goto:	GOTO IP {
		printf("Connected to %s\n", $2);
	};
	| GOTO {
		NOTICE("Goto Where ?");
	};


node_define: NODEDEFINE EQ IP {
		node_add(&mylist, $1, $3);
		printf("%s --> %s \tOK!\n",$1,$3);
	};

	| NODEDEFINE error {
		NOTICE("example: node01 = 172.32.72.1");
		yyerrok;
	};
	
%%
