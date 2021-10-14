	GLOBAL	reset_handler
	AREA	text_1, code, readonly

reset_handler
	ldr	r0, =0xe01fc040		; configure memory map to use user flash_mode
	mov	r1, #0x1
	str	r1, [r0]
	
	ldr	r2, =0x40001000
	mov	sp, r2			; setup stack for supervisor mode
	mrs	r0, cpsr
	mov	r7, r0
	
	bic	r1, r0, #0x1f
	orr	r1, r1, #0x1b
	msr	cpsr_c, r1
	sub	r2, r2, #0x20
	mov	sp, r2			; setup stack for undef mode

	bic	r1, r0, #0x1f
	orr	r1, r1, #0x17
	msr	cpsr_c, r1
	sub	r2, r2, #0x20
	mov	sp, r2			; setup stack for abort mode (pf/data)

	bic	r1, r0, #0x1f
	orr	r1, r1, #0x12
	msr	cpsr_c, r1
	sub	r2, r2, #0x20
	mov	sp, r2			; setup stack for irq mode

	bic	r1, r0, #0x1f
	orr	r1, r1, #0x11
	msr	cpsr_c, r1
	sub	r2, r2, #0x20
	mov	sp, r2			; setup stack for fiq mode
	
	msr	cpsr_c, r0		; restore execution state

	IMPORT	engine
	bl	engine
	b	.

;================ END OF STACK ================;
	END