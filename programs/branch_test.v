/* 00000003: add_test.srec */
@00100000 00000314 00000000 00000000 00000000 00000000 00000000
@00100008 24020001 24080002 24090001 11090008 00000000 24040001 24040005
@0010000F 01294820 11090003 00000000 00000000 2404000A 0000000C 00000000
@00100016 00000000 00000000

/*

ADDIU $v0 $zero 0x0001
ADDIU $t0 $zero 0x0002
ADDIU $t1 $zero 0x0001
BEQ $t0 $t1 0x0008
NOP
ADDIU $a0 $zero 0x0001
ADDIU $a0 $zero 0x0005
ADD $t1 $t1 $t1
BEQ $t0 $t1 0x0003
NOP
NOP
ADDIU $a0 $zero 0x000A
syscall
