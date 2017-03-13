;Using extern C functions...
;Compile: nasm -f elf64 hello.asm
;Link: gcc hello.o
;Execute: ./a.out

global	main
	extern	puts		;import puts function
section	.text			;begin text section
main:				;need main because C is picky
	mov	rdi, message	;first integer (or pointer) argument in rdi
	call	puts		;puts(message)
	ret			;return from main back into C library wrapper
message: db "Hello World", 0	;since we're using C, append 0 to string (terminator)
