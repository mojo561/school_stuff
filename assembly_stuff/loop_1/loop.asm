;RDI, RSI, RDX, RCX, R8, R9
;count from n-1 to 0 using C's printf function
	section	.text
global	main
	extern printf
main:
	push	rbp		;prolog
	mov	rbp, rsp	;prolog
loop:
	mov	rsi, [n]	;stick n into $rsi
	cmp	rsi, 0x0	;check if $rsi contains 0
	je	endloop		;if yes: jump out of loop
	mov	rdi, ifmt	;else, move fmt into $rdi (required... printf will blow away $rdi after it's called)
	dec	rsi		;decrement value in $rsi
	mov	[n], rsi	;move value of $rsi back to memory
	call	printf		;call the function
	jmp	loop		;repeat
endloop:
	mov	rax, 0x0	;epilog
	leave			;epilog
	ret			;epilog
	section	.data
ifmt:	db "%d", 10, 0
n:	db 5
