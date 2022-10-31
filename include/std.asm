global exit

section .text
; void exit(qword code)
exit:
    mov rax, 60
    syscall
