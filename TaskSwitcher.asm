.data
.align 2
tid:        .word 0
tcb0:       .space 120
tcb1:       .space 120

#test values
str0:       .asciiz "123"
str1:       .asciiz "456"

.text
main: 
    
    j task0
    
task0:
    
    addi    $t7, $0, 100
    
task0body:
	
    add     $t0, $0, $0
    jal ts     
    addi    $t1, $0, 10
    la      $s0, str0
    jal ts
    
beg0:
    
    lb      $t2, ($s0)
    beq     $t2, $0, quit0
    sub     $t2, $t2, '0'
    mult    $t0, $t1
    mflo    $t0
    add     $t0, $t0, $t2
    jal ts
    add     $s0, $s0, 1
    b beg0
    
quit0:
    
    jal ts
    add     $v1, $0, $t0
    add     $s0, $0, $v1
    add     $a1, $0, $s0
    jal ts
    add     $t5, $0, $a1
    add     $t6, $0, $t5
    addi    $s0, $0, 1
    add     $v0, $0, $s0
    add     $a0, $0, $t6
    jal ts
    syscall
    addi    $t7, $t7, -1
    beq     $t7, $0, done
    
    j task0body
    
task1:
    
    addi    $t7, $0, 100
    
task1body:
    
    add     $t0, $0, $0
    addi    $t1, $0, 10
    la      $s0, str1
    
beg1:
    
    lb      $t2, ($s0)
    beq     $t2, $0, quit1
    jal ts
    sub     $t2, $t2, '0'
    mult    $t0, $t1
    mflo    $t0
    add     $t0, $t0, $t2
    add     $s0, $s0, 1
    b beg1
    
quit1:
    
    add     $v1, $0, $t0
    add     $s0, $0, $v1
    jal ts
    add     $a1, $0, $s0
    add     $t5, $0, $a1
    jal ts
    add     $t6, $0, $t5
    jal ts
    addi    $s0, $0, 1
    add     $v0, $0, $s0
    jal ts
    add     $a0, $0, $t6
    jal ts
    syscall
    addi    $t7, $t7, -1
    beq     $t7, $0, done
    j task1body
    
done:
    
    addi    $v0, $0, 10
    syscall
    
ts: 
    
    addi    $sp, $sp, -4
    sw      $a0, 0($sp)     #storing $a0 on the stack, freeing it up
    
    la      $a0, tid
    lw      $a0, 0($a0)
    
    bne     $a0, $0, switchToTaskOne
    
    # tid was zero          ##
    
    la      $a0, tcb0       #load tcb0 for task 0
    
    sw      $v0,   0($a0)
    sw      $v1,   4($a0)   #skipping a0, it's being used for the tcb
    sw      $a1,  12($a0)
    sw      $a2,  16($a0)
    sw      $a3,  20($a0)
    sw      $t0,  24($a0)
    sw      $t1,  28($a0)
    sw      $t2,  32($a0)
    sw      $t3,  36($a0)
    sw      $t4,  40($a0)
    sw      $t5,  44($a0)
    sw      $t6,  48($a0)
    sw      $t7,  52($a0)
    sw      $t8,  56($a0)
    sw      $t9,  60($a0)
    sw      $s0,  64($a0)
    sw      $s1,  68($a0)
    sw      $s2,  72($a0)
    sw      $s3,  76($a0)
    sw      $s4,  80($a0)
    sw      $s5,  84($a0)
    sw      $s6,  88($a0)
    sw      $s7,  92($a0)
    sw      $s8,  96($a0)
    sw      $k0, 100($a0)
    sw      $k1, 104($a0)
    sw      $gp, 108($a0)
    sw      $sp, 112($a0)
    sw      $ra, 116($a0)
    
    lw      $v0,   0($sp)
    sw      $v0,   8($a0)
    
    addi    $sp, $sp, 4
    
    # done saving           ##
    
    la      $a0, tid
    addi    $a1, $0, 1
    sw      $a0, 0($a1)
    
    la      $a0, tcb1       #load tcb1 for task 1
    
    lw      $v0,   0($a0)
    lw      $v1,   4($a0)
    lw      $a1,  12($a0)
    lw      $a2,  16($a0)
    lw      $a3,  20($a0)
    lw      $t0,  24($a0)
    lw      $t1,  28($a0)
    lw      $t2,  32($a0)
    lw      $t3,  36($a0)
    lw      $t4,  40($a0)
    lw      $t5,  44($a0)
    lw      $t6,  48($a0)
    lw      $t7,  52($a0)
    lw      $t8,  56($a0)
    lw      $t9,  60($a0)
    lw      $s0,  64($a0)
    lw      $s1,  68($a0)
    lw      $s2,  72($a0)
    lw      $s3,  76($a0)
    lw      $s4,  80($a0)
    lw      $s5,  84($a0)
    lw      $s6,  88($a0)
    lw      $s7,  92($a0)
    lw      $s8,  96($a0)
    lw      $k0, 100($a0)
    lw      $k1, 104($a0)
    lw      $gp, 108($a0)
    lw      $sp, 112($a0)
    lw      $ra, 116($a0)
    
    lw      $a0,   8($a0)
    
    # done loading          ##
    
    jr $ra
    
switchToTaskOne:
    
    # tid was one           ##
    
    la      $a0, tcb1       #load tcb1 for task 1
    
    sw      $v0,   0($a0)
    sw      $v1,   4($a0)
    sw      $a1,  12($a0)
    sw      $a2,  16($a0)
    sw      $a3,  20($a0)
    sw      $t0,  24($a0)
    sw      $t1,  28($a0)
    sw      $t2,  32($a0)
    sw      $t3,  36($a0)
    sw      $t4,  40($a0)
    sw      $t5,  44($a0)
    sw      $t6,  48($a0)
    sw      $t7,  52($a0)
    sw      $t8,  56($a0)
    sw      $t9,  60($a0)
    sw      $s0,  64($a0)
    sw      $s1,  68($a0)
    sw      $s2,  72($a0)
    sw      $s3,  76($a0)
    sw      $s4,  80($a0)
    sw      $s5,  84($a0)
    sw      $s6,  88($a0)
    sw      $s7,  92($a0)
    sw      $s8,  96($a0)
    sw      $k0, 100($a0)
    sw      $k1, 104($a0)
    sw      $gp, 108($a0)
    sw      $sp, 112($a0)
    sw      $ra, 116($a0)
    
    lw      $v0,   0($sp)
    sw      $v0,   8($a0)
    
    addi    $sp, $sp, 4
    
    # done saving           ##
    
    la      $a0, tid
    addi    $a0, $0, 0
    
    la      $a0, tcb0       #load tcb0 for task 0
    
    lw      $v0,   0($a0)
    lw      $v1,   4($a0)
    lw      $a1,  12($a0)
    lw      $a2,  16($a0)
    lw      $a3,  20($a0)
    lw      $t0,  24($a0)
    lw      $t1,  28($a0)
    lw      $t2,  32($a0)
    lw      $t3,  36($a0)
    lw      $t4,  40($a0)
    lw      $t5,  44($a0)
    lw      $t6,  48($a0)
    lw      $t7,  52($a0)
    lw      $t8,  56($a0)
    lw      $t9,  60($a0)
    lw      $s0,  64($a0)
    lw      $s1,  68($a0)
    lw      $s2,  72($a0)
    lw      $s3,  76($a0)
    lw      $s4,  80($a0)
    lw      $s5,  84($a0)
    lw      $s6,  88($a0)
    lw      $s7,  92($a0)
    lw      $s8,  96($a0)
    lw      $k0, 100($a0)
    lw      $k1, 104($a0)
    lw      $gp, 108($a0)
    lw      $sp, 112($a0)
    lw      $ra, 116($a0)
    
    lw      $a0,   8($a0)
    
    # done loading          ##
    
    jr $ra