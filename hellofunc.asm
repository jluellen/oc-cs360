# Marcus M. Darden -- 2012-02-03
# helloworld.asm: Print the classic programmer greeting
# Registers used:
#	$v0	- syscall parameter
#	$a0	- argument -- the string we're printing

	.text
main:				# Execution starts at main
	la	$a0, hello	# Load the address of hello string to $a0
	li	$v0, 4		# syscall print_string
	syscall 		# print the string

	la	$a0, world	# Load the address of hello string to $a0
	li	$v0, 4		# syscall print_string
	syscall 		# print the string

	la	$a0, gbye	# Load the address of hello string to $a0
	li	$v0, 4		# syscall print_string
	syscall 		# print the string

	# Let's print some of our data segment as integers
	la	$t0, hello	# Load the address of the beginning of data seg
	lb	$a0, 1($t0)	# Load the value 1 after the beginning of data
	li	$v0, 1		# The print_int syscall
	syscall			# execution begins...

	lw	$a0, hello	# Load the address of beginning of data
	li	$v0, 1		# syscall print_int
	syscall 		# print the word
	la	$a0, nline	# address of new line
	li	$v0, 4		# syscall print_string
	syscall

	li	$v0, 10		# syscall exit
	syscall			# Be out!!


# Data for the program
	.data
hello:		.byte	72, 0x65, 0x6c
		.ascii	"lo,"
		.byte	0x20
world:		.ascii	"World!"
nline:		.ascii	"\n"
		.byte	0
gbye:		.asciiz	"Goodbye!\n"

# end helloworld.asm
