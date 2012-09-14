%{
#include <stdio.h>
#include <string.h>
#include "raid.h"
#include "nodes.h"

#define ERR(msg) printf("ERR: %s\n", msg);
#define HLP(msg) printf("\t%s\n", msg);
#define NOTICE(msg) printf("%s\n", msg);
#define SHOWPROMPT printf("cluster# ");


#define ERR_CORRUPT ERR("Software corrupted, please reinstall.");
int yydebug=1; 
const char * USER = "root" ;

struct node_list mylist;
 
void yyerror(const char *str)
{
        fprintf(stderr,"error: %s\n",str);
}
 
int yywrap()
{
        return 1;
} 
  
main()
{
	node_init(&mylist);
	printf("GeoBean Cluster Management Console (v9.0)\n");
	printf("Type \"help\" for help.\n\n");
	SHOWPROMPT;
        yyparse();
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

	| HELP {
                NOTICE("HELP Commands:");
                HLP("HELP SHOW \t show help for SHOW.");
                HLP("HELP CREATE \t show help for CREATE.");
                HLP("HELP GOTO \t show help for GOTO.");
        };

show: 	SHOW ALL {
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
                        ERR("Software corrupted, please reinstall.");
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
		node_list(&mylist);	
	};
	| NODEDEFINE error {
		NOTICE("example: node01 = 172.32.72.1");
		yyerrok;
	};
	
%%
