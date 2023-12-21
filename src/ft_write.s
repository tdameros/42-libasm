bits 64

extern __errno_location

section .note.GNU-stack

section .text
    global ft_write

; ssize_t ft_write(int fd, const void *buf, size_t count);
ft_write:
    mov rax, 1
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