global strlen

section .data
    NULL equ 0

section .text
; qword strlen(byte *s)
strlen:
    mov rax, 0
    jmp .loop_test
.loop:
    inc rax
.loop_test:
    cmp byte [rdi+rax], NULL
    jne .loop
    ret
