// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.

// @base = the number to multiply
// @num  = the number of times base should be added to 0 to obtain the result
// @i    = the counter
// @sum  = the sum of the number added i times

// Pseudo code
// @base = R0
// @i    = R1
// @sum  = 0

// LOOP :
//   sum += base
//   i += 1
//   break if i = num

// Initializing variables
@R0
D=M
@base
M=D

@R1
D=M
@num
M=D

@i
M=0

@sum
M=0

// Starting the loop
(LOOP)

@base
D=M
@sum
M=D+M

@i
M=M+1
D=M
@num
D=D-M
@LOOP
D;JNE

// Store the result
@sum
D=M
@R2
M=D

(END)
@END
0;JMP
