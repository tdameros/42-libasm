bits 64

extern malloc

%include "ft_list.s"

section .note.GNU-stack

section .text
    global ft_create_elem

;typedef struct s_list
;{
;   void *data;
;   struct s_list *next;
;} t_list;

; t_list *ft_create_elem(void *data);
ft_create_elem:
  push rdi
  mov rdi, LIST_SIZE
  call malloc wrt ..plt
  cmp rax, 0
  jz return
  pop rdi
  mov [rax + LIST_DATA_OFFSET], rdi
  mov qword [rax + LIST_NEXT_OFFSET], 0
  return
return:
  ret