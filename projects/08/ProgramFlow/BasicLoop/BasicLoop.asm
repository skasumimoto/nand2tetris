@256
D=A
@SP
M=D

// | RAM[0] |RAM[256]|

// |    257 |      6 |

// load BasicLoop.asm,

// output-file BasicLoop.out,

// compare-to BasicLoop.cmp,

// output-list RAM[0]%D1.6.1 RAM[256]%D1.6.1;

// set RAM[0] 256,

// set RAM[1] 300,

// set RAM[2] 400,

// set RAM[400] 3,

// repeat 600 {

// ticktock;

// }

// output;

// push constant 0
@0
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// label LOOP_START
($LOOP_START)

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

// add
@SP
AM=M-1
D=M
A=A-1
M=D+M

// pop local 0
@LCL
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

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

// push constant 1
@1
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

// pop argument 0
@ARG
D=M
@0
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

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

// if-goto LOOP_START
@SP
AM=M-1
D=M
@$LOOP_START
D;JNE

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

// load BasicLoop.vm,

// output-file BasicLoop.out,

// compare-to BasicLoop.cmp,

// output-list RAM[0]%D1.6.1 RAM[256]%D1.6.1;

// set sp 256,

// set local 300,

// set argument 400,

// set argument[0] 3,

// repeat 33 {

// vmstep;

// }

// output;
