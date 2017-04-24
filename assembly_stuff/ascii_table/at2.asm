;RDI, RSI, RDX, RCX, R8, R9
;For the integer values 0-255, print the following table:
;<decimal value><tab><hex value><tab><ascii value>
global	main
	extern	printf
	section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;
	mov	rcx, [i]
loop:
	cmp	rcx, 255
	jg	end

	mov	rdi, fmt
	mov	rsi, [i]
	mov	rdx, rsi
	mov	rcx, rdx
	call	printf

	mov	rcx, [i]
	inc	rcx
	mov	[i], rcx
	jmp	loop
end:
	mov	rax, 0		;
	leave			;epilog
	ret			;
	section	.data
fmt:		db "%d", 9, "%#x", 9, "%c", 10, 0
i:		db 0
