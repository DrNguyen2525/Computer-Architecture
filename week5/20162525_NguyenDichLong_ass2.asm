# Laboratory Exercise 5, Home Assignment 2
.data
Message: .asciiz "The sum of (s0) and (s1) is ”
x: .word 4
y: .word 5
.text
	la	$t0, x
	la	$t1, y
	lw	$s0, ($t0)
	lw	$s1, ($t1)
	add	$a1, $s0, $s1	# a1 = s0 + s1; a1 is the interger value to display
	li	$v0, 56
	la	$a0, Message
	syscall			# execute
