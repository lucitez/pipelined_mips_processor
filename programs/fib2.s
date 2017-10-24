
fib:     file format elf32-tradlittlemips


Disassembly of section .text:

00400090 <_ftext>:
  400090:	24020004 	li	v0,4
  400094:	0000000c 	syscall
  400098:	03e00008 	jr	ra
  40009c:	00000000 	nop

004000a0 <__start>:
  4000a0:	3c1d7fff 0c100059 37bdfffc 2402000a     ...<Y......7...$
  4000b0:	0000000c 00000000 00000000 00000000     ................

004000c0 <fibonacci>:
  4000c0:	27bdffe0 	addiu	sp,sp,-32
  4000c4:	afbf001c 	sw	ra,28(sp)
  4000c8:	afbe0018 	sw	s8,24(sp)
  4000cc:	afb00014 	sw	s0,20(sp)
  4000d0:	03a0f021 	move	s8,sp
  4000d4:	afc40020 	sw	a0,32(s8)
  4000d8:	8fc20020 	lw	v0,32(s8)
  4000dc:	00000000 	nop
  4000e0:	14400004 	bnez	v0,4000f4 <fibonacci+0x34>
  4000e4:	00000000 	nop
  4000e8:	00001021 	move	v0,zero
  4000ec:	10000016 	b	400148 <fibonacci+0x88>
  4000f0:	00000000 	nop
  4000f4:	8fc30020 	lw	v1,32(s8)
  4000f8:	24020001 	li	v0,1
  4000fc:	14620004 	bne	v1,v0,400110 <fibonacci+0x50>
  400100:	00000000 	nop
  400104:	24020001 	li	v0,1
  400108:	1000000f 	b	400148 <fibonacci+0x88>
  40010c:	00000000 	nop
  400110:	8fc20020 	lw	v0,32(s8)
  400114:	00000000 	nop
  400118:	2442ffff 	addiu	v0,v0,-1
  40011c:	00402021 	move	a0,v0
  400120:	0c100030 	jal	4000c0 <fibonacci>
  400124:	00000000 	nop
  400128:	00408021 	move	s0,v0
  40012c:	8fc20020 	lw	v0,32(s8)
  400130:	00000000 	nop
  400134:	2442fffe 	addiu	v0,v0,-2
  400138:	00402021 	move	a0,v0
  40013c:	0c100030 	jal	4000c0 <fibonacci>
  400140:	00000000 	nop
  400144:	02021021 	addu	v0,s0,v0
  400148:	03c0e821 	move	sp,s8
  40014c:	8fbf001c 	lw	ra,28(sp)
  400150:	8fbe0018 	lw	s8,24(sp)
  400154:	8fb00014 	lw	s0,20(sp)
  400158:	27bd0020 	addiu	sp,sp,32
  40015c:	03e00008 	jr	ra
  400160:	00000000 	nop

00400164 <main>:
  400164:	27bdffe8 	addiu	sp,sp,-24
  400168:	afbf0014 	sw	ra,20(sp)
  40016c:	afbe0010 	sw	s8,16(sp)
  400170:	03a0f021 	move	s8,sp
  400174:	24040005 	li	a0,5
  400178:	0c100030 	jal	4000c0 <fibonacci>
  40017c:	00000000 	nop
  400180:	03c0e821 	move	sp,s8
  400184:	8fbf0014 	lw	ra,20(sp)
  400188:	8fbe0010 	lw	s8,16(sp)
  40018c:	27bd0018 	addiu	sp,sp,24
  400190:	03e00008 	jr	ra
  400194:	00000000 	nop
	...
