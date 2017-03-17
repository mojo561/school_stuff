global	main
	extern	printf
	extern putchar
	section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;
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
	xor	rdx, rdx	;zero out rdx
	mov	dl, [len]	;store len in lowest 8 bits of rdx
	cmp	cx, dx		;we're done if counter equals str len
	je	endloop		;

	xor	rdi, rdi
	mov	dil, [str + rcx];get a single char from str
	call	putchar		;then print it

	xor	rcx, rcx
	mov	cx, [i]		;update counter
	inc	cx		;
	mov	[i], rcx	;
	jmp	loop
endloop:
	mov	rax, 0		;epilog
	leave			;
	ret			;
	section	.data
len:	db 0
foo:	times 15 db 0 ; padding...
str:	db "Hey! This works for verry long strings up to 256 chars...", 0xA, 0
i:	dq 0
