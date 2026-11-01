.data
v:      .word 50, 20, 100, 1, -9
n:      .word 5
msg_antes: .asciiz "Vetor antes: "
msg_depois: .asciiz "\nVetor depois: "
espaco: .asciiz " "

.text
.globl main

main:
    # Imprime mensagem "Vetor antes: "
    li $v0, 4
    la $a0, msg_antes
    syscall

    # Chama funcao de impressao para o vetor desordenado
    la $a0, v
    lw $a1, n
    jal print_vetor
    nop

    # Executa a ordenacao
    la $a0, v
    lw $a1, n
    jal sort
    nop

    # Imprime mensagem "Vetor depois: "
    li $v0, 4
    la $a0, msg_depois
    syscall

    # Chama funcao de impressao para o vetor ordenado
    la $a0, v
    lw $a1, n
    jal print_vetor
    nop

    # Encerra o programa no MARS
    li $v0, 10
    syscall

print_vetor:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $s0, 8($sp)
    sw $s1, 4($sp)
    sw $s2, 0($sp)

    add $s0, $a0, $zero     # $s0 = endereco base do vetor
    add $s1, $a1, $zero     # $s1 = tamanho n
    add $s2, $zero, $zero   # indice i = 0

print_loop:
    slt $t0, $s2, $s1
    beq $t0, $zero, print_Fim
    nop

    sll $t1, $s2, 2
    add $t2, $s0, $t1
    lw $a0, 0($t2)

    # Syscall para imprimir inteiro
    li $v0, 1
    syscall

    # Syscall para imprimir espaco
    li $v0, 4
    la $a0, espaco
    syscall

    addi $s2, $s2, 1
    j print_loop
    nop

print_Fim:
    lw $s2, 0($sp)
    lw $s1, 4($sp)
    lw $s0, 8($sp)
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
    nop

.set noreorder
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
    
    # Se $t0 for igual a zero, então é feito um goto para exit1.
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

    slt $t0, $t4, $t3       # $t0 = 1 se v[j+1] < v[j] (equivalente a v[j] > v[j+1])
    beq $t0, $zero, exit2   
    nop                     

    add $a0, $s2, $zero     # Carrega parametro 1 (v) para a chamada swap
    add $a1, $s1, $zero     # Carrega parametro 2 (j) para a chamada swap
    jal swap                # Chamada de procedimento
    nop                     



    addi $s1, $s1, -1       # j -= 1
    j for2tst               
    nop                     



exit2:
    addi $s0, $s0, 1        # i += 1
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
