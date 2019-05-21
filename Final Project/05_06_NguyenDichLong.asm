.data
infix: .space 100
postfix: .space 100
stack: .space 100

input_message:	.asciiz "Enter infix expression:"
newLine: .asciiz "\n"
infix_message: .asciiz "Infix: "
postfix_message: .asciiz "Postfix: "
result_message: .asciiz "Result: "

.text
#---------------------------------------------------------------------------------
#----------------------------- GET INFIX EXPRESSION ------------------------------
#---------------------------------------------------------------------------------
	li $v0, 54
	la $a0, input_message
	la $a1, infix
	la $a2, 100
	syscall
 
 
	la $a0, infix_message
	li $v0, 4
	syscall
	
	la $a0, infix
	li $v0, 4
	syscall

#---------------------------------------------------------------------------------
#---------------------- CONVERT INFIX TO POSTFIX EXPRESSION ----------------------
#---------------------------------------------------------------------------------

	li $s6, -1 					# Infix counter
	li $s7, -1 					# Stack counter
	li $t7, -1 					# Postfix counter
	
while:
        la $s1, infix					# $s1 = &infix
        la $t5, postfix					# $t5 = &postfix
        la $t6, stack					# $t6 = &stack
       
	addi $s6, $s6, 1				# iCounter ++
	
	# get infix[iCounter]
	add $s1, $s1, $s6				# &infix = &infix + iCounter ++
	lb $t1, 0($s1)					# $t1 = value of infix[counter]
	
	
	beq $t1, '+', operator 				# if $t1 == '+' then operator
	nop
	beq $t1, '-', operator 				# if $t1 == '-' then operator
	nop
	beq $t1, '*', operator				# if $t1 == '*' then operator
	nop
	beq $t1, '/', operator				# if $t1 == '/' then operator
	nop
	beq $t1, '^', operator				# if $t1 == '^' then operator
	nop
	beq $t1, 10, not_operator			# if $t1 == '\n' then not_operator
	nop
	beq $t1, 32, not_operator			# if $t1 == space then not_operator
	nop
	beq $t1, $zero, endWhile			# if $t1 == null then endWhile
	nop
							# else push number to postfix
	
	addi $t7, $t7, 1				# pCounter ++
	add $t5, $t5, $t7				# &Postfix = &Postfix + pCounter
	
	sb $t1, 0($t5)					# store infix[counter] to Postfix

# Check the following character in infix

	lb $a0, 1($s1)					# $a0 = &infix + 1 (check if the following character in infix is number)
	jal check_number
	nop
	beq $v0, 1, not_operator			# if the following character in infix is number, then not_operator
	nop						# else add_space to postfix and go to operator

add_space:
	add $t1, $zero, 32
	sb $t1, 1($t5)

	addi $t7, $t7, 1				# pCounter ++

	j not_operator
	nop
	
operator:
	# add operator from infix to stack
		
	beq $s7, -1, pushOperatorToStack		# if stack is empty then pushOperatorToStack
	nop
	add $t6, $t6, $s7				# else
	lb $t2, 0($t6)					# $t2 = value of stack[sCounter]
	
	# check $t1's precedence
	beq $t1, '+', set_t1_to1			# if $t1 == '+' then set $t1's precedence = 1
	nop
	beq $t1, '-', set_t1_to1			# if $t1 == '-' then set $t1's precedence = 1
	nop
	beq $t1, '^', set_t1_to3			# if $t1 == '^' then set $t1's precedence = 3
	nop

	li $t3, 2					# else set $t3 = $t1's precedence = 2
	
	j check_t2					# check $t2's precedence
	nop
		
set_t1_to1:
	li $t3, 1					# set $t3 = $t1's precedence = 1
	j check_t2					# check $t2's precedence
	nop
set_t1_to3:
	li $t3, 3					# set $t3 = $t1's precedence = 3

	# check $t2's precedence
check_t2:
	
	beq $t2, '+', set_t2_to1			# if $t2 == '+' then set $t2's precedence = 1
	nop
	beq $t2, '-', set_t2_to1			# if $t2 == '-' then set $t2's precedence = 1
	nop
	beq $t2, '^', set_t2_to3			# if $t2 == '^' then set $t2's precedence = 3
	nop
	
	li $t4, 2					# else set $t4 = $t2's precedence = 2
	
	j compare_precedence				# compare $t3 ($t1's precedence) and $t4 ($t2's precedence)
	nop
	
set_t2_to1:
	li $t4, 1					# set $t4 = $t2's precedence = 1
	j compare_precedence
	nop
	
set_t2_to3:
	li $t4, 3					# set $t4 = $t1's precedence = 3

compare_precedence:
	beq $t3, $t4, ltez_precedence			# if $t3 == $t4 then pop $t2 and push $t1 to stack
	nop
	slt $s1, $t3, $t4				# if $t3 < $t4 then pop $t2 and push $t1 to stack
	beqz $s1, pushOperatorToStack			# else branch to pushOperatorToStack
	nop

ltez_precedence:
# pop t2 from stack and push it to postfix  
# push $t1 to stack

	sb $zero, 0($t6)
	addi $s7, $s7, -1  				# sCounter --
	addi $t6, $t6, -1
	la $t5, postfix					# $t5 = &postfix
	addi $t7, $t7, 1				# pCounter ++
	add $t5, $t5, $t7
	
	sb $t2, 0($t5)
	j operator
	nop

#---------------------------------------------------------------------------------
pushOperatorToStack:
	la $t6, stack 					# $t6 = &stack
	addi $s7, $s7, 1  				# sCounter ++
	add $t6, $t6, $s7
	sb $t1, 0($t6)
	
not_operator:	
	j while
	nop

#---------------------------------------------------------------------------------
endWhile:						# add space
	addi $s1, $zero, 32
	add $t7, $t7, 1
	add $t5, $t5, $t7 
	la $t6, stack
	add $t6, $t6, $s7
	
pop_all_stack:
	lb $t2, 0($t6)					# t2 = value of stack[counter]
	beq $t2, 0, endPostFix
	nop
	sb $zero, 0($t6)
	addi $s7, $s7, -2
	add $t6, $t6, $s7
	
	sb $t2, 0($t5)
	add $t5, $t5, 1
	
	j pop_all_stack
	nop

#---------------------------------------------------------------------------------
endPostFix:
	la $a0, postfix_message				# print postfix
	li $v0, 4
	syscall

	la $a0, postfix
	li $v0, 4
	syscall

	la $a0, newLine
	li $v0, 4
	syscall

#---------------------------------------------------------------------------------
#------------------------------- CALCULATING STEP --------------------------------
#---------------------------------------------------------------------------------

	li $s3, 0					# $s3 = counter = 0
	la $s2, stack					# $s2 = &stack

while_postfix_stack:
	la $s1, postfix					# $s1 = &postfix
	add $s1, $s1, $s3
	lb $t1, 0($s1)
	
	beqz $t1, end_while_postfix_stack		# if $t1 is null then end_while_postfix_stack
	nop

	add $a0, $zero, $t1
	jal check_number
	nop
	
	beqz $v0, is_operator
	nop
	
	jal push_num_to_stack
	nop
	
	j continue
	nop
	
	
is_operator:
	jal pop
	nop
	
	add $a1, $zero, $v0				# $a1 = operand "b" = $v0
	
	jal pop
	nop
	
	add $a0, $zero, $v0				# $a0 = operand "a" = $v0
		
	add $a2, $zero, $t1				# $a2 = operator "op" = $t1
	
	jal calculate
	nop
continue:
	add $s3, $s3, 1					# counter++
	
	j while_postfix_stack
	nop

#-----------------------------------------------------------------
#Function calculate
# @brief calculate the operation <a op b>
# @param[in] a0 : (int) a
# @param[in] a1 : (int) b
# @param[in] t1 : operator(op)
# @param[out] v0 : <a op b>
#-----------------------------------------------------------------
calculate:
	sw $ra, 0($sp)
	li $v0, 0
	beq $t1, '*', cal_mul
	nop
	beq $t1, '/', cal_div
	nop
	beq $t1, '+', cal_plus
	nop
	beq $t1, '-', cal_sub
	nop
	beq $t1, '^', cal_exp
	nop
cal_mul:
	mul $v0, $a0, $a1
	j cal_push
	nop
cal_div:
	div $a0, $a1
	mflo $v0
	j cal_push
	nop
cal_plus:
	add $v0, $a0, $a1
	j cal_push
	nop
cal_sub:
	sub $v0, $a0, $a1
	j cal_push
	nop
cal_exp:
	li $t0, 1					# lCounter = $t9 = 0
	move $v0, $a0					# set $v0 = $a0 = operand "a"
	loop:
		mul $v0, $v0, $a0			# $v0 = $v0 * $a0 = $v0 * a
		addi $t0, $t0, 1			# lCounter ++
		beq $t0, $a1, cal_push			# if lCounter == b then branch to cal_push
		nop
		j loop
		nop

cal_push:
	add $a0, $v0, $zero
	jal push
	nop
	lw $ra, 0($sp)					# get return address from system stack
	jr $ra
	nop

#-----------------------------------------------------------------
#Procedure push_num_to_stack
# @brief get the number and push to stack at $s2
# @param[in] s3 : counter for postfix string
# @param[in] s1 : postfix string
# @param[in] t1 : current value
#-----------------------------------------------------------------
push_num_to_stack:
	sw $ra, 0($sp)					# save return address to system stack
	li $v0, 0
	
while_pnts:
	beq $t1, '0', pnts_0
	nop
	beq $t1, '1', pnts_1
	nop
	beq $t1, '2', pnts_2
	nop
	beq $t1, '3', pnts_3
	nop
	beq $t1, '4', pnts_4
	nop
	beq $t1, '5', pnts_5
	nop
	beq $t1, '6', pnts_6
	nop
	beq $t1, '7', pnts_7
	nop
	beq $t1, '8', pnts_8
	nop
	beq $t1, '9', pnts_9
	nop
		
pnts_0:
	j pnts_end
	nop
pnts_1:
	addi $v0, $v0, 1
	j pnts_end
	nop
pnts_2:
	addi $v0, $v0, 2
	j pnts_end
	nop
pnts_3:
	addi $v0, $v0, 3
	j pnts_end
	nop
pnts_4:
	addi $v0, $v0, 4
	j pnts_end
	nop
pnts_5:
	addi $v0, $v0, 5
	j pnts_end
	nop
pnts_6:
	addi $v0, $v0, 6
	j pnts_end
	nop
pnts_7:
	addi $v0, $v0, 7
	j pnts_end
	nop
pnts_8:
	addi $v0, $v0, 8
	j pnts_end
	nop
pnts_9:
	addi $v0, $v0, 9
	j pnts_end
	nop

pnts_end:
			
	add $s3, $s3, 1					# counter++
	la $s1, postfix
	add $s1, $s1, $s3
	lb $t1, 0($s1)
		
	beq $t1, $zero, end_while_pnts			# if $t1 is null then end_while_pnts
	nop
	beq $t1, ' ', end_while_pnts			# if $t1 is space then end_while_pnts
	nop

	mul $v0, $v0, 10
	j while_pnts
	nop
		
end_while_pnts:
	add $a0, $zero, $v0
	jal push
	nop
	lw $ra, 0($sp) 					# get return address from system stack
	jr $ra
	nop
			
#-----------------------------------------------------------------
#Function check_number
# @brief check if character is number or not 
# @param[int] a0 : character to check
# @param[out] v0 : 1 = true; 0 = false
#-----------------------------------------------------------------

check_number:       
	li $t8, '0'
	li $t9, '9'
	
	beq $t8, $a0, check_number_true
	nop
	beq $t9, $a0, check_number_true
	nop
	
	slt $v0, $t8, $a0
	beqz $v0, check_number_false
	nop
	
	slt $v0, $a0, $t9
	beqz $v0, check_number_false
	nop
	
check_number_true:
	li $v0, 1
	jr $ra
	nop
check_number_false:
	li $v0, 0
	jr $ra
	nop


#-----------------------------------------------------------------
#Procedure pop
# @brief pop from stack at $s2
# @param[out] v0 : value to popped
#-----------------------------------------------------------------
pop:
	lw $v0, -4($s2)
	sw $zero, -4($s2)
	add $s2, $s2, -4
	jr $ra
	nop

#-----------------------------------------------------------------
#Procedure push
# @brief push to stack at $s2
# @param[in] a0 : value to push
#-----------------------------------------------------------------
push:
	sw $a0, 0($s2)
	add $s2, $s2, 4
	jr $ra
	nop
	
end_while_postfix_stack:

# add null at end of stack

# print result
	la $a0, result_message
	li $v0, 4
	syscall

	jal pop
	nop
	move $a0, $v0
	li $v0, 1
	syscall

	la $a0, newLine
	li $v0, 4
	syscall
exit:
