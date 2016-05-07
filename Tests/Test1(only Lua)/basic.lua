
local luaspmd = require "luaspmd"

--creates 4 instances of the process with the code from process_code.lua
luaspmd.init("process_code.lua", 4)

--distributes 4 tables with work for the 4 instances
luaspmd.distribute(1, {1,2}, {3,4}, {5,6}, {7,8})

--get the results from all 4 instances in the form of a table
results = luaspmd.getresults(1,4)

--stop all 4 instances
luaspmd.stop(1,4)

print(results[1],results[2],results[3],results[4])
