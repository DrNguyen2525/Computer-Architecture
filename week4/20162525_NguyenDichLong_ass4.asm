# Laboratory Exercise 4, Home Assignment 4
.text
init:   li     $s1, 0x7FFFFFFF
        li     $s2, 0x1
start:
	li 	$t0,0		#No Overflow is default status
	add 	$s3,$s1,$s2     # s3 = s1 + s2
	xor 	$t1,$s1,$s2	#Test if $s1 and $s2 have the same sign	
	bltz 	$t1,EXIT	#If not, exit
	xor 	$t1,$s1,$s3	#Test if $s3 and $s1 have the same sign

     				# if $s3 and $s1 have the same sign, then the result is not overflow
     	bltz 	$t1,OVERFLOW	# If not, the result is overflow
	j	EXIT		# Else, the result is not overflow			
OVERFLOW:
	li	$t0,1		#the result is overflow
EXIT:
