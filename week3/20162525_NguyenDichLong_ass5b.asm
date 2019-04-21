# Laboratory 3, Home Assigment 5b
.data
A: .word 1 2 3 4 5

.text
li	$s1, -1				# i=-1
la	$s2, A				# load value of array A in $s2
li	$s3, 5				# n = number of elements in array A
li	$s4, 1				# step=1

loop:	add 	$s1,$s1,$s4		# i=i+step
	add 	$t1,$s1,$s1		# t1=2*s1
	add	$t1,$t1,$t1		# t1=4*s1	
	add	$t1,$t1,$s2		# t1 store the address of A[i]
	lw	$t0,0($t1)		# load value of A[i] in $t0
	add	$s5,$s5,$t0		# sum=sum+A[i]
	sle	$s1,$s3,loop		# if i != n, goto loop
	
