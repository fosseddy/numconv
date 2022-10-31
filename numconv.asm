global _start
extern print
extern exit

section .data
    STDOUT equ 1

    msg db "hello, world", 10, 0

section .text
_start:
    mov rdi, STDOUT
    mov rsi, msg
    call print

    mov rdi, 0
    call exit
