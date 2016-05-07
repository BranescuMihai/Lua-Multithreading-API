--all variables that are to be received from the main program should be 
--declared like this, equal to the vararg (...)
local a,b = ...

local c = a + b
return c
