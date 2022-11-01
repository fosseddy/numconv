global _start

extern print, println, STDOUT, STDERR
extern exit
extern atoi
extern strrev

section .data
    LF equ 10
    NULL equ 0

    TRUE equ 1
    FALSE equ 0

    value dq 0

    err_num_msg db "VALUE is not a number", LF, NULL
    err_argc_msg db "Not enough arguments", LF, NULL

    usage_msg db "Usage: numconv [VALUE]", LF
              db "Converts signed int VALUE into binary, hex, octal", LF

section .bss
    argc resq 1
    argv resq 1

    binary_str resb 66
    octal_str resb 24

section .text
_start:
    pop rax
    dec rax
    cmp rax, 1
    jl .err_argc

    mov [argc], rax
    add rsp, 8
    pop qword [argv]

    mov rdi, value
    mov rsi, [argv]
    call atoi

    cmp rax, 1
    jne .err_num

    mov rdi, binary_str
    mov rsi, [value]
    call int64_to_binary

    mov rdi, STDOUT
    mov rsi, binary_str
    call println

    mov rdi, octal_str
    mov rsi, [value]
    call int64_to_octal

    mov rdi, STDOUT
    mov rsi, octal_str
    call println

    ; convert to hex

    jmp .exit_success

.err_argc:
    mov rdi, STDERR
    mov rsi, err_argc_msg
    call print
    jmp .print_usage

.err_num:
    mov rdi, STDERR
    mov rsi, err_num_msg
    call print
    jmp .print_usage

.print_usage:
    mov rdi, STDERR
    mov rsi, usage_msg
    call print
    jmp .exit_fail

.exit_fail:
    mov rdi, 1
    call exit

.exit_success:
    mov rdi, 0
    call exit

; void int64_to_binary(byte *dest, qword num)
int64_to_binary:
    mov rax, rsi
    mov rcx, 0
    mov r8, 2
    mov r9, FALSE

    cmp rax, 0
    jge .loop

    neg rax
    mov r9, TRUE
.loop:
    cqo
    idiv r8

    add dl, "0"
    mov [rdi+rcx], dl

    inc rcx

    cmp rax, 0
    jne .loop

    cmp r9, TRUE
    jne .not_negative

    mov byte [rdi+rcx], "-"
    inc rcx
.not_negative:
    mov byte [rdi+rcx], NULL
    call strrev

    ret

; void int64_to_octal(byte *dest, qword num)
int64_to_octal:
    mov rax, rsi
    mov rcx, 0
    mov r8, 8
    mov r9, FALSE

    cmp rax, 0
    jge .loop

    neg rax
    mov r9, TRUE
.loop:
    cqo
    idiv r8

    add dl, "0"
    mov [rdi+rcx], dl

    inc rcx

    cmp rax, 0
    jne .loop

    cmp r9, TRUE
    jne .not_negative

    mov byte [rdi+rcx], "-"
    inc rcx
.not_negative:
    mov byte [rdi+rcx], NULL
    call strrev

    ret
