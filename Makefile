#*******************************  VARIABLES  **********************************#

NAME			=	libasm.a

# --------------- FILES --------------- #

LIST_ASM_SRC		=	ft_read.s	\
						ft_strcmp.s	\
						ft_strcpy.s	\
						ft_strdup.s	\
						ft_strlen.s	\
						ft_write.s

# ------------ DIRECTORIES ------------ #

DIR_BUILD		=	.build/
DIR_SRC 		=	src/
DIR_INCLUDE		=	include/

# ------------- SHORTCUTS ------------- #

OBJ				=	$(patsubst %.s, $(DIR_BUILD)%.o, $(SRC))
DEP				=	$(patsubst %.c, $(DIR_BUILD)%.d, $(SRC))
SRC				=	$(addprefix $(DIR_SRC),$(LIST_ASM_SRC))

# ------------ COMPILATION ------------ #

AS				=	nasm
ASFLAGS			=	-f elf64

CFLAGS			=	-Wall -Wextra -Werror

DEP_FLAGS		=	-MMD -MP

ARFLAGS			=	rcs

# -------------  COMMANDS ------------- #

RM				=	rm -rf
MKDIR			=	mkdir -p

#***********************************  RULES  **********************************#

.PHONY: all
all:			$(NAME)

.PHONY: test
test: $(NAME)
				gcc test.c $(NAME)

# ---------- VARIABLES RULES ---------- #

$(NAME):		$(OBJ)
				$(AR) $(ARFLAGS) $(NAME) $(OBJ)

# ---------- COMPILED RULES ----------- #

#-include $(DEP)

$(DIR_BUILD)%.o: %.s
				mkdir -p $(shell dirname $@)
				$(AS) $(ASFLAGS) $< -o $@

.PHONY: clean
clean:
				$(RM) $(DIR_BUILD)

.PHONY: fclean
fclean: clean
				$(RM) $(NAME)

.PHONY: re
re:				fclean
				$(MAKE) all