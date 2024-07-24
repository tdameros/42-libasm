bits 64

extern malloc
extern ft_create_elem

%include "ft_list.s"


section .note.GNU-stack

section .text
    global ft_list_push_front

;typedef struct s_list
;{
;   void *data;
;   struct s_list *next;
;} t_list;

;void ft_list_push_front(t_list **begin_list, void *data);
ft_list_push_front:
  test rdi, rdi
  jz .return
  push rdi
  mov rdi, rsi
  call ft_create_elem
  cmp rax, 0
  jz .return
  pop rdi
  mov rsi, [rdi]
  mov qword [rax + LIST_NEXT_OFFSET], rsi
  mov qword [rdi], rax
  .return
.return:
  ret
