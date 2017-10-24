@00100000 00000314 00000000 00000000 00000000 00000000 00000000
@00100008 24020001 24090002 01294820 01294820 01294820 01292020 0000000C
@0010000F 24080002 240A0003 010A2020 0000000C 240B0007 AFAB0000 8FAC0000
@00100016 018C2020 0000000C

/*
li v0, 1
li t1, 2
add t1, t1, t1 //EX->EX
add t1, t1, t1 //EX->EX
add t1, t1, t1 //EX->EX
add a0, t1, t1 //EX->EX, result should be 32
syscall

li t0, 2
li t2, 3
add a0, t0, t2 //MEM->EX, result should be 5
syscall
li t3, 7
sw t3, 0(sp) //MEM->MEM
lw t4 0(sp) //MEM->MEM

add a0, t4, t4 //MEM->EX, StallD, StallF, result should be 14
syscall
*/