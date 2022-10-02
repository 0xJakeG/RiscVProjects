#============================================================================================================================

	# Create a RISC program MUST follow these steps: 
	# 1) declare an array of 100 elements, and use a loop to generate 100 integers and store them in the array; 
	# 2) use another loop to accumulate those numbers by reading them from the array and adding up to a variable; 
	# 3) calculate the average by dividing the accumulated sum with 100, and 3) print the average and return the average. 

#=============================================================================================================================

.globl main
.data # Tell the assembler we are defining data not code
buffer: .space 400
.text
main:
	la t0, buffer          # t0 = reserve memory for an array
	li t1, 99 	       # Size of the Array - 1
	li t2, 0               # index
	li t3, 0               # The value of the acumulator
	li t4, 0               # The value of the average
	li t5, 0               # randomNumber
	li t6, 4	       # Set to decrement Array

fillArray:
	li a0, 0 	       # Get a random number
	li a1 1000	       # Set bound for random number
	li a7, 42	       # Enviroment call number for RandIntRange
	ecall 		       # Syscall
	
	mv t5, a0	       # Move the value in a0 into t5(random num)
	sw t5, 0(t0)	       # Store the contents of t5 into memory word address
	addi t0, t0, 4	       # shift array index by 1
	addi t2,t2, 1 	       # Increment Index by 1 
	blt t2, t1, fillArray  # If t2(index) is less than t1(size of the array) fillArray
	li t2,0		       # Set the t2(Index) back to 0	

getAcum:
	lw t5, (t0)	       # Load index i
	add t3,t5, t3 	       # Add t5(randInt from array) to acumlator
	addi t2,t2, 1	       # Increase the index by 1
	sub t0, t0, t6	       # Decrement position in the array by one
	blt t2, t1,getAcum     # If t2(Index) is less than t1(size of the array-1) loop
	beq t2, t1, getAverage # If t2(Index) is equal to t1(size of the array-1) getAverage
	
getAverage:
	addi t1, t1, 1	       # Up the size of the array var for division
	div t4, t3, t1         # Divide t3(The acumulator) by t1(The size of the Array)

success:
	mv a0, t4 	       # move value of acumulator to a0
	li a7, 93 	       # Evntiroment call number for Exiting program with a code
	ecall		       #syscall

