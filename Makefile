# Author: Carsten Gips <carsten.gips@fh-bielefeld.de>
# Copyright: (c) 2019 Carsten Gips
# License: MIT



## Path to this repository and setup docker

PWD          = $(shell pwd)
PANDOC      ?= docker run --rm -v $(PWD):/pandoc pandoc-thesis pandoc



## Source files
## (Adjust to your needs. Order of markdown files in SRC matters!)

META         = md/metadata.yaml
SRC          = md/introduction.md       \
               md/relatedwork.md        \
               md/concept.md            \
               md/realisation.md        \
               md/conclusion.md
BIBFILE	     = references.bib
APPENDIX     = md/appendix.md

TARGET       = thesis.pdf



## Auxiliary files
## (Do not change!)

TITLEPAGE    = titlepage.tex
FRONTMATTER  = frontmatter.tex
BACKMATTER   = backmatter.tex
REFERENCES   = references.md

TMP1         = $(TITLEPAGE:%.tex=__%.filled.tex)
TMP2         = $(FRONTMATTER:%.tex=__%.filled.tex)
TMP3         = $(BACKMATTER:%.tex=__%.filled.tex)
TMP          = $(TMP1) $(TMP2) $(TMP3)



## Pandoc options

OPTIONS      = -f markdown
OPTIONS     += --pdf-engine=pdflatex
OPTIONS     += --filter=pandoc-citeproc
OPTIONS     += --listings
OPTIONS     += --metadata-file=$(META)
OPTIONS     += --include-in-header=$(TMP1)
OPTIONS     += --include-before-body=$(TMP2)
OPTIONS     += --include-after-body=$(TMP3)



## Targets

## Simple book layout
simple: $(TARGET)



${TARGET}: $(SRC) $(REFERENCES) $(APPENDIX) $(META) $(BIBFILE) $(TMP)
	$(PANDOC) ${OPTIONS} -o $@ $(SRC) $(REFERENCES) $(APPENDIX)

$(TMP): __%.filled.tex: %.tex $(META)
	$(PANDOC) --template=$< --metadata-file=$(META) -o $@ $<



docker:
	cd docker && make



clean:
	rm -f $(TMP)

distclean: clean
	rm -f $(TARGET)


.PHONY: all simple docker clean distclean
