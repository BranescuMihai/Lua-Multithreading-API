--all variables that are to be received from the main program should be 
--declared like this, equal to the vararg (...)
local string1,string2,string3 = ...

local string_sum = string1 .. string2 .. string3

return string_sum
