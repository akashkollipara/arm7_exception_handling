	GLOBAL	engine
	AREA	text_3, code, readonly

engine
	swi	0x01			; uncomment for swi exception
	;ldr	r0, =0x7fffc		; simulate data abort
	;ldmia	r0!, {r1-r3}		; uncomment for data abort
	FILL	4, 0x11223344, 4	; uncomment for undef abort
	;add	r0, pc, #0xfc		; -\ uncomment
	;bx	r0			; -/ both for prefetch abort
	bx	lr

;================ END OF ENGINE ================;
	END