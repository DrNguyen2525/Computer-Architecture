# Laboratory Exercise 4, Home Assignment 5
.text
li	$s1, 1				# i=1
la	$s2, 2				# load value of x in $s2
li	$s3, 3				# n = power
li	$s4, 1				# step=1

loop:	sll	$s2,$s2,1		# shift left logical 1 bit
	add 	$s1,$s1,$s4		# i=i+step
	bne	$s1,$s3,loop		# if i != n, goto loop