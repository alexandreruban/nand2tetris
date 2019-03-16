// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed.
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

// Put your code here.

// next_address_to_clear contains the value of the next address to clear
// it starts with @SCREEN

(CHOSE)
@8192
D=A
@screen_registers // There are 8192 screen registers
M=D

@SCREEN
D=A
@next_address_to_clear
M=D

@counter // Count the addresses that have been cleared
M=0

@KBD
D=M

@CLEAR // Clear if keyboard is not pressed
D;JEQ
@FILL  // Fill if keyboard is pressed
D;JNE

(CLEAR)
  (WHITE)
  @next_address_to_clear
  D=M
  A=D
  M=0
  @next_address_to_clear
  M=M+1
  @counter
  M=M+1
  D=M
  @screen_registers
  D=M-D
  @WHITE
  D;JNE
  @CHOSE
  D;JEQ

(FILL)
  (BLACK)
  @next_address_to_clear
  D=M
  A=D
  M=-1
  @next_address_to_clear
  M=M+1
  @counter
  M=M+1
  D=M
  @screen_registers
  D=M-D
  @BLACK
  D;JNE
  @CHOSE
  D;JEQ
