global atoi
extern strlen

section .data
    NULL equ 0

section .text
; qword atoi(qword *dest, byte *str)
atoi:
    push r12

    push rdi
    mov rdi, rsi
    call strlen
    mov r12, rax
    pop rdi

    mov rax, 1
    mov qword [rdi], 0
    mov rcx, 0
    mov r8, 0

    cmp byte [rsi], "+"
    jne .no_plus_sign

    mov r8, 1
    inc rcx
    dec r12
.no_plus_sign:
    cmp byte [rsi], "-"
    jne .no_minus_sign

    mov r8, 1
    mov r9, 1
    inc rcx
    dec r12
.no_minus_sign:
    jmp .loop_test
.loop:
    xor rdx, rdx
    mov dl, [rsi+rcx]

    cmp dl, "0"
    jl .not_a_num
    cmp dl, "9"
    jg .not_a_num

    sub dl, "0"

    mov r10, r12
    dec r10
    sub r10, rcx
    add r10, r8
    jmp .loop_2_test
.loop_2:
    imul rdx, rdx, 10
    dec r10
.loop_2_test:
    cmp r10, 0
    jg .loop_2

    add [rdi], rdx
    inc rcx
.loop_test:
    cmp byte [rsi+rcx], NULL
    jne .loop

    cmp r9, 1
    jne .not_negative

    neg qword [rdi]
.not_negative:
    jmp .exit
.not_a_num:
    mov rax, 0
.exit:
    pop r12
    ret
