
###############################################################################
## Setup (public)
###############################################################################


## Working directory and User
## In case this doesn't work, set the path manually (use absolute paths).
WORKDIR                ?= .
USRID                  ?= $(shell id -u)
GRPID                  ?= $(shell id -g)


## Pandoc
## (Defaults to docker. To use pandoc and TeX-Live directly, create an
## environment variable `PANDOC` pointing to the location of your
## pandoc installation.)
PANDOC                 ?= docker run --rm --volume "$(WORKDIR):/data" --workdir /data --user $(USRID):$(GRPID) pandoc/extra:latest-ubuntu


## Source files
## (Adjust to your needs.)
SRC                    ?= thesis.md
BIBFILE                ?= references.bib
TARGET                 ?= thesis.pdf





###############################################################################
## Internal setup (do not change)
###############################################################################


## Auxiliary files
## (Do not change!)
DATA                    = .pandoc
TEMPLATES               = $(DATA)/titlepage_eisvogel.tex  $(DATA)/titlepage_simple.tex  $(DATA)/frontmatter.tex  $(DATA)/backmatter.tex
INCLUDES                = $(TEMPLATES:$(DATA)/%.tex=__%.filled.tex)





###############################################################################
## Main targets (do not change)
###############################################################################


## Default target
all: eisvogel


## Common options
OPTIONS                 = --bibliography $(BIBFILE)


## Simple book layout (https://ftp.tu-chemnitz.de/pub/tex/macros/latex/contrib/koma-script/doc/scrguide-de.pdf)
simple: OPTIONS        += --defaults=$(DATA)/simple.yaml
simple: $(TARGET)


## Use Eisvogel template (https://github.com/Wandmalfarbe/pandoc-latex-template)
eisvogel: OPTIONS      += --defaults=$(DATA)/eisvogel.yaml
eisvogel: $(TARGET)


## Build docker image ("pandoc-thesis") containing pandoc and TeX-Live
docker:
	docker pull pandoc/extra:latest-ubuntu


## Clean-up: Remove temporary (generated) files and download folder
clean:
	rm -rf $(INCLUDES)


## Clean-up: Remove also generated thesis and template files
distclean: clean
	rm -f $(TARGET)





###############################################################################
## Auxiliary targets (do not change)
###############################################################################


## Build thesis
${TARGET}: $(SRC) $(BIBFILE) $(INCLUDES)
	$(PANDOC) ${OPTIONS} $(SRC) -o $@


## Build auxiliary files (title page, frontmatter, backmatter, references)
$(INCLUDES): __%.filled.tex: $(DATA)/%.tex $(SRC)
	$(PANDOC) --wrap=preserve --template=$< $(SRC) -o $@





###############################################################################
## Declaration of phony targets
###############################################################################


.PHONY: all simple eisvogel docker clean distclean
