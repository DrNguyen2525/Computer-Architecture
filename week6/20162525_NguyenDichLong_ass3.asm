.data
	array: .word	10, 3, 5, 8, 1

.text

# Procedure:    bubbleSort
# Objective:    sort an array of integer elements in nondecreasing order
# Input:        an address of an array of integers
# Output:       an array sorted in nondecreasing order

bubbleSort:
 	la	$t9, array	# load address of the array into $t9 (base address)
  	la    	$t0, array     # load address of the array into $t0
  	li      $s0, 1      # boolean swap = false.  0 --> false, 1 --> true
	li      $t1, 0      # j = 0;
 	li      $t2, 0      # i = 0;
 	li      $s1, 5      # array length

loop:
	beqz    $s0, exit       # exit if swap = false
	li      $s0, 0          # swap = false;
	addiu   $t1, $t1, 1  # j++;
	move    $t2, $0      # i = 0;
	subu    $s2, $s1, $t1  # s2 = length - j

forLoop:
         bge     $t2, $s2, exitForLoop   # if i>=s2, exit
         lw      $a0, 0($t0)         # a0 = array[i]
         lw      $a1, 4($t0)         # a1 = array[i+1]
         ble     $a0, $a1, update        # if array[i]<=array[i+1] skip
         sw      $a1, 0($t0)         # a[i+1] = a[i]
         sw      $a0, 4($t0)         # a[i] = a[i+1]
         li      $s0, 1                 # swap = true;

update:
         addiu   $t2, $t2, 1         # i++
         sll     $t3, $t2, 2         # t3 = i*4
         move    $t0, $t9		# set t0 to base address
         addu    $t0, $t0, $t3        # point to next element -->
         j       forLoop

exitForLoop:
         j   loop

exit: