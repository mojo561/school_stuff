;Compile: nasm -f elf64 hello.asm
;Link: ld hello.o
;Execute: ./a.out
global		_start			;main entry point
		section	.text		;begin text section

_start:
		mov	rax, 1		;system call (write())
		mov	rdi, 1		;file handle: stdout
		mov	rsi, message	;address of string to stdout
		mov	rdx, 13		;number of bytes (length of string)
		syscall			;invoke OS to do the write
		mov	eax, 60		;system call (exit)
		xor	rdi, rdi	;exit code (ie: return 0)
		syscall			;invoke OS to exit
message:	db "Hello World!", 10	;10 -> 0xA -> '\n'
