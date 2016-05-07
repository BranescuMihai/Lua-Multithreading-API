require "math"
require "table"

--these 2 variables are the only ones received from the main program
local obj_recv1, obj_recv2 = ...

local ok = 1
local string_primes = ""	
local table_primes = {}
local i = 0
local j = 0
 
--algorithm used to determine the prime numbers in a certain range 			
for i = obj_recv1, obj_recv2 do
	for j = 2, math.sqrt(i) do 
		if i%j == 0 then
			ok = 0			
			break
		end
	end	

	if ok == 1 then
		--hold their values in a table for performance improvement
		table_primes[#table_primes+1] = i
	end

	ok = 1
end

--transform the table into a string
string_primes = table.concat(table_primes, " ")

return string_primes
