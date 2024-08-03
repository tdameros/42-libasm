bits 64

extern __errno_location
extern ft_strlen
extern ft_strcpy
extern malloc

global ft_strdup

section .note.GNU-stack

section .text
; char *ft_strdup(const char *s1);
ft_strdup:
    call ft_strlen
    push rdi
    mov rdi, rax
    inc rdi
    call malloc wrt ..plt
    cmp rax, 0
    je malloc_error
    mov rdi, rax
    pop rsi
    call ft_strcpy
    ret

malloc_error:
    neg rax
    mov rbx, rax
    call __errno_location wrt ..plt
    mov [rax], rbx
    xor rax, rax
    ret
