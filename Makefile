# **************************************************************************** #
#                                                                              #
#                                                         ::::::::             #
#    Makefile                                           :+:    :+:             #
#                                                      +:+                     #
#    By: itopchu <itopchu@student.codam.nl>           +#+                      #
#                                                    +#+                       #
#    Created: 2023/01/12 19:19:51 by itopchu       #+#    #+#                  #
#    Updated: 2023/01/22 17:52:35 by anonymous     ########   odam.nl          #
#                                                                              #
# **************************************************************************** #

# **************************************************************************** #
BOLD	:= \033[1m
BLACK	:= \033[30;1m
RED		:= \033[31;1m
GREEN	:= \033[32;1m
YELLOW	:= \033[33;1m
BLUE	:= \033[34;1m
MAGENTA	:= \033[35;1m
CYAN	:= \033[36;1m
WHITE	:= \033[37;1m
RESET	:= \033[0m
# **************************************************************************** #
NAME	= fdf
# **************************************************************************** #
CC		= gcc
CFLAGS	= -w -Wunreachable-code -Ofast
COMPILE	= $(CC) $(CFLAGS)
# **************************************************************************** #
RM		=rm -rf
# **************************************************************************** #
MLX_LIB	= ./inc/MLX42
MY_LIB	= ./inc/mylib
# **************************************************************************** #
HEADERS	= -Iinc $(H_MY_LIB) $(H_MLX_LB)
H_MY_LIB= -I$(MY_LIB)/src/header
H_MLX_LB= -I$(MLX42)/include
# **************************************************************************** #
# LIBS	= -lglfw -L /Users/$(USER)/.brew/opt/glfw/lib/ $(L_MLX_LB) $(L_MY_LIB)
LIBS	= -lglfw - L /usr/include/GLFW/ $(L_MLX_LB) $(L_MY_LIB)
L_MY_LIB= -L$(MY_LIB)/my_lib.a
L_MLX_LB= -L$(MLX_LIB)/libmlx42.a
# **************************************************************************** #
DIR_SRC	= src/
DIR_OBJ	= obj/
# **************************************************************************** #
SRCS	= $(addprefix $(DIR_SRC), $(SRCF))
SRCF	=	main.c
OBJS	= $(patsubst src/%.c,obj/%.o,$(SRCS))
# **************************************************************************** #

all		: dirs my_lib mlx_lib $(NAME)

dirs	:
	@mkdir -p $(DIR_OBJ)

my_lib	:
	@$(MAKE) -s -C $(MY_LIB)

mlx_lib	:
	@echo "$(YELLOW)MLX42 Compiling$(RESET)"
	@$(MAKE) -s -C $(MLX_LIB)

obj/%.o:src/%.c
	@mkdir -p $(DIR_OBJ)
	@$(COMPILE) -c $< -o $@ $(HEADERS)

$(NAME)	: $(OBJS)
	@$(COMPILE) $(OBJS) -o $(NAME) $(LIBS) $(HEADERS)
	@echo "$(BLUE)$(BOLD)fdf: $(NAME) Compiled $(RESET)"

clean	:
	@$(RM) $(DIR_OBJ)
	@$(MAKE) -C $(MY_LIB) clean
	@$(MAKE) -C $(MLX_LIB) clean

fclean	: clean
	@$(RM) $(NAME)
	@$(MAKE) -C $(MY_LIB) fclean	
	@$(MAKE) -C $(MLX_LIB) fclean	

re		: clean all

.PHONY	: all, clean, fclean, re, my_lib, mlx_lib