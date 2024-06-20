movi R1, 0x03
movi R2, 0x60
loadi R4, 0x6
load R4, R1
jz R4, 0x0C
movi R5, 0xE1
andi R5, R5, 0xD3
add R3, R1, R2
movi R2, 0x00
add R0, R3, R1
addi R1, R1, 0x01
jumpi 0x02
nop
nop
nop
movi R1, 0x03
jump R1
