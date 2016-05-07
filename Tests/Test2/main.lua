
local luaspmd = require "luaspmd"

function love.load()
	--creates 2 instances of the process with the code from process.lua and 2 with 
	--the code from process2.lua
	luaspmd.init("./Test2/process.lua", 2, "./Test2/process2.lua", 2)
	
	--variable used to print results 1 second apart
	schedule = 0
	
	--variable used to change results of the first process by 1 
	index = 1
	
	results1 = {}
	results2 = {}
	for i = 1,2 do
		results1[i] = "Nothing yet"
		results2[i] = "Nothing yet"
	end
end

function love.update(dt)
	schedule = schedule + dt
	if schedule > 1 and index < 10 then
		--distributes 2 tables with work for the 2 instances of process with the
		--assigned number '1', that is 'process.lua'
		luaspmd.distribute(1, {index,index+1}, {index+2,index+3})
		
		--distributes 2 tables with work for the 2 instances of process with the
		--assigned number '2', that is 'process2.lua'
		luaspmd.distribute(2, {"A", "B", "C"}, {"D", "E", "F"})
		
		--get the results from the 2 instances of process.lua in the form of a table
		results1 = luaspmd.getresults(1,2)
	
		--get the results from the 2 instances of process2.lua in the form of a table
		results2 = luaspmd.getresults(2,2)
		
		schedule = 0
		index = index+1
	else if index == 10 then		
				--stop both processes
				luaspmd.stop(1,2)
				luaspmd.stop(2,2)
				--increment by 1 so the program won't enter this if statement again
				index = index + 1
			end
	end
end

function love.draw()
	if index < 10 then
		love.graphics.print("Test number: "..index.." out of 10", 100,300)
	else
		love.graphics.print("Final test", 100,300)
	end
	love.graphics.print(results1[1],100,100)
	love.graphics.print(results1[2],200,100)
	love.graphics.print(results2[1],300,100)
	love.graphics.print(results2[2],400,100)
end


