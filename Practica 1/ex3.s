main:
	addi $a0, $zero, 1
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal leaf_function
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
.end main
leaf_function:
	addi $t0, $a0, 1
	addi $t1, $zero, 5
	slt $t2, $t1, $a0
	beq $t2, $zero, exit
	move $v0, $t0 
	jr $ra
exit:	move $a0, $t0
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	jal leaf_function
	lw  $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	.data
	.align 0