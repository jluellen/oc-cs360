# Jared R. Luellen -- 2012-02-12
# user_input.asm: read user input and then display it on the scree



# Registers used:

#
#
#

	.text
main:					# Execution starts at main
	la	$a0, usrstr		# Load destination address into a0
	li	$a1, 0x40		# load the 64 byte limit into a1
	li	$v0, 8			# syscall param to read input
	syscall				# execute syscall

	li	$t0, $zer0		# t0=0
strlen_loop:	
	## Look at each charactor if 0, end loop, else $t0++
	lb	$t2, 0($t1)		# Read what string pointer sees t2 = &t1
	bnez	$t2, 0xA, pool_nelrts	# if t2 != 0 goto ....
	addi	$t0, 1
	addi	$t1, 1
	b	strlen_loop
pool_nelrts:

	## Echo the user string with a label from below	
	la	$a0, reslbl		# Get the responce message address
	li	$v0, 10			# syscall 10 is to exit
	syscall

	la	$a0, lenlbl		# Get the user's entered value
	li	$v0, 4			# Print_string syscall
	syscall

	## Exit PROGRAM
	li	$v0, 10
	syscall

	.data
usrstr: .space 0x40			# Reserved 64 bytes of memory
lenlbl:	.asciiz	" charectors long. \n"
reslbl: .asciiz "You Entered: " 
