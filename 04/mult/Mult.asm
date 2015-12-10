// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

	@R1 //Load multiplier  into A
	D=M //Move multiplier into D
	@count //Allocate memory for counter
	M=D //Load multiplier into counter


	@R0 //Load multicand into A
	D=M //Move multicand into D
	@multicand //Allocate memory for multicand 
	M=D //Load multicand into multicand 

	@R2
	M=0 //Initialize product

(Loop)
	@count //Load counter into A
	D=M //Move counter into D

	@END
	D;JEQ //Tests if counter = 0

	@R2
	D=M //Save answer into D
	@multicand //Load what you are adding
	D=D+M //Increment

	@R2 //Store added value 
	M=D //Loads value into answer

	@count //Load counter
	D=M //Decrement counter
	D=D-1
	M=D //Move counter to D

	@Loop
	0;JMP //Loops to top of loop

(END)
	@END
	0;JMP