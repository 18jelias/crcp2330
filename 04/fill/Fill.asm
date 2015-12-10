// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input. 
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel. When no key is pressed, the
// program clears the screen, i.e. writes "white" in every pixel.

(Loop)
	//@8192
	//D=A
	//@pixelCount //Number of pixels on screen
	//M=D

	@nextPixel //Counts up
	M=0

	@KBD //Checks what keyboard input is 
	D=M

	@Clear //Jumps to clear if 0
	D;JEQ

	@Dark //Jumps to dark if not 0
	D;JNE

(Dark)
	@nextPixel
	D=M
	@KBD //Compares address of KBD to address of current counter
	D=A-D
	@Loop
	D;JEQ

	@nextPixel
	D=M
	@SCREEN
	A=A+D
	M=-1 //Fills dark 

	@nextPixel
	M=M+1
	D=M
	@SCREEN
	D=A+D

	@KBD //Compares address of KBD to address of current counter
	D=A-D
	@Dark
	D;JNE

	@Loop
	D;JEQ

(Clear)
	@nextPixel
	D=M
	@KBD //Compares address of KBD to address of current counter
	D=A-D
	@Loop  
	D;JEQ

	@nextPixel
	D=M
	@SCREEN
	A=A+D
	M=0 //Fills dark 

	@nextPixel
	M=M+1
	D=M
	@SCREEN
	D=A+D

	@KBD //Compares address of KBD to address of current counter
	D=A-D
	@Clear
	D;JNE

	@Loop
	D;JEQ