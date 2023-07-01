# Define an array of integers
.data
array: .word 5, 4, 2, 1, 3
newline: .asciiz "\n"
# Define constants for the array size and element size 
#mem5 stores len
len: .word  5
#reg [31:0] zero,s0,s1,s2,s3,s4,s5,s6,s7,t0,t1,t2,t3,t4,t5,t6,t7,t8,t9,a0,a1,a2,a3,v0,v1,sp,ra;
           #   1  2  3  4  5  6  7  8  9  10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 
# The main function
.text
.globl main
main:
  # Load the array size and element size into registers
  lw $t0, len#n
  la $s0,array
  add $t9,$zero,$zero
  li $t1, -1 #i=-1
  li $s1, 1
  sub $t2,$t0,$s1#n-1
j outer_loop



outer_loop:
    addi $t1,$t1,1#i++
    beq $t1,$t2,print #
    sub $t3,$t2,$t1#n-1-i
    add $t4,$zero,$zero#t4=j
    j inner_loop

inner_loop:
    beq $t4,$t3,outer_loop
    sll $t5,$t4,2#i*4
    addi $t6,$t5,4#(i+1)*4
    add $t5,$t5,$s0 #add[i]
    add $t6,$t6,$s0#add[i+1]
    lw $t7,0($t5)#val[i]
    lw $t8,0($t6)#val[i+1]
    bgt $t7,$t8,swap #val[i]
    addi $t4,$t4,1
j inner_loop

swap:
sw $t8,0($t5)
sw $t7,0($t6)
addi $t4,$t4,1
j inner_loop


print:
beq $t9,20,exit
   lw $a0,array($t9) 
   li  $v0, 1 # system call #1 - print int
    syscall # execute
    lw $a0,newline
    li  $v0, 11 # system call #1 - print int
    syscall # execute
    add $t9,$t9,4    # increment the $t0 register by 4 to move to the next index of the array
    j print            # jump back to the beginning of the loop to input the next array element

exit:
  # Exit the program
  li $v0, 10
  syscall
