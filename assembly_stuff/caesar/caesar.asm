;RDI, RSI, RDX, RCX, R8, R9
;Read a string of plaintext from the console
;Read a key from the console
;strip non-alphabetic chars
;convert all characters to UPPERCASE
;use the caesar cipher with the supplied key to encrypt the plaintext
;output the ciphertext in blocks of 4 characters separated by a space
global	main
	extern	puts
	extern	fgets
	extern	stdin
	extern	scanf
	extern	putchar
section	.text
main:
	push	rbp		;prolog
	mov	rbp, rsp	;

	mov	rdi, promptmsg
	call	puts

	mov	rdi, buffer
	mov	rsi, 255
	mov	rdx, [stdin]
	call	fgets

	mov	rdi, promptkey
	call	puts

	mov	rdi, fmt
	lea	rsi, [key]
	call	scanf
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;  strip non-alphabetic chars	;
;   and convert to uppercase	;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor	rcx, rcx
lbla:
	mov	al, byte [buffer + rcx]
	cmp	al, 10		;is al == 10 ('\n')?
	je	albl
	cmp	al, 65		;is al < 65 ('A')?
	jl	drop
	cmp	al, 122		;is al > 122 ('z')?
	jg	drop
	cmp	al, 90		;is al > 90 ('Z')?
	jg	uprconv
	jmp	next		;65 <= al <= 90
uprconv:
	cmp	al, 97		;is al < 97 ('a')?
	jl	drop
	sub	al, 32		;97 <= al <= 122
	mov	byte [buffer + rcx], al
	jmp	next
drop:
	mov	al, 32		;let's just fill in invalid chars with spaces
	mov	byte [buffer + rcx], al
next:
	inc	rcx
	jmp	lbla
albl:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;      do the encryption	;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	ecx, dword [i]
lblb:
	mov	al, byte [buffer + rcx]
	cmp	al, 10		;we're done if current char is \n (10)
	je	blbl
	cmp	al, 0		;we're done if current char is 0 (not likely?)
	je	blbl
	cmp	al, 32		;continue to next char if current is space (32)
	je	skp
	mov	eax, dword [c]
	cmp	eax, 0		;don't do division unless c != 0
	je	prnt
	xor	rdx, rdx	;
	mov	r8, 4		;
	div	r8		;
	cmp	rdx, 0		;
	jne	prnt		;
	mov	rdi, 32		;
	call	putchar		;prnt space if c % 4 == 0
prnt:
	xor	rdi, rdi
	mov	ecx, dword [i]
	mov	dil, byte [buffer + rcx]
	mov	eax, dword [key];
	add	edi, eax	;
	sub	edi, 65		;normalize char (0-25 : A-Z)
	cmp	edi, 26		;do we have to do any division?
	jl	good		;
	mov	r8, 26		;
	xor	rdx, rdx	;
	mov	rax, rdi	;
	div	r8		;
	mov	rdi, rdx	;store remainder in rdi
good:				;
	add	rdi, 65		;shift by key mod 26
	call	putchar
	mov	ecx, dword [c]
	inc	rcx
	mov	[c], ecx
skp:
	xor	rcx, rcx
	mov	ecx, dword [i]
	inc	rcx
	mov	[i], ecx
	jmp	lblb
blbl:
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov	rdi, 10
	call	putchar
	mov	eax, 0		;epilog
	leave			;
	ret			;
section	.data
buffer:	times 256 db 0
promptmsg: db "Enter a message (max 255 chars):", 0
promptkey: db "Enter the encryption key:", 0
fmt:	db "%d", 0
;now everything must be padded to quadwords (8 bytes)...
key:	dw 0		;4 bytes
pad1:	times 4 db 0	;+4 bytes = 8 bytes
i:	dw 0		;4 bytes
pad2:	times 4 db 0	;+4 bytes = 8 bytes
c:	dw 0		;4 bytes
pad3:	times 4 db 0	;+4 bytes = 8 bytes (to be safe(?))
