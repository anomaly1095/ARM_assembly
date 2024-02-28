.global _start

.section .data
    val: .quad 0xFFFFFFFF

.section .text

_start:
    MOV     x1, #0x7F
    MOV     x10, #10
    MOV     x11, #12
    LDR     x12, =val
    LDR     x12, [x12]
    ADD     x9, x11, x10
    SUB     x8, x11, x10
    SUBS    x7, x8, #2

                            // x1 into x0 if the comparison is true zero
    CMP     x8, #2
    CSEL    x0, x1, xzr, EQ

    MOV     x8, 0x5D
    MOV     x0, #0x0
    SVC     #0x0
