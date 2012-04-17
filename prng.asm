# Marcus M. Darden -- 2012-02-20
# prng.asm: A pseudorandom number generator with a function call
# Registers:

	.text
					# Execution begins here
	move	$s0, $zero		# Our loop variable is s0
loop:
	bgt	$s0, 50, done		# loop while s0 < 10
	jal	get_random		# call get_random()
	move	$a0, $v0		# Copied returned rand to syscall arg
	li	$v0, 1			# print_int syscall parameter
	syscall				# execute syscall
	la	$a0, newline		# \n character
	li	$v0, 4			# print_string syscall parameter
	syscall				# execute syscall
	addi	$s0, $s0, 1		# increment loop variable
	j	loop			# loop

done:
	li	$v0, 10
	syscall



get_random:				# Function entry for get_random()
	subu	$sp, $sp, 32		# 32-byte stack frame
	sw	$ra, 20($sp)		# save the return address (unnecessary)
	sw	$fp, 16($sp)		# save the frame pointer
	addu	$fp, $sp, 32		# set up a new frame pointer

	lw	$t1, m_w		# load m_w seed
	lw	$t2, m_z		# load m_z seed

	## m_z = 36969 * (m_z & 65535) + (m_z >> 16)
	srl	$t3, $t2, 0x10		# t3 = m_z >> 16
	and	$t4, $t2, 0xFFFF	# t4 = m_z & 1111 1111
	li	$t0, 36969		# t0 = 36969
	multu	$t4, $t0		# t4 * t0
	mflo	$t0			# t0 = low half
	addu	$t2, $t0, $t3		# m_z = ...
	sw	$t2, m_z

	## m_w = 18000 * (m_w & 65535) + (m_w >> 16)
	srl	$t3, $t1, 0x10		# t3 = m_w >> 16
	and	$t4, $t1, 0xFFFF	# t4 = m_w & 1111 1111
	li	$t0, 18000		# t0 = 18000
	multu	$t4, $t0		# t4 * t0
	mflo	$t0			# t0 = low half
	addu	$t1, $t0, $t3		# m_w = ...
	sw	$t1, m_w

	## (m_z << 16) + m_w
	sll	$v0, $t2, 0x10		# v0 = m_z << 16
	addu	$v0, $v0, $t1		# v0 = v0 + m_w	

	## Restore the stack
	lw	$ra, 20($sp)		# Restore the return address from stack
	lw	$fp, 16($sp)		# Restore the frame pointer from stack
	addu	$sp, $sp, 32		# Release the stack frame
	jr	$ra			# Return from the function


	.data
m_w:		.word 45532
m_z:		.word 1668
newline:	.asciiz "\n"
