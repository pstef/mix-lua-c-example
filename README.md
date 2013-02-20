mix-lua-c-boilerplate
=====================
* driver.c: calls main.lua (main.lc)
* main.lua: calls clock.lua (could call other files in future)
* clock.lua: prints contents of /etc/passwd in 1 second intervals; makes use of sleep.c
* sleep.c: implements a function that sleeps for given number of milliseconds
