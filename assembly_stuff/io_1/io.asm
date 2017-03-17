;RDI, RSI, RDX, RCX, R8, R9
;read input using scanf, then print input using puts
;TODO: input validation
global main
	extern puts
	extern scanf
section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;

	mov	rsi, str	;str is a pointer to a char array, no need for lea here
	mov	rdi, ifmt
	call	scanf		;get a string from the user

	mov	rdi, str	;have to reload str from memory, else we'll print garbage
	call	puts

	mov	rax, 0		;epilog
	leave			;
	ret			;
section .data
str:	times 256 db 0
ifmt:	db "%s", 0
