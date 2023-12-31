bits 64

section .note.GNU-stack

section .text
    global ft_strcpy

; char *ft_strcpy(char *dst, const char *src);
ft_strcpy:
    xor rcx, rcx
    jmp loop

loop:
    cmp BYTE [rsi + rcx], 0
    je end_loop
    mov dl, [rsi + rcx]
    mov [rdi + rcx], dl
    inc rcx
    jmp loop

end_loop:
    mov BYTE [rdi + rcx], 0
    mov rax, rdi
    ret