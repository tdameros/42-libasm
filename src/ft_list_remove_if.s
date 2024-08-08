bits 64

%include "ft_list.s"

extern free

global ft_list_remove_if

section .text
;typedef struct s_list
;{
;   void *data;
;   struct s_list *next;
;} t_list;

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(),
;                       void (*free_fct)(void *)) {
;  if (begin_list == NULL || cmp == NULL) {
;    return;
;  }
;
;  t_list *current = *begin_list;
;  t_list *previous = NULL;
;  while (current) {
;    if (cmp(current->data, data_ref) == 0) {
;      if (previous) {
;        previous->next = current->next;
;      } else {
;        *begin_list = current->next;
;      }
;      if (free_fct) {
;        free_fct(current->data);
;      }
;      free(current);
;      current = previous ? previous->next : *begin_list;
;    } else {
;      previous = current;
;      current = current->next;
;    }
;  }

;void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
ft_list_remove_if:
  ; begin_list
  test rdi, rdi
  jz .end
  ; cmp
  test rdx, rdx
  jz .end
  ; save r8 and r9
  push r8
  push r9
  ; current_node
  mov r8, [rdi]
  ; previous_node
  xor r9, r9
  jmp .loop
.loop:
   test r8, r8
   jz .end_loop
   jmp .cmp_function

.cmp_function:
   push rdi
   push rsi
   push rdx
   push rcx
   push r8
   push r9
   mov rdi, [r8 + LIST_DATA_OFFSET]
   ; call cmp_fct
   call rdx
   pop r9
   pop r8
   pop rcx
   pop rdx
   pop rsi
   pop rdi
   test rax, rax
   jz .remove_node
   jnz .next_node

.remove_node:
  ; if previous != NULL
  test r9, r9
  jnz .link_previous_to_next
  jmp .link_to_next

.link_previous_to_next:
  mov rax, [r8 + LIST_NEXT_OFFSET]
  mov [r9 + LIST_NEXT_OFFSET], rax
  jmp .free_node

.link_to_next:
  mov rax, [r8 + LIST_NEXT_OFFSET]
  mov [rdi], rax
  jmp .free_node

.free_node:
  ; if free_fct != NULL
  test rcx, rcx
  jnz .call_free_fct
  push rdi
  push rsi
  push rdx
  push rcx
  push r8
  push r9
  mov rdi, r8
  call free wrt ..plt
  pop r9
  pop r8
  pop rcx
  pop rdx
  pop rsi
  pop rdi
  jmp .update_current_after_free

.call_free_fct:
   push rdi
   push rsi
   push rdx
   push rcx
   push r8
   push r9
   mov rdi, [r8 + LIST_DATA_OFFSET]
   call rcx
   pop r9
   pop r8

   push r8
   push r9
   mov rdi, r8
   ;call rcx
   call free wrt ..plt
   pop r9
   pop r8
   pop rcx
   pop rdx
   pop rsi
   pop rdi
  jmp .update_current_after_free

.update_current_after_free:
  ; if previous != NULL
  test r9, r9
  jnz .link_current_to_previous_next
  mov r8, [rdi]
  jmp .loop

.link_current_to_previous_next:
  mov r8, [r9 + LIST_NEXT_OFFSET]
  jmp .loop

.next_node:
  mov r9, r8
  mov r8, [r8 + LIST_NEXT_OFFSET]
  jmp .loop

.end_loop:
  ; restore r8 and r9
  pop r9
  pop r8
  ret

.end:
  ret
