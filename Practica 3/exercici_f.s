.data
	memCacheDirect:
		.space 128
	address: 
		.word 0x1000470
.text

callCache:
	srl $t0, $a0, 4		# valid
	andi $t1, $t0, 0x0f	# line_cache
	srl $t2, $a0, 8		# tag
 	la $t3, memCacheDirect
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

.globl main
main:
	la $s0, address
	lw $a0, 0($s0)
	jal callCache
	jr $ra
