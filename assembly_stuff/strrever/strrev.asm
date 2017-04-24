;RDI, RSI, RDX, RCX, R8, R9
;Reads a series of characters typed at the console
;Input should be terminated when the user types a $ symbol
;Non-letter characters should be discarded (only keep a-z A-Z)
;All characters should be converted to UPPERCASE
;Print the given characters, in reverse order, on a single new line.
global	main
	extern	puts
	extern	getchar
	extern	putchar
	section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;

	mov	rax, 36		;bottom of the stack: terminating char
	push	rax

	mov	rdi, prompt
	call	puts
loop:
	call	getchar		;stores char in rax
	cmp	rax, 36		;we're done if rax contains 36 ('$')
	je	pool

	cmp	rax, 65		;is rax >= 65 ('A')?
	jl	skip		;discard if false
	cmp	rax, 90		;is rax <= 90 ('Z')?
	jl	good		;keep if good, continue checks if false
	cmp	rax, 97		;is rax >= 97 ('a')?
	jl	skip		;discard if false
	cmp	rax, 122	;is rax <= 122 ('z')?
	jg	skip		;discard if false, else continue
good:
	push	rax
skip:
	jmp	loop
pool:
	pop	rax
	cmp	rax, 36
	je	end
	cmp	rax, 90
	jl	next
	;ASCII: difference between A and a is 32
	;therefore if we sub 32 from 97 ('a'), we get 65 ('A')
	;same goes for the other lowercase letters
	sub	rax, 32
next:
	mov	rdi, rax
	call	putchar
	mov	rdi, 10
	call	putchar
	jmp	pool
end:
	mov	rax, 0		;epilog
	leave			;
	ret			;
	section	.data
prompt:	db "Enter a sequence of alphabetic characters, ending with a '$':", 0
