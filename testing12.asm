# Marcus M. Darden -- 2012-02-03
# testing12.asm: A program that will add 1 and 2 and
#                leave the result in $t0
# Registers used:
#	t0	- used to hold the result
#	t1	- used to hold 1
#	v0	- syscall parameter

main:				# Execution starts at main
	li	$t1, 1		# load 1 into $t1
	addi	$t0, $t1, 2	# $t0 = $t1 + 2

	li	$v0, 10		# syscall code 10 is exit
	syscall			# Look in $v0 and execute the syscall

# end of testing12.asm
