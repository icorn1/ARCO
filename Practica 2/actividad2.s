.data
X: .word 1, 2, 3, 4
Y: .word -2, 0, 3, 6		
Z: .space 16
.text
.globl main
main:
	addi $s0,$zero, 4
	addi $t3,$zero, 0	
	la $t0, X
	la $t1, Y
	la  $t2, Z
bucle:
	lw $s1, 0($t0)   
	lw $s2, 0($t1)  
	add $s3, $s2, $s1
	
	sw $s3, 0($t2)		
	addi $t3, $t3, 1
	addi $t0, $t0, 4
	addi $t1, $t1, 4
	addi $t2, $t2, 4
	bne $t3, $s0, bucle
	addi $s0,$zero, 4
	addi $t3,$zero, 0	
	addi $t1, $zero, 0
	addi $t0,$zero, 0	
