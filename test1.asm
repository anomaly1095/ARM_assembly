.global _start
.section .data
    val1: .byte 100
    val2: .byte 27
.section .text

_start:
        ldr x0, =val1
        ldr x1, =val2
        adr x2, val1
        adr x3, val2
        ldr x4, [x2]
        ldr x5, [x3]

        //exit program
        mov x8, #93
        mov x0, 0x0
        svc 0x0
