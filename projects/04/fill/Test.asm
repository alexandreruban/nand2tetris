@8192
D=A
@length // The number of registers of the screen memory map is 8192
M=D

@KBD    // Set the keyboard input in the D register
D=M

@CLEAR  // Clear the screen is no key is pressed
D;JEQ

@FILL   // Fill the screen if a key is pressed
D;JNE

@next = @SCREEN
