        .section .data
            val:    .byte 0x3A

        .section .text
        .global _start
        _start:
            adr x1, val
            ldr x1, [x1]


            //exit the program
            mov x8, 0x5D
            mov x0, 0
            svc 0
