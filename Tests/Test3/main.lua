local luaspmd = require "luaspmd"

function love.load()

	--variable used so results are displayed 1 second apart
	schedule = 0
	
	--variable to modify the ranges
	i = 1
	
	--ranges where we search for primes
	range1 = {["from"] = i*2, ["to"] = i*10}
	range2 = {["from"] = i*11, ["to"] = i*20}
	range3 = {["from"] = i*21, ["to"] = i*30}
	range4 = {["from"] = i*31, ["to"] = i*40}
	
	--strings of primes that are printed using the draw functions
	prime_str = {"", "", "", ""}
	
	--variable used to test if prime_str is nil
	prime_found = {false, false, false, false}
	
	luaspmd.init("./Test3/process.lua",4)
	
	--variables used to stop the processes after 6 iterations
	finish = 0
	stopped = false
end

function love.update(dt)
	schedule = schedule + dt
	
	if schedule > 1 and stopped == false then
	
		--distribute work to all 4 processes
		luaspmd.distribute(1,{range1.from, range1.to},{range2.from, range2.to},{range3.from, range3.to},{range4.from, range4.to})
		
		prime_str = luaspmd.getresults(1,4)
		
		--only when prime_found is true the result is displayed, because the graphics.print function cannot print nil
		for i = 1,4 do
			if prime_str[i] ~= nil then
				prime_found[i] = true
			else 
				prime_found[i] = false
			end
		end
		
		schedule = 0
		finish = finish + 1
		
		--ranges are reselected 
		i = i + 1
		range1 = {["from"] = i*2, ["to"] = i*10}
		range2 = {["from"] = i*11, ["to"] = i*20}
		range3 = {["from"] = i*21, ["to"] = i*30}
		range4 = {["from"] = i*31, ["to"] = i*40}
	end
	
	if finish == 6 then
		luaspmd.stop(1,4)
		stopped = true
		finish = finish + 1
	end
end


function love.draw()

	for i = 1,4 do
		if (prime_found[i]) then
			love.graphics.print(prime_str[i], 100, i*100)
		end
	end
	
	--printing at the bottom of the screen a counter
	if finish < 6 then
		love.graphics.print("Test number: "..finish.." out of 6", 100,500)
	else
		love.graphics.print("Final test", 100,500)
	end
end


