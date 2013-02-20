#include <stdio.h>
#include <stdbool.h>
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

#include "utils.h"

int main(void)
{
	lua_State *L = luaL_newstate();
	luaL_openlibs(L);
	luaL_register(L, "wait", wait_functions);

	if (luaL_dofile(L, "main.lc"))
	{
		fprintf(stderr, "%s\n", lua_tostring(L, -1));
		lua_pop(L, 1);
	}

	lua_close(L);

	return 0;
}

