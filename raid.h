#ifndef __GMON__
#define __GMON__

#include "list.h"

int remote_call(const char * hostname, const char * username, const char * password, const char * command);
int ae_load_file_to_memory(const char *filename, char **result);

#define __SCRIPT_NODE_SUM__ "./scripts/node_sum.sh"

#endif
