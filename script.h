#ifndef __SCRIPT_H__
#define __SCRIPT_H__

#include <unistd.h>
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

inline FILE * get_ob()
{
	static FILE * ob = NULL;

	if(!ob)
	{
		ob = fopen(SCRIPT_OB,"wb");
	}

	if (ob)
	{
		ftruncate(fileno(ob),0);
	}
	
	return ob;
}

#endif //
