mix-lua-c-example
=====================
* driver (driver.c + sleep.c): calls main.lua (main.lc)
* main.lua: calls clock.lua (could call other files in future)
* clock.lua: prints contents of /etc/passwd in 1 second intervals; makes use of compiled wait_mark() and wait_execute()
* sleep.c: implements wait_mark() and wait_execute(). The latter sleeps for number of milliseconds given with the former.
