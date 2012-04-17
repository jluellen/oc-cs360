# Jared R. Luellen -- 2012-0-16
# qbr.asm: A quarter back passer rating algorithm in assembly language
# Registers:
#	$s1 -	Attempts
#	$s2 -	Completions
#	$s3 -	Yards
#	$s4 -	Touchdowns
#	$s5 -	Interceptions
#	$t6 -	Load temp values
#	$a0 -	Function argument (string address for print_string)

	.text
main:						# Execution begins here
	
	## Get quaterback information
	## Get attemps
	la	$a0, ATT				# Get address of ATT message
	li	$v0, 4				# print_string syscall parameter
	syscall					# Execute syscall
	li	$v0, 6				# read_int syscall parameter
	syscall					# Execute syscall
	move	$s1, $v0			# Attemps = s1

	## Get completions
	la	$a0, COMP			# Get address of COMP message
	li	$v0, 4				# print_string syscall parameter
	syscall					# Execute syscall
	li	$v0, 6				# read_int syscall parameter
	syscall					# Execute syscall
	move	$s2, $v0			# Completions= s2
	
	## Get yards
	la	$a0, YARDS			# Get address of YARDSmessage
	li	$v0, 4				# print_string syscall parameter
	syscall					# Execute syscall
	li	$v0, 6				# read_int syscall parameter
	syscall					# Execute syscall
	move	$s3, $v0			# Yards = s3
	
	## Get touchdown
	la	$a0, TD				# Get address of TD message
	li	$v0, 4				# print_string syscall parameter
	syscall					# Execute syscall
	li	$v0, 6				# read_int syscall parameter
	syscall					# Execute syscall
	move	$s4, $v0			# Touchdown = s4
	
	## Get interceptions
	la	$a0, INTE				# Get address of INTE message
	li	$v0, 4				# print_string syscall parameter
	syscall					# Execute syscall
	li	$v0, 6				# read_int syscall parameter
	syscall					# Execute syscall
	move	$s5, $v0			# Interceptions = s5
	b		a

	## Determine results
a:	
	## ((comp/att)-.3)*5
	div	$t1, $s1, $s2			# comp/attemps = t1
	li	$t6, .3				# Load -.3 into t6
	sub	$t1, $t6, $t1			# t1 = (comp/att)-.3
	li	t6,	5				# load 5 into t6
	mult	$s2, $t6, $t1			# multiply 5*t1 = s2      a = s2
b:
	## ((yards/att)-3)*.25
	div	$t2, $s1, $s3			# yards/attemps = t2
	li	$t6, 3				# Load 3 into t6
	sub	$t1, $t6, $t2			# t1 = (yards/att)-3
	li	t6,	.25				# load .25 into t6
	mult	$s3, $t6, $t2			# multiply .25*t2 = s3      b = s3
	
c:
	## ((td/att)*20
	div	$t3, $s1, $s4			# td/attemps = t2
	li	t6,	20				# load 20 into t6
	mult	$s4, $t6, $t3			# multiply 20*t3 = s4      b = s4
d:
	## ((int/att)*25-2.375
	div	$t4, $s1, $s5			# int/attemps = t4
	li	$t6, 25				# Load 25 into t6
	mult	$t4, $t6, $t4			# multiply 25*t4 = t4      b = s5
	li	t6,	2.375			# load 2.375 into t6
	sub	$s5, $t6, $t4			# t4 - 2.375 = s5

results:
	## Full results has computer choice (here) and outcome (next)
	add		$s1, $s3, $s2		# a+b = r
	add		$s1, $s4, $s1		# r+c = r
	add		$s1, $s5, $s1		# r+d = s1
	move	$a0, $s1			# Outcome message

#************* How do you display the answer?*****************
	la 		$a0, result
	move	$a0, $s1
	li		$v0, 2
	syscall					# Execute syscall
	

	.data
ATT:				.asciiz "\nAttempts: \n"
COMP:			.asciiz "Computer used rock, "
YARDS			.asciiz "Computer used paper, "
TD:				.asciiz "Computer used scissors, "
INTE:			.asciiz "Computer wins!\n"
result:			.asciiz "Quaterback Passer Rating: \n"
