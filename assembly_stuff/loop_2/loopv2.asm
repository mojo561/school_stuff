global	main
	extern	printf
	extern putchar
	section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;prolog
	mov	rsi, str
strlen:				;compute length of C string loaded in RSI
	mov	rdi, [rsi + rcx];get char at *(str + RCX)
	cmp	rdi, 0x0	;we're done if char is NULL
	je	nelrts		;
	inc	rcx		;keep track of total char count in RCX
	jmp	strlen
nelrts:
	mov	[len], rcx	;update len with whatever is in RCX
	mov	rcx, [i]	;update RCX with value of *i
loop:
	mov	r8, [len]	;stick updated len value into R8
	cmp	rcx, r8		;we're done if counter equals str len
	je	endloop		;
	mov	rdi, [str + rcx];get a single char from str
	call	putchar		;then print it
	mov	rcx, [i]	;update counter
	inc	rcx		;
	mov	[i], rcx	;
	jmp	loop
endloop:
	mov	rax, 0		;epilog
	leave			;epilog
	ret			;epilog
	section	.data
str:	db "Hey", 0xA, 0
len:	dd 0
i:	db 0
