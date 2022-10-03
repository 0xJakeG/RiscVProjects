.globl main
.data # Tell the assembler we are defining data not code


.text
main:
	# Tests simple looping behaviour
	li t0, 0
	li t1, 0
	li t2, 100
 
loop:
	addi t0, t0, 1
	add t1, t1, t0
	bne t0, t2, loop

	beq t1, t2 , success

	
success:
	mv a0, t1
	li a7, 1
	ecall
	
	mv a0, t1
	li a7, 93
	ecall 
