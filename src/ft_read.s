bits 64

extern __errno_location

section .note.GNU-stack

section .text
    global ft_read

; ssize_t ft_read(int fd, void *buf, size_t count);
ft_read:
    xor rax, rax
    syscall
    test rax, rax
    js syscall_error
    ret

syscall_error:
    neg rax
    mov rdx, rax
    call __errno_location wrt ..plt
    mov [rax], rdx
    mov rax, -1
    ret