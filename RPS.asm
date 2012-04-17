# Marcus M. Darden -- 2012-02-03
# add2num.asm: Get 2 numbers from the user and print
#              the sum on the screen
# Registers used:
#	$t0	- holds the sum of the two numbers
#	$t1	- hold the first number
#	$t2	- hold the second number
#	$v0	- syscall parameter


	.text
main:				# Execution starts at main
	## Get first number from user
	li	$v0, 5		# load syscall read_int into $v0
	syscall			# read the int!!!
	move	$t1, $v0	# move user input from v0 to t1
	addiu	$t1, 2		# add two to the user input
	
	## Get second number from user
	li	$v0, 5		# load syscall read_int into $v0
	syscall			# read the int!!!
	move	$t2, $v0	# move user input from v0 to t2
	addiu	$t2, 2		# add two to the user input

	
	beq	$t0, $t1, tie	# IF t0 = t1, goto tie




rock:
	





paper:







scissors:





tie:	
	la	$a0, tiep	# Load the address of beginning of data
	li	$v0, 4		# syscall print_str
	syscall 		# print the word
	b	endif



endif:
	li	$v0, 10			# syscall 10 is exit
	syscall				# make the syscall


# end of add2num.asm

	.data
tiep:	.asciiz	"Tie\n"

win:

loss:


