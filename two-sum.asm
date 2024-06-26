  .syntax unified
  .cpu cortex-m4
  .fpu fpv4-sp-d16 
  .thumb 

  .section .text, "ax", %progbits 
  .type _start, %function
_start:
  BL    _systick_config
  LDR   r0, =nums
  LDR   r0, [r0]          @ address of first word in array
  LDR   r1, =target
  LDR   r2, =SYST_CVR     @ current timer value
  LDR   r3, =num_elements @ current number of elements
  LDR   r4, =num_elements @ total number of elements
  LDR   r5, =num_range    @ range of values
  LDR   r6, =num_min      @ minimum value
  BL    _fill_buffer

  LDR   r0, =nums
  LDR   r0, [r0]

loop1:
  LDR   r1, [r0], #0x04 @ first item
loop2:
  CMP   r1, 
  LDR   r2, [r0], #0x04 @ first item





_exit:
  B .

_systick_config:
  @ counter reset val
  LDR   r0, =SYST_RVR
  MOVW  r4, #0xFFFF
  MOVT  r4, #0xFF
  STR   r4, [r0]
  @ enable systick 
  LDR   r0, =SYST_CSR
  MOV   r4, #0b101
  STR   r4, [r0]
  BX    lr

_fill_buffer:
  CMP   r3, r4
  BXEQ  lr
_generate_val:
  LDR   r7, [r2]      @ value of systick
  @ systick modulo range
  UDIV  r8, r7, r5    @ div systick by range
  MUL   r8, r8, r5    @ multiply range by div result
  SUB   r8, r7, r8    @ sub res from systick
  @ sub min to get random num
  SUB   r8, r8, r6
  @ save result in memory and decrement number of values left 
  STR   r8, [r0], #0x04  @ load the generate value in SRAM
  SUB   r3, r3, #1    @ decrement num of elements left
  B _fill_buffer


@---------------------------------

  .section .data, "aw", %progbits

  .equ target, 69 @ TARGET NUMBER
  .equ SYST_CSR, 0xE000E010   @ SYSTICK control/status reg
  .equ SYST_RVR, 0xE000E014   @ SYSTICK reload reg
  .equ SYST_CVR, 0xE000E018   @ SYSTICK current val reg
  .equ SYST_CALIB, 0xE000E01C @ SYSTICK calibration reg
  .equ num_elements, 0x100
  .equ num_range, 0x187 
  .equ num_min, 0xA 

@---------------------------------

  .section .bss, "a", %nobits
  .type buffer, %object
nums:
  .space 0x100  @ NUMBERS
  .space 0x10   @ RESULTS
@---------------------------------

