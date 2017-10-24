# Pipelined Cpu Processor
## CSCI320

## Design
We followed the Harris & Harris diagram pretty closely with wire/reg names and layout so that we had something to reference to quickly determine what the wire should be named.  That along with a uniform wire/reg/module naming convention, it was easy to work without checking the variable names.  There are a few points where we had to deviate from the diagram to add features that weren't explicitly in the diagram.  This includes the string printing, jumping, and the instruction properties.

## Programs

* add_test.v
    * Shows that add_test works from first project and some forwarding works.
    * Should output "4" since it is loading 2 into register and then adding it to itself and printing the result
    * The actual instructions are commented in programs/add_test.v
* forwarding_test.v
    * Shows that all the different kinds of forwarding (EX->EX, MEM->EX, MEM->MEM) are working.
    * Should output "32" then "5" then "14".
    * The actual instructions are commented in programs/forwarding_test.v
* hello.v
    * Shows that hello world is working.  This includes function calls and printing a string from memory.
    * Should output "Hello world, everything is terrible!"
    * This is the same binary as given in the project description with a longer string added on.
* branch_test.v
    * Shows that branching is working.  
    * Should output "5" with successful branching
* fib.v
    * Shows that Fibonnacci called with 5 executes correctly.
    * Should output "5" if executed correctly
    * Currently under heavy development and currently doesn't work.


## Compilation
1. Choose one of the following programs to compile
	* add\_test
	* forwarding\_test
	* hello
	* branch_test
	* fib (doesn't work)

2. Run `make <program>`
3. Result is in `a.out`

## Execution
1. Run `./a.out`

## Testing
1. Move into the test directory - `cd test`
2. Run a single test - `iverilog -c <TEST_NAME>\_files.txt`
   Or run all of the tests - `chmod +x runTests && ./runTests`

Note: A test failed if there is any text that says `<TESTNAME> - first: <VAL> does not equal second: <VAL>`
