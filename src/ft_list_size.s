bits 64

%include "ft_list.s"

global ft_list_size

section .note.GNU-stack

section .text
;typedef struct s_list
;{
;   void *data;
;   struct s_list *next;
;} t_list;

;int ft_list_size(t_list *begin_list);
ft_list_size:
  xor rax, rax
  jmp loop
loop:
    cmp rdi, 0
    je end
    mov rdi, [rdi + LIST_NEXT_OFFSET]
    inc rax
    jmp loop
end:
    ret