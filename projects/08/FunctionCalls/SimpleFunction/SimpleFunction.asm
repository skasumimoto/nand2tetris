@256
D=A
@SP
M=D

// | RAM[0] | RAM[1] | RAM[2] | RAM[3] | RAM[4] |RAM[310]|

// |    311 |    305 |    300 |   3010 |   4010 |   1196 |

// load SimpleFunction.asm,

// output-file SimpleFunction.out,

// compare-to SimpleFunction.cmp,

// output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1

// RAM[3]%D1.6.1 RAM[4]%D1.6.1 RAM[310]%D1.6.1;

// set RAM[0] 317,

// set RAM[1] 317,

// set RAM[2] 310,

// set RAM[3] 3000,

// set RAM[4] 4000,

// set RAM[310] 1234,

// set RAM[311] 37,

// set RAM[312] 1000,

// set RAM[313] 305,

// set RAM[314] 300,

// set RAM[315] 3010,

// set RAM[316] 4010,

// repeat 300 {

// ticktock;

// }

// output;

// function SimpleFunction.test 2
(SimpleFunction.test)
@SP
A=M
M=0
A=A+1
M=0
A=A+1
D=A
@SP
M=D

// push local 0
@LCL
D=M
@0
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1

// push local 1
@LCL
D=M
@1
A=D+A
D=M
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

// not
@SP
A=M-1
M=!M

// push argument 0
@ARG
D=M
@0
A=D+A
D=M
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

// push argument 1
@ARG
D=M
@1
A=D+A
D=M
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

// return
@LCL
D=M
@5
A=D-A
D=M
@R13
M=D
@SP
A=M-1
D=M
@ARG
A=M
M=D
D=A+1
@SP
M=D
@LCL
AM=M-1
D=M
@THAT
M=D
@LCL
AM=M-1
D=M
@THIS
M=D
@LCL
AM=M-1
D=M
@ARG
M=D
@LCL
A=M-1
D=M
@LCL
M=D
@R13
A=M
0;JMP

// load SimpleFunction.vm,

// output-file SimpleFunction.out,

// compare-to SimpleFunction.cmp,

// output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1

// RAM[3]%D1.6.1 RAM[4]%D1.6.1 RAM[310]%D1.6.1;

// set sp 317,

// set local 317,

// set argument 310,

// set this 3000,

// set that 4000,

// set argument[0] 1234,

// set argument[1] 37,

// set argument[2] 9,

// set argument[3] 305,

// set argument[4] 300,

// set argument[5] 3010,

// set argument[6] 4010,

// repeat 10 {

// vmstep;

// }

// output;
