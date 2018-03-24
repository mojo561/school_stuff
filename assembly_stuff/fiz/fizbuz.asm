;RDI, RSI, RDX, RCX, R8, R9
;https://soliduscode.blogspot.ca/2012/04/creating-local-variables-in-assembly.html
global main
	extern printf
	extern putchar
section .text
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;	_myfunc	- checks if value stored in the rdi register is divisible by 3, 5, or both 3 and 5
;		- if rdi is divisible only by 3, print 'fiz'
;		- if rdi is divisible only by 5, print 'buz'
;		- if rdi is divisible by 3 and 5, print 'fizbuz'
;		- otherwise, just print the number
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
global _myfunc
_myfunc:
	push	rbp			;prolog - create stack frame for this function
	mov	rbp, rsp		;

	sub	rsp, 0x10		;reserve 16 bytes of space on the stack
	mov	DWORD [rbp-0x4], edi	;store arg1 in the stack (truncated)

	mov	rdx, 0			;
	mov	eax, DWORD [rbp-0x4]	;
	mov	rbx, 3			;
	div	rbx			;
	mov	DWORD [rbp-0x8], edx	;divide arg1 by 3, store remainder on stack (truncated)

	mov	rdx, 0			;
	mov	eax, DWORD [rbp-0x4]	;
	mov	rbx, 5			;
	div	rbx			;
	mov	DWORD [rbp-0xC], edx	;divide arg1 by 5, store remainder on stack (truncated)

	cmp	DWORD [rbp-0x8], 0	;is arg1 divisible by 3?
	jg	ca			;if not, check if divisible by 5
	mov	rdi, fmt1		;else if arg1 divisible by 3, then print 'fiz'
	mov	rsi, msg1		;
	call	printf			;
ca:
	cmp	DWORD [rbp-0xC], 0	;is arg1 divisible by 5?
	jg	cb			;if not, jump to further tests...
	mov	rdi, fmt1		;else if arg1 divisible by 5, then print 'buz'
	mov	rsi, msg2		;
	call	printf			;
cb:
	;this probably needs optimization, these tests were done already... Just checking first if arg1 is not divisible by either number first.
	cmp	DWORD [rbp-0x8], 0
	je	cc
	cmp	DWORD [rbp-0xC], 0
	je	cc
	mov	rdi, fmt2		;if arg1 isn't divisible by either 3 or 5, print arg1
	mov	esi, DWORD [rbp-0x4]	;
	call	printf			;
cc:
	mov	rdi, 0xA		;print newline
	call	putchar			;

	leave				; destroy stack frame, then return (epilog)
	ret				;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
main:
	push	rbp
	mov	rbp, rsp
loop:
	mov	rcx, [i]
	cmp	rcx, 100
	je	endlbl
	inc	rcx
	mov	[i], rcx

	mov	rdi, rcx
	call	_myfunc

	jmp	loop
endlbl:
	mov	eax, 0
	leave
	ret
section .data
fmt1:	db "%s", 0
fmt2:	db "%d", 0
msg1:	db "fiz", 0
msg2:	db "buz", 0
i:	db 0
