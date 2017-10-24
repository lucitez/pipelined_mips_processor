// //MEM->MEM test
// //Expected result: 6
// /* 00000003: add_test.srec */
// @00100000 00000314 00000000 00000000 00000000 00000000 00000000
// @00100008 24090003 AFA90000 8FAA0000 014A2020 0000000C 2402000A 0000000C
// @0010000F 00000000
// /*

// li t1, 3
// sw t1, 0(sp) //MEM->MEM
// lw t2 0(sp) //MEM->MEM
// add a0, t2, t2 //MEM->EX
// syscall
// li v0, 10
// syscall
// */

//StallD/StallF testing with store and load word
//Expected result: 4
/* 00000003: add_test.srec */
@00100000 00000314 00000000 00000000 00000000 00000000 00000000
@00100008 24090002 00000000 00000000 00000000 00000000 AFA90000 00000000 00000000 00000000 00000000 8FA90000 01292020 2402000A 0000000C
@0010000F 00000000
/*

li t1, 2
NOP
NOP
NOP
NOP
sw t1, 0(sp)
NOP
NOP
NOP
NOP
lw t1 0(sp)
add a0, t1, t1
li v0, 10
syscall
*/

// //Consecutive MEM->EX
// //Expected result: 4, 6, 8
// /* 00000003: add_test.srec */
// @00100000 00000314 00000000 00000000 00000000 00000000 00000000
// @00100008 24090002 00000000 01292020 0000000C 24090003 00000000 01292020 0000000C 24090004 00000000 01292020 0000000C 2402000A 0000000C
// @0010000F 00000000
// /*

// li t1, 2
// NOP
// add a0, t1, t1
// li t1, 3
// NOP
// add a0, t1, t1
// li t1, 4
// NOP
// add a0, t1, t1
// syscall
// li v0, 10
// syscall
// */

// //Single MEM->EX
// //Expected result: 4
// /* 00000003: add_test.srec */
// @00100000 00000314 00000000 00000000 00000000 00000000 00000000
// @00100008 24090002 00000000 01292020 0000000C 2402000A 0000000C
// @0010000F 00000000
// /*

// li t1, 2
// NOP
// add a0, t1, t1
// syscall
// li v0, 10
// syscall
// */

// //MEM->EX and EX->EX
// //Expected result: 5
// /* 00000003: add_test.srec */
// @00100000 00000314 00000000 00000000 00000000 00000000 00000000
// @00100008 24080003 24090002 01282020 0000000C 2402000A 0000000C
// @0010000F 00000000
// /*

// li t0, 3
// li t1, 2
// add a0, t1, t0
// syscall
// li v0, 10
// syscall
// */


// //Consecutive EX->EX
// //Expected result: 32
// /* 00000003: add_test.srec */
// @00100000 00000314 00000000 00000000 00000000 00000000 00000000
// @00100008 24090002 01294820 01294820 01294820 01292020 0000000C 2402000A 0000000C
// @0010000F 00000000

// /*

// li t1, 2
// add t1, t1, t1 //EX->EX
// add t1, t1, t1 //EX->EX
// add t1, t1, t1 //EX->EX
// add a0, t1, t1 //EX->EX, result should be 32
// syscall
// li t0, 2
// li t2, 3
// add a0, t0, t2 //MEM->EX, result should be 5
// syscall
// li t3, 7
// sw t3, 0(sp) //MEM->MEM
// lw t4 0(sp) //MEM->MEM
// add a0, t4, t4 //MEM->EX, result should be 14
// li v0, 10
// syscall
// */
