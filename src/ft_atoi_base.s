bits 64

extern ft_strlen

global ft_atoi_base

section .note.GNU-stack

; int	ft_atoi_base(char *str, char *base)
;{
;   int	index;
;   int	result;
;   int	sign;
;   int	base_len;
;
;   if (!(ft_is_valid_base(base)))
;     return (0);
;   index = 0;
;   result = 0;
;   sign = 1;
;   base_len = ft_strlen(base);
;   str = ft_remove_isspace_nbr(str);
;   while (str[index] == '-' || str[index] == '+')
;   {
;     if (str[index] == '-')
;       sign *= -1;
;     index++;
;   }
;   while (ft_char_is_in_base(str[index], base) != -1)
;   {
;     result = result * base_len + ft_char_is_in_base(str[index], base);
;     index++;
;   }
;   return (result * sign);
; }
;
; int	ft_is_valid_base(char *base)
;{
;   int	index;
;   int	index_temp;
;
;   index = 0;
;   while (base[index] != '\0')
;   {
;     if (base[index] == '+' || base[index] == '-'
;         || (base[index] >= 9 && base[index] <= 13) || base[index] == ' ')
;       return (0);
;     index_temp = 0;
;     while (index_temp < index)
;     {
;       if (base[index] == base[index_temp])
;         return (0);
;       index_temp++;
;     }
;     index++;
;   }
;   return (index >= 2);
; }
;
; int	ft_strlen(char *str)
;{
;   char	*first_ptr;
;
;   first_ptr = str;
;   while (*str != '\0')
;     str++;
;   return (str - first_ptr);
; }
;
; char	*ft_remove_isspace_nbr(char *str)
;{
;   while ((*str >= 9 && *str <= 13) || *str == ' ')
;     str++;
;   return (str);
; }
;
; int	ft_char_is_in_base(char c, char *base)
;{
;   int	index;
;
;   index = 0;
;   while (base[index] != '\0')
;   {
;     if (base[index] == c)
;       return (index);
;     index++;
;   }
;   return (-1);
; }

section .text
;int ft_atoi_base(char *str, char *base);
ft_atoi_base:
    push rdi
    push rsi
    mov rdi, rsi
    call is_valid_base
    pop rsi
    pop rdi
    test rax, rax
    jz .ft_atoi_base_return_false
    sub rsp, 32
    ; index
    mov qword [rsp + 0], 0
    ; result
    mov qword [rsp + 8], 0
    ; sign
    mov qword [rsp + 16], 1
    ; base_len
    push rdi
    push rsi
    mov rdi, rsi
    call ft_strlen
    pop rsi
    pop rdi
    mov [rsp + 24], rax
    ; str
    push rsi
    call remove_spaces_from_str
    pop rsi
    mov rdi, rax
    jmp .ft_atoi_base_first_loop

.ft_atoi_base_first_loop:
    mov r8, rdi
    add r8, [rsp + 0]
    mov r8, [r8]
    cmp byte r8b, '-'
    je .ft_atoi_base_first_loop_process
    cmp byte r8b, '+'
    je .ft_atoi_base_first_loop_process
    jmp .ft_atoi_base_second_loop

.ft_atoi_base_second_loop:
    push rdi
    push rsi
    ; str[index]
    add rdi, [rsp + 0 + 16]
    mov rdi, [rdi]
    call char_is_in_base
    pop rsi
    pop rdi
    cmp rax, -1
    je .ft_atoi_base_return
    mov r8, [rsp + 8]
    mov r9, [rsp + 24]
    imul r8, r9
    add r8, rax
    mov [rsp + 8], r8
    ; index++
    mov rax, [rsp + 0]
    inc rax
    mov [rsp + 0], rax
    jmp .ft_atoi_base_second_loop


.ft_atoi_base_return:
    mov rax, [rsp + 8]
    mov r8, [rsp + 16]
    imul rax, r8
    add rsp, 32
    ret


.ft_atoi_base_first_loop_process:
    cmp byte r8b, '-'
    je .ft_atoi_base_first_loop_inverse_sign
    add qword [rsp + 0], 1
    jmp .ft_atoi_base_first_loop


.ft_atoi_base_first_loop_inverse_sign:
    mov rax, [rsp + 16]
    imul rax, -1
    mov [rsp + 16], rax
    add qword [rsp + 0], 1
    jmp .ft_atoi_base_first_loop



.ft_atoi_base_return_false:
    mov rax, 0
    ret

remove_spaces_from_str:
    cmp byte [rdi], ' '
    je .remove_spaces_from_str_inc
    cmp byte [rdi], 9
    jl .remove_spaces_from_str_end
    cmp byte [rdi], 13
    jg .remove_spaces_from_str_end
    jmp .remove_spaces_from_str_inc

.remove_spaces_from_str_inc:
    inc rdi
    jmp remove_spaces_from_str

.remove_spaces_from_str_end:
    mov rax, rdi
    ret

char_is_in_base:
    xor rax, rax
    jmp .char_is_in_base_loop

.char_is_in_base_loop:
    mov r8, rsi
    add r8, rax
    mov r8, [r8]
    ; only u8 in r8
    test r8b, r8b
    jz .char_is_in_base_end_loop
    ; only u8 in r8 and rdi
    cmp r8b, dil
    je .char_is_in_base_end_loop_found
    inc rax
    jmp .char_is_in_base_loop

.char_is_in_base_end_loop:
    mov rax, -1
    ret

.char_is_in_base_end_loop_found:
    ret

is_valid_base:
    xor rax, rax

.is_valid_base_first_loop:
    mov r8, rdi
    add r8, rax
    mov r8, [r8]
    test r8b, r8b
    jz .is_valid_base_first_loop_end
    jmp .is_valid_base_second_loop

.is_valid_base_second_loop:
    mov r8, rdi
    add r8, rax
    mov r8, [r8]
    cmp byte r8b, '+'
    jz .is_valid_base_ret_false
    cmp byte r8b, '-'
    jz .is_valid_base_ret_false
    cmp byte [rdi], 9
    jl .is_valid_base_second_loop_pre
    cmp byte [rdi], 13
    jg .is_valid_base_second_loop_pre
    jmp .is_valid_base_ret_false

.is_valid_base_second_loop_pre:
    ; r9 = index_temp
    xor r9, r9
    jmp .is_valid_base_second_loop_2

.is_valid_base_second_loop_2:
    cmp r9, rax
    jge .is_valid_base_second_loop_end
    ; r10 = base[index_temp]
    mov r10, rdi
    add r10, r9
    mov r10, [r10]
    ; base[index] == base[index_temp]
    cmp r8b, r10b
    jz .is_valid_base_ret_false
    inc r9
    jmp .is_valid_base_second_loop_2

.is_valid_base_second_loop_end:
    inc rax
    jmp .is_valid_base_first_loop

.is_valid_base_first_loop_end:
    cmp rax, 2
    jl .is_valid_base_ret_false
    jmp .is_valid_base_ret_true

.is_valid_base_ret_false:
    mov rax, 0
    ret

.is_valid_base_ret_true:
    mov rax, 1
    ret
