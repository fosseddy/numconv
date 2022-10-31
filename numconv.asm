global _start
extern print, STDERR
extern exit

section .data
    LF   equ 10
    NULL equ 0

    usage_msg db "Usage: numconv [OPTION] [VALUE]", LF
              db "Converts VALUE specified by OPTION into binary, decimal, "
              db "hex, octal", LF
              db LF
              db "OPTION", LF
              db "  -b binary", LF
              db "  -d decimal", LF
              db "  -h hex", LF
              db "  -o octal", LF, NULL

section .bss
    argc resq 1
    argv resq 1

section .text
_start:
    pop qword [argc]
    pop qword [argv]

    cmp qword [argc], 2
    jl .args_error

    jmp .exit_success

.args_error:
    mov rdi, STDERR
    mov rsi, usage_msg
    call print
    mov rdi, 1
    call exit

.exit_success:
    mov rdi, 0
    call exit
