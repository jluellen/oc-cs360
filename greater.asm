# Marcus M. Darden -- 2012-02-10
# greater.asm: Prints the larger of two numbers specified by the user
#
# Registers used:
#	$a0	- print argument
#	$v0	- syscall parameter
#	$t0	- User's first number
#	$t1	- User's second number
#	$t2	- Larger of two

	.text
main:			# Execution starts here
	## Get the first number
	li	$v0, 5			# read_int is syscall 5
	syscall				# make the syscall
	move	$t0, $v0		# move user input to "variable"

	## Get the second number
	li	$v0, 5			# read_int is syscall 5
	syscall				# make the syscall
	move	$t1, $v0		# move user input to "variable"

	## Determine the largest
	bgt	$t0, $t1, t0_bigger	# IF t0 > t1, goto t0_bigger
	move	$t2, $t1		# copy t1 into t2
	b	endif			# branch to endif
t0_bigger:
	move	$t2, $t0		# copy t0 into t2
endif:

	## Print it
	move	$a0, $t2		# Move the largest value into func arg
	li	$v0, 1			# print_int is syscall 1
	syscall				# make the syscall

	li	$v0, 10			# syscall 10 is exit
	syscall				# make the syscall






