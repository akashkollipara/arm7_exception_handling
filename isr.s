	GLOBAL	isr
	AREA	text_2, code, readonly

isr
	cmp	r0, #0x1
	beq	undef_abort
	cmp	r0, #0x03
	beq	prefetch_abort
	cmp	r0, #0x04
	beq	data_abort
	bx	lr
	b	plat_panic
	
undef_abort
	sub	r1, r1, #0x04
	ldr	r0, [r1]
	b	arch_panic

prefetch_abort
	ldr	r5, =0x9faab047		; some dummy operation
	b	plat_panic		; go into panic

data_abort
	ldr	r5, =0xda7aab07		; some dummy operation
	bx	lr			; return
;================ END OF ISR ================;

arch_panic
	b	.

plat_panic
	mov r0, #0x3
panic
	subs	r0, r0, #0x1
	bne	panic
	bx	lr
;================ END OF PLAT_PANIC ================;
	END