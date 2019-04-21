# Laboratory Exercise 3, Home Assignment 4c
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

li  $s1, 5			# load the value 5 for i to register $s1
li  $s2, 3			# load the value 3 for j to register $s2

add $s3, $s1, $s2		# k = i+j

start:
	slt $t0,$zero,$s3	# k>0
	beq $t0,$zero,else	# branch to else if k>0
	addi $t1,$t1,1		# then part: x=x+1
	addi $t3,$zero,1	# z=1
	j endif			# skip “else” part

else:
	addi $t2,$t2,-1		# begin else part: y=y-1
	add $t3,$t3,$t3		# z=2*z

endif:
