@256
D=A
@SP
M=D

// call Sys.init 0
@SP
D=M
@R13
M=D
@ret.1
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@R13
D=M
@0
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.init
0;JMP
(ret.1)

0;JMP

// | RAM[0] | RAM[1] | RAM[2] | RAM[3] | RAM[4] | RAM[5] | RAM[6] |

// |    261 |    261 |    256 |   4000 |   5000 |    135 |    246 |

// <!DOCTYPE html>

// <html>

// <head>

// <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

// <title>NestedCall.tst &mdash; Nand2Tetris Calling Convention Test</title>

// <style type="text/css">

// .code {font-family:"Courier New", Courier, monospace; font-size:90%;}

// pre {margin-left:2em;}

// </style>

// </head>

// <body>

// <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

// <h3>Synopsis</h3>

// <b>NestedCall.tst</b> is an intermediate test (in terms of complexity) intended to be used between the SimpleFunction and

// FibonacciElement tests. It may be useful when SimpleFunction passes but FibonacciElement fails or crashes. NestedCall also

// tests several requirements of the Function Calling Protocol that are not verified by the other

// supplied tests. NestedCall can be used with or without the VM bootstrap code.

// <p>

// <b>NestedCallVME.tst</b> runs the same test on the VM Emulator.

// <p>

// <b>The NestedCall</b> tests and supporting documentation were written by Mark Armbrust.

// <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

// <h3>Test Structure</h3>

// <h4>Startup</h4>

// NestedCall is implemented entirely within the Sys.vm file.  The first function in Sys.vm is

// Sys.init().  This allows it to be used before the bootstrap code has been added to the VM Translator

// since there will be no file processing order issues.

// <p>

// NestedCall loads Sys.asm, sets up the stack to simulate the bootstrap's call to Sys.init(), then

// begins execution at the beginning of Sys.asm.  If the bootstrap is not present, the program begins

// running with Sys.init() since it is the first function in Sys.vm.

// <p>

// If Sys.asm includes the bootstrap, the bootstrap will (re)initialize the stack and call Sys.init(),

// so the test should see the same environment either way it gets to Sys.init().

// <p>

// The test setup also initializes the

// <h4>Sys.init()</h4>

// <span class="code">THIS</span> and <span class="code">THAT</span> are set to known values so that context save and restore can be tested.

// <p>

// Sys.init() calls Sys.main() and stores the return value in <span class="code">temp 1</span>.  This tests call to and

// return from a function with no arguments.
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

// <h4>Sys.main()</h4>

// Sys.init() allocates 5 local variables.  It sets <span class="code">local 1</span>, <span class="code">local 2</span> and

// <span class="code">local 3</span>.  <span class="code">local 0</span> and <span class="code">local 4</span> are intentionally not set.

// <p>

// <span class="code">THIS</span> and <span class="code">THAT</span> are changed so that context save and restore can be tested.

// <p>

// Sys.main() calls Sys.add12(123) and stores the return value in <span class="code">temp 0</span>.  This tests call to and

// return from a function with arguments.
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

// <p>

// After Sys.add12() returns, Sys.main() sums <span class="code">local 0</span> through <span class="code">local 4</span> and returns the

// result.  This tests that the local segment was properly allocated on the stack and that the local

// variables were not overwritten by the call to Sys.main().  It also tests that <span class="code">local 0</span> and

// <span class="code">local 4</span> were properly initialized to 0.

// <h4>Sys.add12()</h4>

// <span class="code">THIS</span> and <span class="code">THAT</span> are set to known values so that context save and restore can be tested.

// <p>

// Returns <span class="code">argument 0</span> plus 12.

// <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

// <h3>Test Coverage</h3>

// <p style="margin-left:1em; text-indent:-1em;">

// Functions with no arguments return to correct RIP (Return Instruction Point) with correct return value on stack.<br>

// This can fail if the RIP is not correctly pushed on the stack by the calling code, or if the returning

// code does not store the RIP in a temporary register before overwriting it with the return value.

// <p style="margin-left:1em; text-indent:-1em;">

// Functions with arguments return to correct RIP with correct return value on stack.<br>

// This can fail if it is assumed that <span class="code">ARG</span> points to the RIP.

// <p style="margin-left:1em; text-indent:-1em;">

// Functions with local variables allocate space on the stack for the local variables.<br>

// This can fail if the function prologue is not written or if the SP is not updated after zeroing

// the local variables.

// <p style="margin-left:1em; text-indent:-1em;">

// All local variables are initialized to 0.<br>

// Common errors are to forget this completely, or for the zeroing loop to be off by one.

// <p style="margin-left:1em; text-indent:-1em;">

// <span class="code">THIS</span> and <span class="code">THAT</span> are correctly retained across function calls. Looking ahead, in Project 9 you will be asked to write a simple computer game in the high-level Jack language. You can run your game (following compilation) on the supplied VM Emulator. But, if you choose to translate the VM code that the compiler generates using <em>your</em> VM Translator, then code like

// "<span class="code">push THIS</span>, <span class="code">push THAT</span> ... <span class="code">pop THIS</span>, <span class="code">pop THAT</span>" can cause some interesting failures!

// <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

// <h3>Debugging</h3>

// These comments assume that your VM translator has passed the SimpleFunction test.

// <p>

// If <span class="code">RAM[0]</span> is incorrect, you have a stack skew.  More data was pushed onto the stack by

// <span class="code">call</span> than was popped by <span class="code">return</span>, or vice versa.  See <i>debugging with

// breakpoints</i> later in this section.

// <p>

// If one or more of <span class="code">RAM[1]</span> through <span class="code">RAM[4]</span> is incorrect, the <span class="code">LCL</span>,

// <span class="code">ARG</span>, <span class="code">THIS</span> and <span class="code">THAT</span> pointers are not being correctly saved or restored.

// Most likely problem is when they are being saved; the SimpleFunction test verified that

// <span class="code">return</span> restored them correctly.

// <p>

// If <span class="code">RAM[5]</span> is incorrect there may be a problem with setting up the <span class="code">ARG</span> pointer.

// <p>

// If <span class="code">RAM[4]</span> is incorrect and <span class="code">RAM[5]</span> is correct, there may be a problem with

// allocation or initialization of local variables.

// <h4>Debugging with breakpoints</h4>

// To find tough bugs you can use the "breakpoint" facility in the CPU Emulator (red flag button).

// You can use breakpoints to have you program stop when it gets to a particular RAM address.  For

// example:<br>

// &emsp;&bull;&ensp;load the NestedCall.tst file,<br>

// &emsp;&bull;&ensp;set a PC breakpoint at the ROM address for <span class="code">(Sys.main)</span>,<br>

// &emsp;&bull;&ensp;hit the run button.<br>

// When the CPU Emulator stops at the breakpoint you can inspect the RAM to check the stack and pointers values.

// (If the breakpoint isn't hit, you will need to to single-step debug through

// your calling code to see why it didn't get there.)

// <p>

// Other useful places to set breakpoints are the entry points to the other functions and at the

// first and final instructions generated for <span class="code">return</span> commands.

// <p>

// <a href="NestedCallStack.html">NestedCallStack.html</a> shows the expected stack values at various points

// during the test.

// <h4>Finding ROM address in your ASM code</h4>

// It is not easy to find the ROM locations where you want to set breakpoints, because there is no

// one-to-one correspondence between the ASM file line numbers and the ROM addresses. This is made even more

// difficult because the supplied CPU Emulator does not display the (LABELS) in its ROM panel.

// <p>

// There are two things that you can do to make this easier.

// <p>

// <h5>Modify your assembler to generate a listing file.</h5>

// A listing file shows all the ASM source lines, including comments, as well as the ROM addresses and

// the values of the labels and the instructions. For example, here is a snippet of a listing file generated by an assembler written by Mark Armbrust:

// <pre>

// 20    16      @i

// 21  FC88      M=M-1

// 22  FC10      D=M

// 23     6      @LOOP

// 24  E301      D;JGT

// 25        (STOP)

// 25    25      @STOP

// 26  EA87      0;JMP

// Data Symbols

// 16 D  i

// Code Symbols

// 6 C  LOOP

// 17 C  SKIP

// 25 C  STOP

// </pre>

// For the Nand2Tetris environment, it is most useful to list the ROM addresses and A-instruction

// values in decimal.  In the above snippet, the C-instruction values are

// listed in hexadecimal.

// <p>

// The list file is generated during pass 2 of the Assembler, parallel to generating the .hack file.  To

// make it easier to handle blank and comment only lines, Mark has Parser.commandType() return

// NO_COMMAND for source lines with no command. Mark also added Parser.sourceLine() that returns the

// unmodified source line.

// <p>

// <h5>Have your VM Translator write the VM source lines as comments in the ASM output.</h5>

// For example:

// <pre>

// (Sys.init$LOOP)

// @Sys.init$LOOP

// 0;JMP

// (Sys.main)

// @5

// D=-A

// ($3)

// @SP

// </pre>

// Note that comments in the VM source become double comments. Looking ahead, in Project 11 you will be asked to write a compiler for the Jack language. If your compiler will write the Jack source lines as comments in the

// generated VM files, this convention will be quite useful.

// </body>

// </html>

// load NestedCall.asm,

// output-file NestedCall.out,

// compare-to NestedCall.cmp,

// output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1 RAM[3]%D1.6.1 RAM[4]%D1.6.1 RAM[5]%D1.6.1 RAM[6]%D1.6.1;

// set RAM[0] 261,

// set RAM[1] 261,

// set RAM[2] 256,

// set RAM[3] -3,

// set RAM[4] -4,

// set RAM[5] -1,

// set RAM[6] -1,

// set RAM[256] 1234,

// set RAM[257] -1,

// set RAM[258] -2,

// set RAM[259] -3,

// set RAM[260] -4,

// set RAM[261] -1,

// set RAM[262] -1,

// set RAM[263] -1,

// set RAM[264] -1,

// set RAM[265] -1,

// set RAM[266] -1,

// set RAM[267] -1,

// set RAM[268] -1,

// set RAM[269] -1,

// set RAM[270] -1,

// set RAM[271] -1,

// set RAM[272] -1,

// set RAM[273] -1,

// set RAM[274] -1,

// set RAM[275] -1,

// set RAM[276] -1,

// set RAM[277] -1,

// set RAM[278] -1,

// set RAM[279] -1,

// set RAM[280] -1,

// set RAM[281] -1,

// set RAM[282] -1,

// set RAM[283] -1,

// set RAM[284] -1,

// set RAM[285] -1,

// set RAM[286] -1,

// set RAM[287] -1,

// set RAM[288] -1,

// set RAM[289] -1,

// set RAM[290] -1,

// set RAM[291] -1,

// set RAM[292] -1,

// set RAM[293] -1,

// set RAM[294] -1,

// set RAM[295] -1,

// set RAM[296] -1,

// set RAM[297] -1,

// set RAM[298] -1,

// set RAM[299] -1,

// repeat 4000 {

// ticktock;

// }

// output;

// <!DOCTYPE html>

// <html>

// <head>

// <meta http-equiv="Content-Type" content="text/html; charset=utf-8">

// <title>NestedCall.tst &mdash; Stack Frames</title>

// <style type="text/css">

// .stack {border-collapse:collapse; font-size:80%;}

// .stack td {padding-left:.25em;padding-right:.25em;white-space:nowrap;}

// .stack td:first-child {text-align:right;}

// .stack td:first-child + td {text-align:right;}

// .stack td:first-child + td + td {text-align:left;}

// .stack td:first-child + td + td + td {text-align:left;}

// .stack .reg {border-left:1px solid; border-right:1px solid;}

// .stack .reg th {border:1px solid;}

// .stack .stack {border-left:1px solid; border-right:1px solid;}

// .stack .stack th {border:1px solid;}

// .stack .tos {border-left:1px solid; border-right:1px solid;border-bottom:1px solid;}

// .stack .frame {border-left:1px solid; border-right:1px solid;}

// .stack .frame td:first-child + td {border-left:1px solid;}

// .stack .frame td:first-child + td + td {border-right:1px solid;}

// .stack .framet {border-left:1px solid; border-right:1px solid;}

// .stack .framet td:first-child + td {border-left:1px solid;border-top:1px solid;}

// .stack .framet td:first-child + td + td {border-right:1px solid;border-top:1px solid;}

// .stack .bframe {border-left:1px solid; border-right:1px solid;}

// .stack .bframe td:first-child + td {border-left:2px solid;}

// .stack .bframe td:first-child + td + td {border-right:2px solid;}

// .stack .bframet {border-left:1px solid; border-right:1px solid;}

// .stack .bframet td:first-child + td {border-left:2px solid;border-top:2px solid;}

// .stack .bframet td:first-child + td + td {border-right:2px solid;border-top:2px solid;}

// .stack .bframeb {border-left:1px solid; border-right:1px solid;}

// .stack .bframeb td:first-child + td {border-left:2px solid;border-bottom:2px solid;}

// .stack .bframeb td:first-child + td + td {border-right:2px solid;border-bottom:2px solid;}

// .stack .note td {padding-left:.5em;padding-right:.5em;white-space:normal;text-align:justify;}

// .stack .fid {font-style:italic}

// .master {width: 10%;}

// .master td {vertical-align:top;padding-right:.5em; }

// </style>

// </head>

// <body>

// <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->

// <table class="master">

// <tr>

// <td>

// <table class="stack">

// <tr><th colspan="4">Bootstrap init</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>256</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>-1</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>-2</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>-3</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>-4</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="tos"><td>256</td><td>???</td><td></td><td>&larr;SP</td></tr>

// <tr class="note"><td colspan="4"><br>

// This is how my boot&shy;strap code initial&shy;izes the pointers before calling Sys.init().

// <p>

// Setting the LCL, ARG, THIS and THAT point&shy;ers to known illegal values helps identify

// when a pointer is used before it is initial&shy;ized.

// <p>

// (If you are running the NestedCall test with&shy;out boot&shy;strap code, you will not see this state.)</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">Entry to Sys.init()</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>261</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>-3</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>-4</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframeb"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="tos"><td>261</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>

// <tr class="note"><td colspan="4"><br>

// This is how NestedCall.tst initial&shy;izes the pointers and stack.  This is what RAM looks

// like after my boot&shy;strap calls Sys.init().

// <p>

// (If your VM trans&shy;lation includes the boot&shy;strap, the -1 through -4 values may be

// different if your boot&shy;strap initial&shy;izes them.)</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">Entry to Sys.main()</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>266</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframeb"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="tos"><td>266</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">After Sys.main() prologue</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>271</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>

// <tr class="bframe"><td>267</td><td>0</td><td>local 1</td><td></td></tr>

// <tr class="bframe"><td>268</td><td>0</td><td>local 2</td><td></td></tr>

// <tr class="bframe"><td>269</td><td>0</td><td>local 3</td><td></td></tr>

// <tr class="bframeb"><td>270</td><td>0</td><td>local 4</td><td></td></tr>

// <tr class="tos"><td>271</td><td>???</td><td></td><td>&larr;SP</td></tr>

// <tr class="note"><td colspan="4"><br>

// The <i>function prologue</i> is the assembly language code generated for the

// "function" VM command.

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">Entry to Sys.add12(123)</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>277</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>277</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>271</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="framet"><td>261</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="frame"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="frame"><td>266</td><td>0</td><td>local 0</td><td></td></tr>

// <tr class="frame"><td>267</td><td>200</td><td>local 1</td><td></td></tr>

// <tr class="frame"><td>268</td><td>40</td><td>local 2</td><td></td></tr>

// <tr class="frame"><td>269</td><td>6</td><td>local 3</td><td></td></tr>

// <tr class="frame"><td>270</td><td>0</td><td>local 4</td><td></td></tr>

// <tr class="bframet"><td>271</td><td>123</td><td>argument 0</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>272</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="bframe"><td>273</td><td>266</td><td>Saved LCL</td><td class="fid">Sys.add12</td></tr>

// <tr class="bframe"><td>274</td><td>261</td><td>Saved ARG</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>275</td><td>4001</td><td>Saved THIS</td><td></td></tr>

// <tr class="bframeb"><td>276</td><td>5001</td><td>Saved THAT</td><td></td></tr>

// <tr class="tos"><td>277</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>

// </table>

// </td>

// </tr></table>

// <p>

// <table class="master">

// <tr>

// <td>

// <table class="stack">

// <tr><th colspan="4">Before Sys.add12() return</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>278</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>277</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>271</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4002</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5002</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="framet"><td>261</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="frame"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="frame"><td>266</td><td>0</td><td>local 0</td><td></td></tr>

// <tr class="frame"><td>267</td><td>200</td><td>local 1</td><td></td></tr>

// <tr class="frame"><td>268</td><td>40</td><td>local 2</td><td></td></tr>

// <tr class="frame"><td>269</td><td>6</td><td>local 3</td><td></td></tr>

// <tr class="frame"><td>270</td><td>0</td><td>local 4</td><td></td></tr>

// <tr class="bframet"><td>271</td><td>123</td><td>argument 0</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>272</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="bframe"><td>273</td><td>266</td><td>Saved LCL</td><td class="fid">Sys.add12</td></tr>

// <tr class="bframe"><td>274</td><td>261</td><td>Saved ARG</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>275</td><td>4001</td><td>Saved THIS</td><td></td></tr>

// <tr class="bframe"><td>276</td><td>5001</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframeb"><td>277</td><td>135</td><td>Return value</td><td>&larr;LCL</td></tr>

// <tr class="tos"><td>278</td><td>???</td><td></td><td>&larr;SP</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">After Sys.add12() return</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>272</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>

// <tr class="bframe"><td>267</td><td>200</td><td>local 1</td><td></td></tr>

// <tr class="bframe"><td>268</td><td>40</td><td>local 2</td><td></td></tr>

// <tr class="bframe"><td>269</td><td>6</td><td>local 3</td><td></td></tr>

// <tr class="bframe"><td>270</td><td>0</td><td>local 4</td><td></td></tr>

// <tr class="bframeb"><td>271</td><td>135</td><td>Return value</td><td></td></tr>

// <tr class="tos"><td>272</td><td>???</td><td></td><td>&larr;SP</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">Before Sys.main() return</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>272</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>266</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>261</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4001</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5001</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="framet"><td>256</td><td>*</td><td>Return IP</td><td></td></tr>

// <tr class="frame"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="frame"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="frame"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="frame"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframet"><td>261</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>262</td><td>261</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>263</td><td>256</td><td>Saved ARG</td><td class="fid">Sys.main</td></tr>

// <tr class="bframe"><td>264</td><td>4000</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>265</td><td>5000</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframe"><td>266</td><td>0</td><td>local 0</td><td>&larr;LCL</td></tr>

// <tr class="bframe"><td>267</td><td>200</td><td>local 1</td><td></td></tr>

// <tr class="bframe"><td>268</td><td>40</td><td>local 2</td><td></td></tr>

// <tr class="bframe"><td>269</td><td>6</td><td>local 3</td><td></td></tr>

// <tr class="bframe"><td>270</td><td>0</td><td>local 4</td><td></td></tr>

// <tr class="bframeb"><td>271</td><td>246</td><td>Return value</td><td></td></tr>

// <tr class="tos"><td>272</td><td>???</td><td></td><td>&larr;SP</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">After Sys.main() return</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>262</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframe"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="bframeb"><td>261</td><td>246</td><td>Return value</td><td>&larr;LCL</td></tr>

// <tr class="tos"><td>262</td><td>???</td><td></td><td>&larr;SP</td></tr>

// </table>

// </td><td>

// <table class="stack">

// <tr><th colspan="4">In Sys.init() halt loop</th></tr>

// <tr class="reg"><th colspan="4">Pointers</th></tr>

// <tr class="reg"><td>0</td><td>261</td><td>SP</td><td></td></tr>

// <tr class="reg"><td>1</td><td>261</td><td>LCL</td><td></td></tr>

// <tr class="reg"><td>2</td><td>256</td><td>ARG</td><td></td></tr>

// <tr class="reg"><td>3</td><td>4000</td><td>THIS</td><td></td></tr>

// <tr class="reg"><td>4</td><td>5000</td><td>THAT</td><td></td></tr>

// <tr class="stack"><th colspan="4">Stack</th></tr>

// <tr class="bframet"><td>256</td><td>*</td><td>Return IP</td><td>&larr;ARG</td></tr>

// <tr class="bframe"><td>257</td><td>-1</td><td>Saved LCL</td><td></td></tr>

// <tr class="bframe"><td>258</td><td>-2</td><td>Saved ARG</td><td class="fid">Sys.init</td></tr>

// <tr class="bframe"><td>259</td><td>-3</td><td>Saved THIS</td><td class="fid">&ensp;frame</td></tr>

// <tr class="bframeb"><td>260</td><td>-4</td><td>Saved THAT</td><td></td></tr>

// <tr class="tos"><td>261</td><td>???</td><td></td><td>&larr;LCL, SP</td></tr>

// </table>

// </td>

// </tr></table>

// </body>

// </html>

// load Sys.vm,

// output-file NestedCall.out,

// compare-to NestedCall.cmp,

// output-list RAM[0]%D1.6.1 RAM[1]%D1.6.1 RAM[2]%D1.6.1 RAM[3]%D1.6.1 RAM[4]%D1.6.1 RAM[5]%D1.6.1 RAM[6]%D1.6.1;

// set RAM[0] 261,

// set RAM[1] 261,

// set RAM[2] 256,

// set RAM[3] -3,

// set RAM[4] -4,

// set RAM[5] -1,

// set RAM[6] -1,

// set RAM[256] 1234,

// set RAM[257] -1,

// set RAM[258] -2,

// set RAM[259] -3,

// set RAM[260] -4,

// set RAM[261] -1,

// set RAM[262] -1,

// set RAM[263] -1,

// set RAM[264] -1,

// set RAM[265] -1,

// set RAM[266] -1,

// set RAM[267] -1,

// set RAM[268] -1,

// set RAM[269] -1,

// set RAM[270] -1,

// set RAM[271] -1,

// set RAM[272] -1,

// set RAM[273] -1,

// set RAM[274] -1,

// set RAM[275] -1,

// set RAM[276] -1,

// set RAM[277] -1,

// set RAM[278] -1,

// set RAM[279] -1,

// set RAM[280] -1,

// set RAM[281] -1,

// set RAM[282] -1,

// set RAM[283] -1,

// set RAM[284] -1,

// set RAM[285] -1,

// set RAM[286] -1,

// set RAM[287] -1,

// set RAM[288] -1,

// set RAM[289] -1,

// set RAM[290] -1,

// set RAM[291] -1,

// set RAM[292] -1,

// set RAM[293] -1,

// set RAM[294] -1,

// set RAM[295] -1,

// set RAM[296] -1,

// set RAM[297] -1,

// set RAM[298] -1,

// set RAM[299] -1,

// set sp 261,

// set local 261,

// set argument 256,

// set this 3000,

// set that 4000;

// repeat 50 {

// vmstep;

// }

// output;

// function Sys.init 0
(Sys.init)
@SP
A=M
D=A
@SP
M=D

// push constant 4000
@4000
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 0
@THIS
D=A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 5000
@5000
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 1
@THAT
D=A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// call Sys.main 0
@SP
D=M
@R13
M=D
@ret.2
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@R13
D=M
@0
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.main
0;JMP
(ret.2)

// pop temp 1
@R5
D=A
@1
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// label LOOP
(Sys.init$LOOP)

// goto LOOP
@Sys.init$LOOP
0;JMP

// function Sys.main 5
(Sys.main)
@SP
A=M
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
M=0
A=A+1
D=A
@SP
M=D

// push constant 4001
@4001
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 0
@THIS
D=A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 5001
@5001
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 1
@THAT
D=A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 200
@200
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop local 1
@LCL
D=M
@1
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 40
@40
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop local 2
@LCL
D=M
@2
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 6
@6
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop local 3
@LCL
D=M
@3
D=D+A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 123
@123
D=A
@SP
A=M
M=D
@SP
M=M+1

// call Sys.add12 1
@SP
D=M
@R13
M=D
@ret.3
D=A
@SP
A=M
M=D
@SP
M=M+1
@LCL
D=M
@SP
A=M
M=D
@SP
M=M+1
@ARG
D=M
@SP
A=M
M=D
@SP
M=M+1
@THIS
D=M
@SP
A=M
M=D
@SP
M=M+1
@THAT
D=M
@SP
A=M
M=D
@SP
M=M+1
@R13
D=M
@1
D=D-A
@ARG
M=D
@SP
D=M
@LCL
M=D
@Sys.add12
0;JMP
(ret.3)

// pop temp 0
@R5
D=A
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

// push local 2
@LCL
D=M
@2
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1

// push local 3
@LCL
D=M
@3
A=D+A
D=M
@SP
A=M
M=D
@SP
M=M+1

// push local 4
@LCL
D=M
@4
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

// add
@SP
AM=M-1
D=M
A=A-1
M=D+M

// add
@SP
AM=M-1
D=M
A=A-1
M=D+M

// add
@SP
AM=M-1
D=M
A=A-1
M=D+M

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

// function Sys.add12 0
(Sys.add12)
@SP
A=M
D=A
@SP
M=D

// push constant 4002
@4002
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 0
@THIS
D=A
@R13
M=D
@SP
AM=M-1
D=M
@R13
A=M
M=D

// push constant 5002
@5002
D=A
@SP
A=M
M=D
@SP
M=M+1

// pop pointer 1
@THAT
D=A
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

// push constant 12
@12
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
