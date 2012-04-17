# Marcus M. Darden -- 2012-02-10
# loopy.asm: Ask the user for a number and print 'Loop', that many times
#
# Registers used:
#	$a0	- syscall argument
#	$v0	- syscall paramter
#	$t0	- user entered number of loops
#	$t1	- loop variable

	.text
main:					# Execution starts here
	li	$v0, 5			# read_int syscall
	syscall				# execute syscall
	move	$t0, $v0		# t0 = v0
	move	$t1, $zero		# t1 = 0

loop:
	## Print 'Loop'
	la	$a0, loopy		# Get address of string to print
	li	$v0, 4			# print_string syscall
	syscall				# execute syscall

	## increment loop variable
	addi	$t1, 1			# increment the loop variable by 1
	beq	$t1, $t0, endloop	# if done, exit loop
	b	loop			# else, loop again

endloop:
	li	$v0, 10
	syscall				# Let's be out!!

	.data
loopy:	.asciiz	"Loop\n"
