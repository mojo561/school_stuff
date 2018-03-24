;RDI, RSI, RDX, RCX, R8, R9
;simple example of xor decryption and printing a char without resorting to C's print functions
global _start
section .text
_start:
    push    rbp
    mov     rbp, rsp

    mov     rcx, 0xB
decr:
    mov     r8, 0
    mov     r8b, [encrypted + rcx]
    xor     r8b, 0x19
    mov     [char], r8b
    push    rcx

    mov     rax, 1
    mov     rdi, 1
    mov     rsi, char
    mov     rdx, 1
    syscall

    pop     rcx
    loop    decr

    mov     eax, 60
    mov     rdi, 0
    syscall
section .data align=16
char:   db 0
encrypted: db 0x71, 0x76, 0x6D, 0x74, 0x78, 0x70, 0x75, 0x37, 0x7A, 0x76, 0x74
