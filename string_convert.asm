# Jared R. Luellen 2012--2--10
# This ASM program takes a string and converts it into an int...
#
#	Registers Used:
		# $a0	-syscall argument 
		# $v0	-syscall
		# $t0


	.text
#Get string into "variable" from user


main:
	li	$t0, 8			#Get user input
	syscall
	move	$a0, $t0		#Move user input to a0


 
