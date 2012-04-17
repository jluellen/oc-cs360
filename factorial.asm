        .text
        .globl main
main:   
        subu    $sp, $sp, 32            # 32-byte stack frame
        sw      $ra, 20($sp)            # save return address
        sw      $fp, 16($sp)            # save frame pointer
        addu    $fp, $sp, 32            # set new frame pointer
        
START:  
        la      $a0, str_1              # system call to print str_1  
        li      $v0, 4                 
        syscall         

        li      $v0, 5                  # system call to read an integer
        syscall

        beq     $v0, $0, EXIT           # check if integer > 0


        move    $a0, $v0                # $v0 keeps the input value
        jal     FACT                    # call fact(), ra <- next PC
        la      $a1, result             # result is stored in $v0
        sw      $v0, 0($a1)             # store the value into memory


        la      $a0, str_2              # system call to print str_2
        li      $v0, 4                  # call number 4
        syscall
                                            
        la      $a1, result             # read the value from memory
        lw      $a0, 0($a1)             # move fact result to $a0
        li      $v0, 1                  # print the result
        syscall
        la      $a0, str_3
        li      $v0, 4                  # system call to print str_3
        syscall
        j       START

EXIT:   

        la      $a0, str_3
        li      $v0, 4                  # system call to print str_3
        syscall
        
        lw      $ra, 20($sp)            # restore return address
        lw      $fp, 16($sp)            # restore frame pointer
        addu    $sp, $sp, 32            # adjust stack pointer
        jr      $ra                     # return to caller 'main'
        jr      $ra
        
FACT:   
        subu    $sp, $sp, 32            # 32-byte stack frame
        sw      $ra, 20($sp)            # save return address
        sw      $fp, 16($sp)            # save frame pointer
        addu    $fp, $sp, 32            # set up a new frame pointer    
        sw      $a0, 0($fp)             # save fact(n) function argument n
        
        lw      $2, 0($fp)              # read fact(n) function argument n
        bgtz    $2, Loop2               # branch if n>0
        li      $2, 1                   # fact(0) = 1
        j       Loop1

Loop2:  lw      $3, 0($fp)              # read fact(n) function argument n
        subu    $2, $3, 1               # n <- n-1
        move    $a0, $2         
        jal     FACT

        lw      $3, 0($fp)              # read fact(n) function argument n
        mul     $2, $2, $3              # compute fact(n-1)*n

Loop1:  lw      $ra, 20($sp)
        lw      $fp, 16($sp)
        addu    $sp, $sp, 32
        jr      $ra

        .data
str_1:  .asciiz "Enter the number for factorial(0 to exit) => "
str_2:  .asciiz "The factorial result is  "
str_3:  .asciiz "\n"
        
        .align 2
result: .space 4

