#============================================================================================================================

	# Create a RISC program MUST follow these steps: 
	# Implement a program to do the simple 1-D stencil of 100 integers that are randomly generated, using RISC-V assembly
	# convert the 1-D stencil program from lab_03 to use array reference (B[i]) to access array element instead of using pointers. 
	# 1) declare two arrays, each has 100 elements
	# 2) use a for loop to randomly generate 100 integers and store them in one array
	# 3) use another for loop to do the 1-D stencil and store the result in the other array;

#=============================================================================================================================


.globl main
.data # Tell the assembler we are defining data not code
buffA: .space 400
buffB: .space 400
spacer:  # Label this position in memory so it can be referred to in our code 
  .string "   " # Copy the string "Hello World!\n" into memory
newLine: 
  .string "\n" 
.text
main:
	la t0, buffA             # t0 = reserve memory for an array
	la t1, buffB	         # Size of the Array - 1
	li t2, 0                 # index
	li t3, 100	         # Size of the Array 
	li t5, 0                 # loadNum
	li t6, 4	         # Set to decrement Array

fillArrayA:
	li a0, 0 	         # Get a random number
	li a1 9	                 # Set bound for random number
	li a7, 42	         # Enviroment call number for RandIntRange
	ecall 		         # Syscall
	
	mv t5, a0	         # Move the value in a0 into t5(random num)
	sw t5, 0(t0)	         # Store the contents of t5 into memory word address
	addi t0, t0, 4	         # shift array index by 1
	addi t2,t2, 1 	         # Increment Index by 1 

	blt t2, t3, fillArrayA   # If t2(index) is less than t1(size of the array) fillArray
	li t2,0		         # Set the t2(Index) back to 0
	

resetIndexA:
	lw t5, (t0)	         # Load index i
	sub t0, t0, t6	         # Decrement position in the array by one
	addi t2,t2, 1 	         # Increment Index by 1
	blt t2, t3, resetIndexA  # If t2(index) is less than t1(size of the array) fillArray
	li t2,0		         # Set the t2(Index) back to 0

oneDStencilB:
	lw t5, 0(t0)		 # Load index i
	sw t5, 0(t1)	         # Store the contents of t5 into memory word address of 0(t1) aka buffer Array B
	addi t0, t0, 4	         # shift array index by 1 

        mv a0, t5		 # Moves the value of t5(Index value) into a0
	li a7, 1		 # Set a7 to determine the printInt system call
	ecall			 # Issue the call
	
	addi t6, t2, 1		 # Calculate I + 1
	li t5, 10		 # Set t5 to the amount of values we want in each row
	rem t6, t6, t5		 # set t6 to the remainder of (i+1) / value of amount of items in each row
	
	addi t2,t2, 1		 # Increment Index by 1 
	beq t6, zero, newL 	 # See if the remainder is equal to zero if so make a new Line 
	blt t2,t3, space	 # If I is less than size of the array then run space
	
space:
	la a0, spacer            # load spacer string into a0
        li a7, 4                 # set a7 to 4 to print string
        ecall                    # actually issue the call
        blt t2,t3 oneDStencilB   # If I is less than size of the array then run space

newL:
	la a0, newLine           # load newLine string into a0
        li a7, 4                 # set a7 to 4 to print string
        ecall                    # actually issue the call
        blt t2,t3 oneDStencilB	 # If I is less than size of the array then run space


success:
	li a0, 0 	         # Set a0 to 0 to show success with no errors 
	li a7, 93 	         # Evntiroment call number for Exiting program with a code
	ecall		         #syscall
