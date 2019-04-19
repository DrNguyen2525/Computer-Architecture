#------------------------------------------------------------------------------
# Laboratory Exercise 10, Assignment 1
# Written by Jan Eric Larsson, 26 November 1998
#------------------------------------------------------------------------------
#include <iregdef.h>
.set noreorder
.text
.globl start
.ent start
start: 
	add t0, t1, t2  // t1=1, t2=2 --> t0 = 3
	nop
	nop
	add s0, t0, t0  // s0 = 6
	nop
	nop
	nop
.end start
