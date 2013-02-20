local P = {}
clock = P
local print = _G.print
local wait = _G.wait
local io = io
setfenv(1, P)

function test()
	for line in io.lines("/etc/passwd") do
		wait.mark(1000)
		print(line)
		wait.execute();
	end
end
