# Laboratory Exercise 3, Home Assignment 4d
.data
x: .word 1
y: .word 2
z: .word 3

.text
la $s0, x			# load the address of x variable
lw $t1, 0($s0)			# load the value of x to register $t1
la $s0, y			# load the address of y variable
lw $t2, 0($s0)			# load the value of y to register $t2
la $s0, z			# load the address of z variable
lw $t3, 0($s0)			# load the value of z to register $t3

li  $s1, 1			# load the value for i to register $s1
li  $s2, 2			# load the value for j to register $s2
li  $s3, 3			# load the value for m to register $s3
li  $s4, 4			# load the value for n to register $s4

add $s5, $s1, $s2		# k = i+j
add $s6, $s3, $s4		# p = m+n

start:
	slt $t0,$s5,$s6		# k<p
	beq $t0,$zero,else	# branch to else if k<p
	addi $t1,$t1,1		# then part: x=x+1
	addi $t3,$zero,1	# z=1
	j endif			# skip “else” part

else:
	addi $t2,$t2,-1		# begin else part: y=y-1
	add $t3,$t3,$t3		# z=2*z

endif:
