.eqv IN_ADRESS_HEXA_KEYBOARD 0xFFFF0012 
.data 
	Message: .asciiz "Oh my god. Someone's presed a button.\n" 
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ # MAIN Procedure #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ 
.text main:  
	li $t1, IN_ADRESS_HEXA_KEYBOARD 
	li $t3, 0x80 # bit 7 of = 1 to enable interrupt

	sb $t3, 0($t1)
	nop
Loop:
	nop
	nop
	nop
	nop
	b Loop
	nop
endmain:

.ktext 0x80000180

IntSR: 	addi $v0, $zero, 4
	la $a0, Message
	nop
	syscall

next_pc:
	mfc0 $at, $14
	addi $at, $at, 4
	mtc0 $at, $14
	eret