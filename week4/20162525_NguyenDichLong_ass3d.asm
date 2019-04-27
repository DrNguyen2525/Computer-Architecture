# Laboratory Exercise 4, Home Assignment 3d
.text
li	$s1, -5
li	$s2, 3
slt	$t0, $s2, $s1
beq	$t0, 0, L
L:
add	$s1, $s1, 1