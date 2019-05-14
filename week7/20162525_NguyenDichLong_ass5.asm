#Laboratory Exercise 7, Home Assignment 5
.data
Message1: .asciiz  "\nLargest: "
Message2: .asciiz  "\nSmallest: "
Comma: .asciiz	", "

.text
li	$t6, 8			# numbers of elements

li	$s0, -3
li	$s1, 10
li	$s2, 2
li	$s3, 0
li	$s4, -1
li	$s5, 6
li	$s6, -5
li	$s7, 8

subi	$t6, $t6, 2		# for calculating the position of max and min element

push:
	addi   $sp,$sp,-32      #adjust the stack pointer
      	sw     $s0, 28($sp)      #push $s0 to stack
      	sw     $s1, 24($sp)      #push $s1 to stack
      	sw     $s2, 20($sp)      #push $s2 to stack
      	sw     $s4, 16($sp)      #push $s3 to stack
      	sw     $s4, 12($sp)      #push $s4 to stack
      	sw     $s5, 8($sp)      #push $s5 to stack
      	sw     $s6, 4($sp)      #push $s6 to stack
      	sw     $s7, 0($sp)      #push $s7 to stack

main:

	jal	max		# call procedure "max"
print_max:
	li	$v1, 0			# set v1 = 0
	add	$v1, $v1, $v0		# $v1 = $v0 = result from max
       	li     	$v0, 4
       	la     	$a0, Message1
       	syscall
       	
       	add    	$a0, $v1, $zero 	# $a0 = result from max
       	li     	$v0, 1
       	syscall
       	
       	li     	$v0, 4
       	la     	$a0, Comma
       	syscall
       	
       	add	$a0, $zero, $t7		# a0 = t7 = position
       	li	$v0, 1
       	syscall
       	

#----------------------------------------------------------------------

	jal	min		# call procedure "min"
print_min:
	li	$v1, 0			# set v1 = 0
	add	$v1, $v1, $v0		# $v1 = $v0 = result from max
       	li     	$v0, 4
       	la     	$a0, Message2
       	syscall
       	
       	add    	$a0, $v1, $zero 	# $a0 = result from max
       	li     	$v0, 1
       	syscall
       	
       	li     	$v0, 4
       	la     	$a0, Comma
       	syscall
       	
       	add	$a0, $zero, $t7	# a0 = t7 = position
       	li	$v0, 1
       	syscall

quit:
	li     	$v0, 10         # terminate
       	syscall


#----------------------------------------------------------------------
#Procedure max: find the largest of 8 integers
#param[in]  8 intergers from stack's top
#return     $v0   the largest value
#----------------------------------------------------------------------
max:
	li	$t9, 0			# set t9=i=0
	la	$t8, 4($sp)		# set t8 = address of s6 in stack
	li	$t7, 7			# set t7 = position of max
	lw	$v0, 0($sp)		# set v0=max=s7
maxloop:
	lw	$t0, 0($t8)		# t0=s6
	sub     $t1, $t0, $v0	     	# compute t1 = t0 - v0
      	bgtz    $t1, setmax        	# if t1 = t0 - v0 >0 then set v0 = t0
      	nop				# else no change
      	addi	$t8, $t8, 4		# move to next element in stack
	addi	$t9, $t9, 1		# i++
	beq	$t9, 7, endmax		# if i=7, jump to endmax
	j	maxloop
setmax:
      	add     $v0, $t0, $zero   	# v0 = t0
      	li	$t7, 0			# t7 = 0
      	sub	$t7, $t9, $t6		# t7 hold the position of max integer
      	sub	$t7, $0, $t7		# t7 = 6-t9 = -(t9-6) = -(i-6)
      	addi	$t8, $t8, 4		# move to next element in stack
	addi	$t9, $t9, 1		# i++
	beq	$t9, 7, endmax		# if i=7, jump to endmax
	j	maxloop
endmax:
	jr	$ra


#----------------------------------------------------------------------
#Procedure min: find the smallest of 8 integers
#param[in]  8 intergers from stack's top
#return     $v0   the smallest value
#----------------------------------------------------------------------
min:
	li	$t9, 0			# set t9=i=0
	la	$t8, 4($sp)		# set t8 = address of s6 in stack
	li	$t7, 7			# set t7 = position of min
	lw	$v0, 0($sp)		# set v0=min=s7
minloop:
	lw	$t0, 0($t8)		# t0=s6
	sub     $t1, $t0, $v0	     	# compute t1 = t0 - v0
      	bltz    $t1, setmin        	# if t1 = t0 - v0 <0 then set v0 = t0
      	nop				# else no change
      	addi	$t8, $t8, 4		# move to next element in stack
	addi	$t9, $t9, 1		# i++
	beq	$t9, 7, endmin		# if i=7, jump to endmax
	j	minloop
setmin:
      	add     $v0, $t0, $zero   	# v0 = t0
      	li	$t7, 0			# t7 = 0
      	sub	$t7, $t9, $t6		# t7 hold the position of min integer
      	sub	$t7, $0, $t7		# t7 = 6-t9 = -(t9-6) = -(i-6)
      	addi	$t8, $t8, 4		# move to next element in stack
	addi	$t9, $t9, 1		# i++
	beq	$t9, 7, endmin		# if i=7, jump to endmax
	j	minloop
endmin:
	jr	$ra
