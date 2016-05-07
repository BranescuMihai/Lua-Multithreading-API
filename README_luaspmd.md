*****************************************************
*
* [README]                                          
*
****************************************************
--The use of multiple threads gives a boost in performance for the program, so 
--this library should be used when the latency is important.
--The following functions are useful when used with Love2D because it allows 
--the developer to have only minimum knowledge of multithreading, communication 
--between the processes and the main program as well as the initialization 
--being handled by the functions.

--Model:SPMD(single program, multiple data) is the style chosen for this library.
--In SPMD, multiple autonomous processors simultaneously execute the same 
--task with different input in order to obtain results faster. This is the most
--used style of parallel programming. Our model is based on execution threads
--with no shared memory, which use message passing for synchronization and 
--communication. The concurrency part is ensured by a library called 'luaproc'.
--Each process runs as an exclusive coroutine inside its own Lua state. These 
--processes are run by workers, which are kernel threads implemented with the 
--POSIX Threads library(pthreads). There is no ﬁxed relationship between 
--workers and Lua processes. Each worker repeatedly gets a process from the 
--ready queue and runs it until it ﬁnishes or blocks. Even though we use kernel 
--threads, there is no memory shared among Lua processes, because each has its 
--own Lua state.

--For more information on concurrent programming in Lua, please read the paper
--'Exploring Lua for Concurrent Programming'.

--In this library, at first, a designated number of processes is created using 
--the code from the files you provided in the 'init' function, as well as the 
--channels used to communicate with the main program(send and receive). Then, 
--all the information sent with the 'distribute' function as a table are 
--unpacked and the values are assigned to the variables from the code files, 
--provided that they are equal to vararg(...). All the values that your code 
--returns is added to a table which is then sent back to the main program, 
--returned by the 'getresults' function. The processes are created to run an 
--infinite loop, so you must use the 'stop' function in order to finish the 
--loop.


luaspmd.init( <file name first process>, <number of workers first process>,
<file name second process>, <number of workers second process>, ...) 
--This function initializes a number of processes containing the code from 
--the given files.
--It accepts as parameters a sequence as follows: file1, number1, file2,
--number2, file3, number3, ...
--Each process given as parameter is assigned a number, in the order they were
--written.

luaspmd.distribute(<assigned number of process type>, {data1}, {data2},...)
--Distributes work to the instances of the selected process type.
--First parameter is the number of the process assigned from luaspmd.init.
--Each data package(numbers,strings,tables,...) must be sent as a table.
--The number of packages sent must be equal to the number of workers assigned
--for this type of process.
--Obs: Information is not retrieved in a certain order from the processes, so 
--if you have 4 processes and send packages like: 1,2,3,4 you might receive in 
--the results table something like this: 1,4,3,2.

luaspmd.getresults(<assigned number of process type>, <number of workers for 
that process>)
--Returns the results of all the instances of the selected process as a table.

luaspmd.stop(<assigned number of process type>, <number of workers for that 
process>)
--Stops all instances of the selected process.
--Obs: All processes are created with an infinite loop, you must use this 
--function when you wish to finish otherwise the program will block.

serialize(<table>)
--Returns a serialized table in the form of a string.
--Obs: If the table is nested, you should use this function and send the 
--resulting string with luaspmd.distribute instead of the table itself.

deserialize(<string>)
--Returns a table containing the information from the string(previously 
--serialized)
--Obs: This function is helpful when dealing with nested tables, it can be used
--to retrieve the information from a serialized string sent via 
--luaspmd.distribute.
