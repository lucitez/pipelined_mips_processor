# Makefile to generate bare metal code to run on a simulated (Verilog) processor
# from assembly code.
# Bucknell University
# Alan Marchiori 2014

AS=mipsel-linux-as
LD=mipsel-linux-ld
SREC=srec_cat

# these are the flags we need for bare metal code generation
CFLAGS=-mno-abicalls -fpic -nostdlib -static
LDFLAGS=-L/usr/remote/mipsel/lib/gcc/mipsel-buildroot-linux-uclibc/4.6.3 -lgcc

# change this line as needed
ASMSOURCE=programs/fib2.s

SREC_OUTPUT=$(ASMSOURCE:.s=.srec)
VERILOG_OUTPUT=$(ASMSOURCE:.s=.v)
OBJECTS=$(ASMSOURCE:.s=.o)

add_test:
	echo "\`define PROGRAM_START 32'h00400020" > src/program.h
	echo "\`define PROGRAM_NAME \"programs/add_test.v\"" >> src/program.h
	echo "src/mips.h" > files.txt
	echo "src/program.h" >> files.txt
	ls -d src/* >> files.txt
	iverilog -c files.txt

forwarding_test:
	echo "\`define PROGRAM_START 32'h00400020" > src/program.h
	echo "\`define PROGRAM_NAME \"programs/forwarding_test.v\"" >> src/program.h
	echo "src/mips.h" > files.txt
	echo "src/program.h" >> files.txt
	ls -d src/* >> files.txt
	iverilog -c files.txt

hello:
	echo "\`define PROGRAM_START 32'h00400030" > src/program.h
	echo "\`define PROGRAM_NAME \"programs/hello.v\"" >> src/program.h
	echo "src/mips.h" > files.txt
	echo "src/program.h" >> files.txt 
	ls -d src/* >> files.txt
	iverilog -c files.txt

branch_test:
	echo "\`define PROGRAM_START 32'h00400020" > src/program.h
	echo "\`define PROGRAM_NAME \"programs/branch_test.v\"" >> src/program.h
	echo "src/mips.h" > files.txt
	echo "src/program.h" >> files.txt 
	ls -d src/* >> files.txt
	iverilog -c files.txt

fib:
	echo "\`define PROGRAM_START 32'h00400030" > src/program.h
	echo "\`define PROGRAM_NAME \"programs/fib.v\"" >> src/program.h
	echo "src/mips.h" > files.txt
	echo "src/program.h" >> files.txt 
	ls -d src/* >> files.txt
	iverilog -o vcd -c files.txt


all: $(OBJECTS)
		# now link to a motorola SRecord
		$(LD) $(LDFLAGS) --oformat=srec $(OBJECTS) -o $(SREC_OUTPUT)
		# convert the SRecord file into a Verilog file
		$(SREC) $(SREC_OUTPUT) -Byte-swap 4 -o $(VERILOG_OUTPUT) -VMem

%.o: %.s
		# assemble to a motorola srecord file
		$(AS) $< -o $@

clean:
		@echo $(OBJECTS)
		rm -f $(OBJECTS) $(SREC_OUTPUT) $(VERILOG_OUTPUT)
