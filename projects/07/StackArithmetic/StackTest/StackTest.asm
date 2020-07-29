@256
D=A
@SP
M=D

// @256

// D=A

// @SP

// M=D

// |  RAM[0]  | RAM[256] | RAM[257] | RAM[258] | RAM[259] | RAM[260] |

// |     266  |      -1  |       0  |       0  |       0  |      -1  |

// | RAM[261] | RAM[262] | RAM[263] | RAM[264] | RAM[265] |

// |       0  |      -1  |       0  |       0  |     -91  |

// |  RAM[0]  | RAM[256] | RAM[257] | RAM[258] | RAM[259] | RAM[260] |

// |     266  |      -1  |       0  |       0  |       0  |      -1  |

// | RAM[261] | RAM[262] | RAM[263] | RAM[264] | RAM[265] |

// |       0  |      -1  |       0  |       0  |     -91  |

// load StackTest.asm,

// output-file StackTest.out,

// compare-to StackTest.cmp,

// output-list RAM[0]%D2.6.2

// RAM[256]%D2.6.2 RAM[257]%D2.6.2 RAM[258]%D2.6.2 RAM[259]%D2.6.2 RAM[260]%D2.6.2;

// set RAM[0] 256,

// repeat 1000 {

// ticktock;

// }

// output;

// output-list RAM[261]%D2.6.2 RAM[262]%D2.6.2 RAM[263]%D2.6.2 RAM[264]%D2.6.2 RAM[265]%D2.6.2;

// output;

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.1
D;JEQ
@SP
A=M-1
M=0
@EQ.after.1
0;JMP
(EQ.true.1)
@SP
A=M-1
M=-1
(EQ.after.1)

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.2
D;JEQ
@SP
A=M-1
M=0
@EQ.after.2
0;JMP
(EQ.true.2)
@SP
A=M-1
M=-1
(EQ.after.2)

// push constant 16
@16
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 17
@17
D=A
@SP
A=M
M=D
@SP
M=M+1

// eq
@SP
AM=M-1
D=M
A=A-1
D=M-D
@EQ.true.3
D;JEQ
@SP
A=M-1
M=0
@EQ.after.3
0;JMP
(EQ.true.3)
@SP
A=M-1
M=-1
(EQ.after.3)

// push constant 892
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.4
D;JLT
@SP
A=M-1
M=0
@LT.after.4
0;JMP
(LT.true.4)
@SP
A=M-1
M=-1
(LT.after.4)

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 892
@892
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.5
D;JLT
@SP
A=M-1
M=0
@LT.after.5
0;JMP
(LT.true.5)
@SP
A=M-1
M=-1
(LT.after.5)

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 891
@891
D=A
@SP
A=M
M=D
@SP
M=M+1

// lt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@LT.true.6
D;JLT
@SP
A=M-1
M=0
@LT.after.6
0;JMP
(LT.true.6)
@SP
A=M-1
M=-1
(LT.after.6)

// push constant 32767
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.7
D;JGT
@SP
A=M-1
M=0
@GT.after.7
0;JMP
(GT.true.7)
@SP
A=M-1
M=-1
(GT.after.7)

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32767
@32767
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.8
D;JGT
@SP
A=M-1
M=0
@GT.after.8
0;JMP
(GT.true.8)
@SP
A=M-1
M=-1
(GT.after.8)

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 32766
@32766
D=A
@SP
A=M
M=D
@SP
M=M+1

// gt
@SP
AM=M-1
D=M
A=A-1
D=M-D
@GT.true.9
D;JGT
@SP
A=M-1
M=0
@GT.after.9
0;JMP
(GT.true.9)
@SP
A=M-1
M=-1
(GT.after.9)

// push constant 57
@57
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 31
@31
D=A
@SP
A=M
M=D
@SP
M=M+1

// push constant 53
@53
D=A
@SP
A=M
M=D
@SP
M=M+1

// add
@SP
AM=M-1
D=M
A=A-1
M=D+M

// push constant 112
@112
D=A
@SP
A=M
M=D
@SP
M=M+1

// sub
@SP
AM=M-1
D=M
A=A-1
M=M-D

// neg
@SP
A=M-1
M=-M
// and
@SP
AM=M-1
D=M
A=A-1
M=D&M

// push constant 82
@82
D=A
@SP
A=M
M=D
@SP
M=M+1

// or
@SP
AM=M-1
D=M
A=A-1
M=D|M

// not
@SP
A=M-1
M=!M

// load StackTest.vm,

// output-file StackTest.out,

// compare-to StackTest.cmp,

// output-list RAM[0]%D2.6.2

// RAM[256]%D2.6.2 RAM[257]%D2.6.2 RAM[258]%D2.6.2 RAM[259]%D2.6.2 RAM[260]%D2.6.2;

// set RAM[0] 256,

// repeat 38 {

// vmstep;

// }

// output;

// output-list RAM[261]%D2.6.2 RAM[262]%D2.6.2 RAM[263]%D2.6.2 RAM[264]%D2.6.2 RAM[265]%D2.6.2;

// output;
