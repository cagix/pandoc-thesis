
###############################################################################
## Setup (public)
###############################################################################


## Working directory
## In case this doesn't work, set the path manually (use absolute paths).
WORKDIR                 = $(CURDIR)


## Pandoc
## (Defaults to docker. To use pandoc and TeX-Live directly, create an
## environment variable `PANDOC` pointing to the location of your
## pandoc installation.)
PANDOC                 ?= docker run --rm --volume "$(WORKDIR):/pandoc" --workdir /pandoc --user `id -u`:`id -g` pandoc/extra:latest-ubuntu


## Source files
## (Adjust to your needs. Order of markdown files in $(SRC) matters!)
META                    = md/metadata.yaml

SRC                     = md/introduction.md       \
                          md/relatedwork.md        \
                          md/concept.md            \
                          md/realisation.md        \
                          md/conclusion.md

BIBFILE                 = references.bib

APPENDIX                = md/appendix.md

TARGET                  = thesis.pdf





###############################################################################
## Internal setup (do not change)
###############################################################################


## Auxiliary files
## (Do not change!)
TITLEPAGE               = titlepage.tex
FRONTMATTER             = frontmatter.tex
BACKMATTER              = backmatter.tex
REFERENCES              = references.md

TMP1                    = $(TITLEPAGE:%.tex=__%.filled.tex)
TMP2                    = $(FRONTMATTER:%.tex=__%.filled.tex)
TMP3                    = $(BACKMATTER:%.tex=__%.filled.tex)
TMP                     = $(TMP1) $(TMP2) $(TMP3)


## Pandoc options
AUX_OPTS                = --wrap=preserve

OPTIONS                 = -f markdown
OPTIONS                += --pdf-engine=pdflatex
OPTIONS                += --standalone

OPTIONS                += -M lang=de-DE
OPTIONS                += --metadata-file=$(META)

OPTIONS                += --include-in-header=$(TMP1)
OPTIONS                += --include-before-body=$(TMP2)
OPTIONS                += --include-after-body=$(TMP3)

OPTIONS                += --citeproc
OPTIONS                += -M bibliography=$(BIBFILE)
OPTIONS                += -M link-citations=true
## download from https://www.zotero.org/styles
## cf. https://pandoc.org/MANUAL.html#citations
#OPTIONS                += --csl=chicago-author-date-de.csl
#OPTIONS                += --csl=chicago-note-bibliography.csl
#OPTIONS                += --csl=ieee.csl
#OPTIONS                += --csl=oxford-university-press-note.csl

OPTIONS                += --listings

OPTIONS                += -V documentclass=scrbook
OPTIONS                += -V papersize=a4
OPTIONS                += -V fontsize=11pt

OPTIONS                += -V classoption:open=right
OPTIONS                += -V classoption:twoside=true
OPTIONS                += -V classoption:cleardoublepage=empty
OPTIONS                += -V classoption:clearpage=empty

OPTIONS                += -V geometry:top=30mm
OPTIONS                += -V geometry:left=25mm
OPTIONS                += -V geometry:bottom=30mm
OPTIONS                += -V geometry:width=150mm
OPTIONS                += -V geometry:bindingoffset=6mm

OPTIONS                += --toc
OPTIONS                += --toc-depth=3
OPTIONS                += --number-sections

OPTIONS                += -V colorlinks=true

## Eisvogel (do not change!)
## https://github.com/Wandmalfarbe/pandoc-latex-template
OPTIONS                += -V book=true
OPTIONS                += -V titlepage=true
OPTIONS                += -V toc-own-page=true





###############################################################################
## Main targets (do not change)
###############################################################################


## Simple book layout
simple: $(TARGET)


## Use Eisvogel template (https://github.com/Wandmalfarbe/pandoc-latex-template)
eisvogel: AUX_OPTS         += -M eisvogel=true
eisvogel: OPTIONS          += --template eisvogel $(AUX_OPTS)
eisvogel: OPTIONS          += -V float-placement-figure=htbp
eisvogel: OPTIONS          += -V listings-no-page-break=true
eisvogel: $(TARGET)


## Build docker image ("pandoc-thesis") containing pandoc and TeX-Live
docker:
	cd docker && make


## Clean-up: Remove temporary (generated) files and download folder
clean:
	rm -rf $(TMP)


## Clean-up: Remove also generated thesis and template files
distclean: clean
	rm -f $(TARGET)





###############################################################################
## Auxiliary targets (do not change)
###############################################################################


## Build thesis
${TARGET}: $(SRC) $(REFERENCES) $(APPENDIX) $(META) $(BIBFILE) $(TMP)
	$(PANDOC) ${OPTIONS} -o $@ $(SRC) $(REFERENCES) $(APPENDIX)


## Build auxiliary files (title page, frontmatter, backmatter, references)
$(TMP): __%.filled.tex: %.tex $(META)
	$(PANDOC) $(AUX_OPTS) --template=$< --metadata-file=$(META) -o $@ $<





###############################################################################
## Declaration of phony targets
###############################################################################


.PHONY: simple eisvogel docker clean distclean
