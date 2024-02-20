SRC_DIR := ./src
OBJ_DIR := ./obj
SRC_FILES := $(wildcard $(SRC_DIR)/*.asm)
OBJ_FILES := $(patsubst $(SRC_DIR)/%.asm,$(OBJ_DIR)/%.o,$(SRC_FILES))

CREATE_DIR := $(shell mkdir -p obj)

# NASM ve GCC flagları
NASM_FLAGS := -f elf64 -g -F dwarf
CFLAGS := -no-pie

# Bağlama bayrağı
LDFLAGS := -lcrypto

pwdgen: $(OBJ_FILES)
	gcc $^ -o $@ $(LDFLAGS) $(CFLAGS)

$(OBJ_DIR)/%.o: $(SRC_DIR)/%.asm
	nasm $(NASM_FLAGS) $< -o $@
