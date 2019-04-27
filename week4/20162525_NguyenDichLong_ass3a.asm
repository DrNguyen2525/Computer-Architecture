# Laboratory Exercise 4, Home Assignment 3a
.text
li	$s1, -10
sra 	$at, $s1, 0x0000001f
xor 	$s0, $at, $s1
subu 	$s0, $s0, $at