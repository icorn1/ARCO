.text
	.align 2
	.globl main
main:
	addi 	$s0, $zero, 10	# movem el 
	addi 	$s1, $zero, 3	
	add	$s2, $s0, $zero
loop:  
	move	$a0, $s2
	move	$a1, $s1
	addi	$sp, $sp, -4
	sw	$ra, 0($sp)
	jal	compara
	lw	$ra, 0($sp)
	addi	$sp, $sp, 4
	move 	$s2, $v0
	bgt	$s1, $s2, exit
	j	loop
exit:	
	jr 	$ra
	.end main

compara:
	move $t0, $zero
	ble $a0, $a1, elif
	sub $t1, $a0, $a1
	move $t0, $t1
	j 	exit1
elif:	bge $a0, $a1, exit1
	move $t0, $a0
exit1:	move $v0, $t0
	jr	$ra