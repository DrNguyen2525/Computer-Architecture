#Laboratory Exercise 5, Assignment 5
.data
x: 	.space 20
y:	.space 20
Message1:        .asciiz "Nhap xau [20]:"
Message2:        .asciiz "Xau dao nguoc"
.text
main:
get_string:   
	li   $v0, 54
	la   $a0, Message1
	la   $a1, y
	la   $a2, 20
	syscall
get_length:   
	la   $a0, y          # a0 = Address(string) = Address( string[0])
	xor  $v0, $zero, $zero     # v0 = length = 0
	xor  $t0, $zero, $zero     # t0 = i = 0
check_char:   
	add  $t1, $a0, $t0         # t1 = a0 + t0 = Address(string[0]+i) = Address(string[i])
	lb   $t2, 0($t1)           # t2 = string[i]
	beq  $t2,$zero,end_of_str  # Is null char?      
	addi $v0, $v0, 1           # v0 = v0 + 1 <--> length = length + 1
	addi $t0, $t0, 1           # t0 = t0 + 1 <--> i = i + 1
	j    check_char
end_of_str:                             
end_of_get_length:

is_lgt20:     
	bgt  $v0, 20, lgt20
	j    rev_string
lgt20:	
	li   $v0, 20

rev_string:
	la 	$a0, x
	la 	$a1, y
	addi 	$a3, $v0, -1

	add	$s0,$a3,$zero        #s0 = i=0
L1:
	add	$t1,$s0,$a1             #t1 = s0 + a1 = i + y[0]
                                        #   = address of y[i]
	lb	$t2,0($t1)              #t2 = value at t1 = y[i]
	sub 	$s1,$a3,$s0
	add	$t3,$s1,$a0             #t3 = s0 + a0 = i + x[0] 
                                        #   = address of x[i]
	sb	$t2,0($t3)              #x[i]= t2 = y[i]
	beq	$s0,$zero,end_of_rev_string #if y[i]==0, exit
	nop
	addi	$s0,$s0,-1               #s0=s0 + 1 <-> i=i+1
	j	L1                      #next character
	nop
end_of_rev_string:
print:
	li 	$v0, 4
	la 	$a0, x
  	syscall
  	
  	li 	$v0, 55
	la	$a0, x
	syscall