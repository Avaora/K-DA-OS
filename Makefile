AS = fasmg
SRCS = bootld_f.asm bootld_s.asm
OBJS = $(basename $(SRCS))
NAME = kdaOS
RM = rm -rf

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	dd if=./bootld_f of=./$(NAME) bs=512 count=1
	dd if=./bootld_s of=./$(NAME) bs=512 count=1 seek=1
$(OBJS): % : %.asm
	$(ASMB) $< $@
clean:
	$(RM) $(OBJS)
fclean: clean
	$(RM) $(NAME)
re: fclean all