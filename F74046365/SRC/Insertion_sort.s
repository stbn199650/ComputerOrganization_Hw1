	.data
	array:	.word	9, 2, 8, 6, 1, 5, 4, 10, 3, 7	
	
	.text			
	.globl main
main:		
	addi 	$t0,$zero,4097	# $t0 = 0x00001001

	sll  	$t0,$t0,16	# set the base address of array into $t0 = 0x10010000	
	addi	$t1,$zero,10	# $t1=10
	addi	$t2,$zero,1	# i=1	

For:
	slt	$t3,$t2,$t1	# i<11?1:0
	beq	$t3,$zero,Exit	# i>=11,Exit
	addi	$t3,$t2,0	# j=i

While:
	addi 	$t0,$zero,4097
	sll  	$t0,$t0,16	
	sll	$t4,$t3,2	# assign memory place,$t4=$t3*4
	add	$t0,$t0,$t4	# array[j]=array[0+j]
	beq	$t3,$zero,W_End	# j==0
	lw	$t5,0($t0)	# array[i]
	lw	$t6,-4($t0)	# array[i-1]
	slt	$t7,$t6,$t5	# array[i-1]<array[i]
	bne	$t7,$zero,W_End	# array[i-1]<array[i],W_End

	sw	$t5,-4($t0)	#value in $t5 store into array[i-1]
	sw	$t6,0($t0)	# value in $t6 store into array[i]
	addi	$t3,$t3,-1	# j=j-1
	j	While

W_End:	
	addi	$t2,$t2,1	# i=i+1
	j	For		# go to For

Exit:		
	li   $v0, 10		# Exit program
	syscall