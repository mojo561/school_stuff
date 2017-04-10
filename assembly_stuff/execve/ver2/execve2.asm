;execve v2: run /bin/sh -c date but using excessive stack magic
;adapted from: https://www.linuxquestions.org/questions/programming-9/assembly-for-execve-passing-args-896815/#post4440329
[bits 32]

	xor	eax, eax
	xor	ebx, ebx
	xor	ecx, ecx
	xor	edx, edx	;last argument (NULL)
	xor	esi, esi
	xor	edi, edi

	push	eax
	push	0x68732F6E	;hs/n
	push	0x69622F2F	;ib//
	mov	ebx, esp	;//bin/sh (arg 0)

	push	eax
	push	word 0x632D	;c-
	mov	esi, esp	;-c (arg 1)

	push	eax
	push	0x65746164	;etad
	mov	edi, esp

	push	eax		;NULL
	push	edi		;NULL, etad
	push	esi		;NULL, etad, -c
	push	ebx		;NULL, etad ,-c , hs/nib//
	mov	ecx, esp	;=> { "/bin/sh", "-c", "date", 0} ... somehow
	;have to do this crazy xor stuff so that objdump won't produce 0x00 byte sequences (shellcode)
	mov	eax, 0xFFFFFFF4	;2's compliment 11
	xor	eax, 0xFFFFFFFF	;xor to get 11
	int	0x80
