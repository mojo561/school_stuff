;adapted from: http://www.linuxdevcenter.com/pub/a/linux/2006/05/18/how-shellcodes-work.html?page=3
;use execve (sys_execve: http://syscalls.kernelgrok.com) to run /bin/sh -c date
; (not quite suitable for shellcode, needs tweaking)
	;mov	eax, 0x46	;what does this do?
	xor	ebx, ebx
	xor	ecx, ecx
	int	0x80
	jmp	str
prog:
	pop	ebx
	xor	eax, eax
	mov	al, 0x0B
	xor	edx, edx
	push	edx
	push	ebx
	mov	ecx, esp
	int	0x80
str:
	call	prog
	msg	db "/bin/sh -c date", 0
