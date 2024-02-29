.global _start
.section .data
        succm: .asciz "Well Done!\n"
        errm: .asciz "Error!\n"
        val0: .quad 0b1010110110100001      // 44449
        val1: .quad 0b01
.section .text
        _start:
                MOV     x20, #0x1           // stdout file descriptor
                MOV     x21, #0x2           // stderr ......
                LDR     x22, =succm
                LDR     x23, =errm
                MOV     x24, #11
                MOV     x25, #7
                LDR     x3, =val0
                LDR     x3, [x3]
                MOV     x4, x3, LSR #1
                MOV     x5, x3, LSL #1      // x5 = |x3/2**1|
                MOV     x6, x3, ASR #1      // x6 = x3/2**1
                MOV     x7, x3, LSR #15
                LDR     x9, =val1
                LDR     x9, [x9]
                MOV     x10, x3, ROR #1
                // write stdout
                CMP     x7, #0x1
                CSEL    x0, x20, x21, EQ    // arg 0
                CSEL    x1, x22, x23, EQ    // arg 1
                CSEL    x2, x24, x25, EQ    // arg 2
                MOV     x8, #0x40           // syscall code
                SVC     #0x0

                //exit
                MOV     x8, #0x5D
                MOV     x0, #0x0
                SVC     #0x0
