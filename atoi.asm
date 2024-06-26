/**
	*			atoi()
 	*/
	.syntax unified
	.cpu cortex-m4
	.fpu fpv4-sp-d16
	.thumb

	.section .text.main, "ax", %progbits
_start:
	LDR 	r0, =buff
	MOV 	r2, #0				@ result
	MOV 	r3, #1				@ digit coefficient
	MOV 	r4, #0				@ len (contain number of digits)
	MOV 	r10, #10			@ coeff multiplier
	LDRB 	r1, [r0] 			@ load first char
	CMP 	r1, #0x2D	
	BEQ 	calc_neg			@ first char is "-"

calc_pos:
	BL		loop_buff   	@ check character validity
loop_pos:
	SUBS 	r4, r4, #1
	BMI		_exit					@ exit if out of range
	SUB 	r0, r0, #0x01	@ decrement address
	LDRB 	r1, [r0]			@ load char value
	SUB 	r1, r1, #0x30	@ convert ASCII to digit
	CMP 	r1, #0				@ check if zero
	IT	EQ
	MULEQ r3, r3, r10		@ mult coeff by ten
	BEQ 	loop_pos

	MUL 	r1, r1, r3		@ if not zero we mult the val with coeff
	ADD		r2, r2, r1		@ then add the val to result
	MUL		r3, r3, r10		@ and mult coeff by 10
	B			loop_pos

calc_neg:
	ADD		r0, r0, #1		@ go to char after '-'
	BL		loop_buff			@ check character validity
loop_neg:
	SUBS 	r4, r4, #1
	IT	MI
	RSBSMI r2, r2, #0			@ Negate the result 
	BMI		_exit					@ exit if out of range
	SUB 	r0, r0, #0x01	@ decrement address
	LDRB 	r1, [r0]			@ load char value
	SUB 	r1, r1, #0x30	@ convert ASCII to digit
	CMP 	r1, #0				@ check if zero
	IT	EQ
	MULEQ r3, r3, r10		@ mult coeff by ten
	BEQ 	loop_neg

	MUL 	r1, r1, r3		@ if not zero we mult the val with coeff
	ADD		r2, r2, r1		@ then add the val to result
	MUL		r3, r3, r10		@ and mult coeff by 10
	B			loop_neg

_exit:
	B .

loop_buff:
	LDRB 	r1, [r0], #0x01
check_char:
	CMP 	r1, #0x0		@ EOL found
	IT	EQ
	BXEQ	lr					@ return
	ADD		r4, r4, #1	@ not EOL we add 1 to length
	CMP 	r1, #0x30
	BLT		_exit
	CMP 	r1, #0x39
	BGT		_exit
	B			loop_buff


	.section .rodata, "a", %progbits
	.type buff, %object 
buff:
	.asciz "-189"
	.size buff, .-buff
