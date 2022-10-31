global print
extern strlen

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
