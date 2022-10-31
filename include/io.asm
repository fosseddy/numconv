global print
global STDIN, STDOUT, STDERR
extern strlen

section .data
    STDIN  equ 0
    STDOUT equ 1
    STDERR equ 2

section .text
; void print(qword fd, byte *s)
print:
    push rdi
    mov rdi, rsi
    call strlen
    pop rdi

    mov r10, rax
    mov rax, 1
    mov rdx, r10
    syscall

    ret
