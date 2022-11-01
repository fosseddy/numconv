global strlen
global strrev

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

; void strrev(byte *s)
strrev:
    call strlen
    mov r8, rax

    cqo
    mov r11, 2
    div r11
    add rax, rdx
    mov r10, rax

    mov rcx, 0
    jmp .loop_test
.loop:
    mov al, [rdi+rcx]
    lea r9, [rdi+r8-1]
    sub r9, rcx
    mov bl, [r9]

    mov [rdi+rcx], bl
    mov [r9], al

    inc rcx
.loop_test:
    cmp rcx, r10
    jl .loop

    ret
