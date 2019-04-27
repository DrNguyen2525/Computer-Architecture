# Laboratory Exercise 4, Home Assignment 2
.text
li	$s0, 0x0563		# load test value for these function
andi	$t0, $s0, 0xff		# Extract the LSB of $s0
andi	$t1, $s0, 0x0400	# Extract bit 10 of $s0

andi	$t2, $s0, 0xff00	# Extract the MSB of $s0
andi	$s0, $s0, 0xff00	# Clear the LSB of $s0
ori	$s0, $s0, 0x00ff	# Set LSB of $s0 (bits 7 to 0 are set to 1)
andi	$s0, $s0, 0x0000	# Clear $s0