# Find all .qmd files
QMD_FILES := $(shell find . -name "*.qmd")

# Render all .qmd files to md
all: $(QMD_FILES:.qmd=.md)

# Recipe to render an individual .qmd file
%.md: %.qmd
	quarto render $<

# Remove the generated md files
clean:
	rm -f $(QMD_FILES:.qmd=.md)
