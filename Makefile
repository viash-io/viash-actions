# Set up some variables for consistency
QMD_FILES := $(shell find . -name "README.qmd")  # Find all README.qmd files
MD_FILES := $(patsubst %.qmd,%.md,$(QMD_FILES)) # Corresponding MD filenames

# Default target: build all MD files
all: $(MD_FILES)

README.md: README.qmd
	quarto render $<
%/README.md: %/README.qmd %/action.yml
	quarto render $<

# Clean up generated MD files
clean:
	rm -f $(MD_FILES) 
