.global _start
.section .data
    val1: .word 10000  // 0x2710
    //val2: .word 10000  // 0x2710


.section .text
_start:
    LDR x0, =val1
    LDR x1, [x0]
    LDR x2, [x0]
    MOV x3, x2, LSL #3


    MOV x8, #93
    MOV x0, #0x0
    SVC #0x0
