bits 64

global ft_strcmp

section .note.GNU-stack

section .text
; int ft_strcmp(const char *s1, const char *s2);
ft_strcmp:
    xor rax, rax
    xor rdx, rdx
    xor rcx, rcx
    jmp loop
loop:
    mov al, [rdi + rcx] ; *s1
    mov dl, [rsi + rcx] ; *s2
    cmp al, 0
    je end_loop
    cmp al, dl
    jne end_loop
    inc rcx
    jmp loop
end_loop:
    sub rax, rdx
    ret