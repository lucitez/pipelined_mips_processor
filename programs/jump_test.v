/* 00000003: add_test.srec */
@00100000 00000314 00000000 00000000 00000000 00000000 00000000
@00100008 24080001 24090002 24020001 01292020 0000000C 2402000A 08100008 00000000 0000000C 

/*

li t0, 1
li t1, 2
li v0, 1
add a0, t0, t1
syscall
li v0, 10
syscall

*/