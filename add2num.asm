# Marcus M. Darden -- 2012-02-03
# add2num.asm: Get 2 numbers from the user and print
#              the sum on the screen
# Registers used:
#	$t0	- holds the sum of the two numbers
#	$t1	- hold the first number
#	$t2	- hold the second number
#	$v0	- syscall parameter

main:				# Execution starts at main
	## Get first number from user
	li	$v0, 5		# load syscall read_int into $v0
	syscall			# read the int!!!
	move	$t1, $v0

	## Get second number from user
	li	$v0, 5		# load syscall read_int into $v0
	syscall			# read the int!!!
	move	$t2, $v0

	add	$t0, $t1, $t2	# $t0 = $t1 + $t2

	## Print out $t0
	move	$a0, $t0	# move the number to print into $a0
	li	$v0, 1		# load syscall print_int into $v0
	syscall			# print the integer

	li	$v0, 10		# syscall exit
	syscall			# DO IT!

# end of add2num.asm

