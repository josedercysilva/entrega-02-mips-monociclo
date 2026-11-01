.set noreorder
.text
.global sort

sort:
    addi $sp, $sp, -20  
       
    sw $ra, 16($sp)        
    sw $s3, 12($sp)        
    sw $s2, 8($sp) 
    sw $s1, 4($sp)          
    sw $s0, 0($sp)

    add $s2, $a0, $zero     # $s2 = v 
    add $s3, $a1, $zero     # $s3 = n 
    add $s0, $zero, $zero   # i = 0

for1tst:
    slt $t0, $s0, $s3       # verifica se i < n

    beq $t0, $zero, exit1   
    
    nop                     

    addi $s1, $s0, -1       # j = i - 1


for2tst:
    slti $t0, $s1, 0        # $t0 = 1 se j < 0
    bne $t0, $zero, exit2   
    nop                     


    sll $t1, $s1, 2         
    add $t2, $s2, $t1       
    lw $t3, 0($t2)         
    lw $t4, 4($t2)          

    slt $t0, $t4, $t3       # $t0 = 1 se v[j+1] < v[j]
    beq $t0, $zero, exit2   
    nop                     

    add $a0, $s2, $zero
    add $a1, $s1, $zero
    jal swap
    nop                     



    addi $s1, $s1, -1       # j -= 1
    j for2tst               
    nop                     



exit2:
    addi $s0, $s0, 1
    j for1tst               
    nop                     

exit1:
    lw $s0, 0($sp)          
    lw $s1, 4($sp)
    lw $s2, 8($sp)
    lw $s3, 12($sp)
    lw $ra, 16($sp)
    addi $sp, $sp, 20       
    jr $ra                  
    nop                     

swap:
    sll $t0, $a1, 2
    add $t0, $a0, $t0
    lw $t1, 0($t0)
    lw $t2, 4($t0)
    sw $t2, 0($t0)
    sw $t1, 4($t0)
    jr $ra
    nop
