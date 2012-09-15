#ifndef __GMON__
#define __GMON__

#include "list.h"

#define ERR(msg) printf("ERR: %s\n", msg);
#define HLP(msg) printf("\t%s\n", msg);
#define NOTICE(msg) printf("%s\n", msg);
#define SHOWPROMPT printf("cluster# ");

#define ERR_CORRUPT ERR("Software corrupted, please reinstall.");

int remote_call(const char * hostname, const char * username, const char * password, const char * command);
int ae_load_file_to_memory(const char *filename, char **result);

#define __SCRIPT_NODE_SUM__ "./scripts/node_sum.sh"

#endif
