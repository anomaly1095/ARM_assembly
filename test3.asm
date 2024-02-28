.global _start
.section .data
                val0: .quad 156
                val1: .quad 100

                str0: .asciz "Helloo from assembly\n"

.section .text

    _start: 
        LDR     x10, =val0      // load address of val0
        LDR     x11, [x10]      // load value in x11
        LDR     x12, =val1      // load address of val1
        LDR     x13, [x12]      // load value in x13
        ADDS    x20, x11, x13   // store sum in x20

                                // writing to stdout
        MOV     x0, #0x0        // file descriptor
        LDR     x1, =str0       // char *
        MOV     x2, #21         // size of buff
        MOV     x8, #0x40       // syscall number
        SVC     #0x0            // supervisor_call

                                //exit
        MOV     x8, #0x5D       // exit syscall
        MOV     x0, #0x0        // return 0 
        SVC     #0x0
