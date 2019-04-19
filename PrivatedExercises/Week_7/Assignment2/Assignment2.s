#------------------------------------------------------------------------------
# Laboratory Exercise 10, Assignment 2
# Written by Jan Eric Larsson, 26 November 1998
#------------------------------------------------------------------------------
#include <iregdef.h>
.set noreorder
.text
.globl start
.ent start
start: 
	lw  t0, 16(t1)
	nop
	nop
	nop
	add t0,t0,t0       // can 3 lenh nop
.end start
