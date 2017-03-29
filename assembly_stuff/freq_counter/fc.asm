;RDI, RSI, RDX, RCX, R8, R9
;read a string from the console
;for each letter in the alphabet, print a frequency count of the number of times that each letter was present (case insensitive) in the input string
;ASCII 65 = A, 97 = a.
;need int array a with 26 elements (for each letter in the alphabet)
;loop through the input string
;  check if char c at index i is in the alphabet (65 <= c <= 90 OR 97 <= c <= 122)
;  Mod each char by 65 and 97. check if remainder is < 26
;  if remainder r < 26, ++a[r]
;loop through a
;  if a[i] != 0
;    print "a[i]+65: a[i]"
global main
	extern	fgets
	extern	puts
	extern	printf
	extern	stdin
	section .text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;

	mov	rdi, prompt
	call	puts

	mov	rdi, buffer
	mov	rsi, [maxlen]
	mov	rdx, [stdin]	;can't just mov 0 into rdx, need extern address of stdin
	call	fgets
	xor	rcx, rcx
getlen:
	xor	rdi, rdi
	mov	dil, [buffer + rcx]
	cmp	rdi, 0x0
	je	nelteg
	inc	rcx
	jmp	getlen
nelteg:
	mov	[strlen], rcx
	xor	rcx, rcx
getfrq:
	cmp	rcx, [strlen]
	je	qrfteg
	xor	rdx, rdx	;
	xor	rax, rax	;clear these out (required before every div instruction)
	xor	rbx, rbx	;
	mov	rdi, frqarr
	mov	al, byte [buffer + rcx]
	mov	bx, 97		;ASCII 'a'
	div	bx
	cmp	dx, 26		;is the remainder of 'a'/(char) < 26?
	jl	lower
	xor	rdx, rdx
	mov	al, byte [buffer + rcx]
	mov	bx, 65		;ASCII 'A'
	div	bx
	cmp	dx, 26		;is the remainder of 'A'/(char) < 26?
	jl	lower
	jmp	next
lower:
	cmp	rax, 0	;is the quotient 0? (if it is, character is too low to be alphabetic)
	je	next
	inc	qword [frqarr + rdx*8]	;frqarr is an array of qwords (8 bytes). update frqarr at index [rdx]
	jmp	next
next:
	inc	rcx
	jmp	getfrq
qrfteg:
	xor	rcx, rcx
frqloop:
	cmp	rcx, 26
	je	poolqrf
	mov	rdx, qword [frqarr + rcx*8]
	cmp	rdx, 0
	je	skip
	mov	rdi, fmt
	mov	rsi, 65
	add	rsi, rcx
	call	printf
skip:
	mov	rcx, [i]
	inc	rcx
	mov	[i], rcx
	jmp	frqloop
poolqrf:
	mov	rax, 0		;epilog
	leave			;
	ret			;
	section .data
buffer:	times 256 db 0
fmt:	db "%c: %d",0xA, 0
prompt: db "Enter a string less than 256 characters:", 0
frqarr:	times 26 dq 0
maxlen:	dq 255
strlen:	dq 0
i:	dq 0
