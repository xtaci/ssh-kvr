#ifndef __SCRIPT_H__
#define __SCRIPT_H__

#include <unistd.h>
#include <sys/stat.h>
#include <fcntl.h>

#define SCRIPT_PATH_LOCAL "./scripts/local/"
#define SCRIPT_OB "./.ob.tmp"

inline int call_local_script(char * script_name)
{
	char * buf[1024]; //static alloc

	sprintf(buf, "%s%s", SCRIPT_PATH_LOCAL, script_name); 
	
	if(fork()==0)
	{
		execl("/bin/sh", "sh", buf, NULL);
	}

	return 0;
	
}

inline int * get_ob()
{
	static int ob = 0;

	if (ob == 0)
	{
		ob = open(SCRIPT_OB, O_RDWR|O_SYNC|O_TRUNC);
	}

	ftruncate(ob, 0);
		
	return ob;
}

#endif //
