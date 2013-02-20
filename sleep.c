#include <time.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>
#include <errno.h>

#include "utils.h"

static struct timespec t;

int wait_execute(lua_State *L)
{
	while (EINTR == clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL))
		;

	return 0;
}

int wait_mark(lua_State *L)
{
	if (lua_gettop(L) < 1)
		return 0;

	int param = luaL_checknumber(L, 1);

	if (param < 1)
		return 0;

	clock_gettime(CLOCK_MONOTONIC, &t);

	unsigned long int delay = param * 1000000UL;

        while (t.tv_nsec + delay >= 1000000000)
	{
                t.tv_nsec -= 1000000000;
                t.tv_sec++;
        }

	t.tv_nsec += delay;

	return 0;
}

const luaL_reg wait_functions[] =
{
	{ "execute", wait_execute },
	{ "mark", wait_mark },
	{ NULL, NULL }
};

