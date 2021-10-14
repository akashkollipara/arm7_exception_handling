	AREA	text_0, code, readonly
	ENTRY
vectors
	IMPORT	reset_handler
	b	reset_handler
	b	undef_handler
	b	swi_handler
	b	pfa_handler
	b	da_handler
	b	.		; Reserved
	b	irq_handler
	b	fiq_handler

;================ END OF VECTORS ================;

	IMPORT	isr
undef_handler
	stmfd	sp!, {r0-r12, r14}
	mov	r0, #0x01		; mov vector ID to 1st arg register
	mov	r1, lr
	bl	isr
	ldmfd	sp!, {r0-r12, r14}
	movs	pc, r14
	
swi_handler
	stmfd	sp!, {r0-r12, r14}
	mov	r0, #0x02
	bl	isr
	ldmfd	sp!, {r0-r12, r14}
	movs	pc, r14

pfa_handler
	stmfd	sp!, {r0-r12, r14}
	mov	r0, #0x03
	bl	isr
	ldmfd	sp!, {r0-r12, r14}
	ldr	r14, =reset_handler
	subs	pc, r14, #0x04

da_handler
	stmfd	sp!, {r0-r12, r14}
	mov	r0, #0x04
	bl	isr
	ldmfd	sp!, {r0-r12, r14}
	subs	pc, r14, #0x08

irq_handler
	stmfd	sp!, {r0-r12, r14}
	mov	r0, #0x06
	bl	isr
	ldmfd	sp!, {r0-r12, r14}
	subs	pc, r14, #0x04

fiq_handler
	stmfd	sp!, {r0-r7, r14}
	mov	r0, #0x07
	bl	isr
	ldmfd	sp!, {r0-r7, r14}
	subs	pc, r14, #0x04

;================ END OF HANDLERS ================;
	END