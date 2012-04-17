# Marcus M. Darden -- 2012-02-03
# readstr.asm: A simple reading of a user input string
# Registers used:
#	a0	- syscall argument for target read address
#	a1	- syscall argument for read length
#	t0	- used to hold length of user string
#	t1	- pointer to user string
#	t2	- current character
#	v0	- syscall parameter

	.text
main:					# Execution starts at main
	## Read a string from the user
	la	$a0, usrstr		# Load the destination address into a0
	li	$a1, 0x40		# Load the 64-byte limit into a1
	li	$v0, 8			# read_string syscall
	syscall				# execute syscall

	## Store the length of user string
	li	$t0, 0			# t0 = 0
	la	$t1, usrstr		# Get a pointer to user string
strlen_loop:
	## Look at each character if 10, end loop, else t0++
	lb	$t2, 0($t1)		# Read what string pointer sees t2 = &t1
	beq	$t2, 10, pool_nelrts	# if t2 == 10 exit loop
	addi	$t0, 1			# Increment length
	addi	$t1, 1			# Increment the string pointer
	b	strlen_loop		# Loop back to beginning
pool_nelrts:				# branch to here to exit loop	

	## Echo the user string with a label from below
	la	$a0, reslbl		# Get the response message address
	li	$v0, 4			# print_string syscall
	syscall				# execute syscall
	la	$a0, usrstr		# Get the user's entered value
	li	$v0, 4			# print_string syscall
	syscall				# execute syscall

	## Echo the string length with a label from below
	move	$a0, $t0		# Move string length to syscall arg
	li	$v0, 1			# print_int syscall
	syscall				# execute syscall
	la	$a0, lenlbl		# Get the address of length label
	li	$v0, 4			# print_string syscall
	syscall				# execute syscall

	## Exit the program
	li	$v0, 10			# syscall code 10 is exit
	syscall				# Look in $v0 and execute the syscall

	.data
usrstr:	.space	0x40			# Reserved 64 bytes of memory
lenlbl: .asciiz	" characters long.\n"
reslbl: .asciiz "You entered: "

# end of testing12.asm
