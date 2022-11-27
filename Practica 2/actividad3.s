.data
X: .word 1, 2, 3, 4, -1, 3, 4, 3, -3, 6, -1, 4 , 0, 5, -1, 0
Y: .space 64
.text
.globl main
main:
	la $t0, X
	addi $t0, $t0, 48
	la $t1, Y
	addi $t1, $t1, 16

	
bucle:
	lw $s1, 0($t0)
	addi $s3, $s1, 10
	addi $t0, $t0, 4
	addi $t1, $t1, -4
	bne $t0, $t1, bucle
	sw $s3, 4($t1)
	addi $t0, $zero, 0
	addi $t1, $zero, 0
	addi $s3, $zero, 0
	addi $s1, $zero, 0