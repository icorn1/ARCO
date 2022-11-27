.data

MemCacheDirect: 
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0
	.word 0 0


X: .word 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 
Y: .word -2 0 3 6 -2 12 -3 14 5 6 -7 8 19 -20 1 0 -3 3 32 -3 34 -5 6 -7 		
Z: .space 96


.text

.align 2
.globl main
main:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	la $s0, X
	la $s1, Y
	la $s2, Z
	addi $s3, $zero, 0	# contador iteraciones
	addi $s4, $zero, 0	# contador hits
	addi $s5, $zero, 24	# contador del for
	addi $s6, $zero, 0	# representara el offset de la @. (4, 8, 12, ...)
for:	beq $s5, $zero, fi

	add $t0, $s0, $s6	# @X[i]
	lw $t1, 0($t0)		# X[i] 
	add $t2, $s1, $s6	# @Y[i]
	lw $t3, 0($t2)		# Y[i] 
	add $t3, $t3, $t1	# Y[i] + X[i]
	add $t4, $s2, $s6	# @Z[i]
	sw $t3, 0($t4)		# Z[i] = Y[i] + X[i]
	
	addi $sp, $sp, -8
	sw $t2, 0($sp)
	sw $t4, 4($sp)
	addi $a0, $t0, 0
	jal callCache
	add $s4, $s4, $v0	# si es hit, s4 + 1
	addi $s3, $s3, 1	# contador total
	lw $t2, 0($sp)
	addi $sp, $sp, 4	
	
	addi $a0, $t2, 0
	jal callCache
	add $s4, $s4, $v0	# si es hit, s4 + 1
	addi $s3, $s3, 1	# contador total
	lw $t4, 0($sp)
	addi $sp, $sp, 4

	addi $a0, $t4, 0
	jal callCache
	add $s4, $s4, $v0	# si es hit, s4 + 1
	addi $s3, $s3, 1	# contador total
		
	addi $s6, $s6, 4 
	addi $s5, $s5, -1
	j for
fi:	sub $s7, $s3, $s4	# contador de misses en s7
	lw $ra, 0($sp)	
	addi $sp, $sp, 4
	jr $ra
.end main

callCache:
	srl $t0, $a0, 4		# line	
	andi $t1, $t0, 0x0f	# line_cache
	srl $t2, $a0, 8		# tag
 	la $t3, MemCacheDirect
	addi $t4, $zero, 8
	mul $t5, $t1, $t4	# en $t5 tenemos el la posicion mem[line_cache], falta sumar
	add $t5, $t5, $t3	# Ahora en $t5 tenemos @mem[line_cache]
	lw $t6, 0($t5)		
	lw $t7, 4($t5)		# Tenemos en $t6 y $t7 valid y tag, respectivamente.
	andi $t4, $t6, 1	# VALID = 1?
	beq $t4, $zero, else
	bne $t7, $t2, else	# M[line].TAG = tag ?
	addi $v0, $zero, 1
	jr $ra
else: 
	sw $t2, 4($t5)		# Guardamos TAG
	addi $t4, $zero, 1
	sw $t4, 0($t5)		# Guardamos VALID
	addi $v0, $zero, 0
	jr $ra	

