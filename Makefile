# Makefile

# Compiler and flags
CXX = g++
CXXFLAGS = -Wall -Wextra -Iinclude

# Directories
SRC_DIR = src
BIN_DIR = bin
INCLUDE_DIR = include

# Config file
CONFIG_FILE = config.txt

# Extract program name from the config file
PROGRAM_NAME = $(shell grep PROGRAM_NAME $(CONFIG_FILE) | cut -d '=' -f 2 | tr -d ' ')

# Source files: automatically find all .cpp files in the src/ directory
SRC_FILES = $(wildcard $(SRC_DIR)/*.cpp)

# Object files: one for each source file
OBJ_FILES = $(SRC_FILES:.cpp=.o)

# Target: the program name is now taken from the config file
TARGET = $(BIN_DIR)/$(PROGRAM_NAME)

# Default target
all: $(TARGET)

# Linking the target
$(TARGET): $(OBJ_FILES) | $(BIN_DIR)
	$(CXX) $(OBJ_FILES) -o $(TARGET)

# Compile each source file into an object file
%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $< -o $@

# Create the bin directory if it doesn't exist
$(BIN_DIR):
	mkdir -p $(BIN_DIR)

# Clean: remove object files and binary
clean:
	rm -rf $(OBJ_FILES) $(TARGET)

# Phony targets
.PHONY: all clean
