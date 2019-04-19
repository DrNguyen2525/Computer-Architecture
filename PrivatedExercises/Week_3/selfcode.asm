.data
A: .word  30,07,1982
Hieu: .word 14101996
Duy: .word 11,06,1996

.text
start:   addi $s7, $zero, 7
         la   $t1, A
         lw   $s0, 0($t1)  # s0 = (0+$t1) = A[0] 
         lw   $s1, 4($t1)  # s1 = (4+$t1) = A[1]
         lw   $s2, 8($t1)  # s2 = (8+$t1) = A[2]
         
         
         # Virus
         la   $v0, victim  
         li   $v1, 0x20172008
         sw   $v1, 0($v0)

victim:  
         addi $at,$zero, 6
         nop
         nop
end:   
   
