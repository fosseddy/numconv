global print, println
global STDIN, STDOUT, STDERR
extern strlen

section .data
    STDIN equ 0
    STDOUT equ 1
    STDERR equ 2

    new_line db 10, 0

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

; void println(qword fd, byte *s)
println:
    call print

    mov rsi, new_line
    call print

    ret
