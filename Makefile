
## Path to this repository and setup docker
PWD          = $(shell pwd)
PANDOC      ?= docker run --rm -v $(PWD):/pandoc pandoc-thesis pandoc

## Template variables
TMP_DIR                 = tmp
TEMPLATES_DIR           = $(TMP_DIR)/templates

EISVOGEL_DIR            = $(TEMPLATES_DIR)/eisvogel
EISVOGEL_VERSION        = v1.2.4
EISVOGEL_GIT_REPO       = https://github.com/Wandmalfarbe/pandoc-latex-template.git

CLEANTHESIS_DIR         = $(TEMPLATES_DIR)/cleanthesis
CLEANTHESIS_VERSION     = v0.4.0
CLEANTHESIS_GIT_REPO    = https://github.com/derric/cleanthesis.git


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
EISVOGEL    =
CLEANTHESIS =

OPTIONS      = -f markdown
OPTIONS     += --pdf-engine=pdflatex
OPTIONS     += --filter=pandoc-citeproc
OPTIONS     += --metadata-file=$(META)
OPTIONS     += -M bibliography=$(BIBFILE)
OPTIONS     += --listings
OPTIONS     += --include-in-header=$(TMP1)
OPTIONS     += --include-before-body=$(TMP2)
OPTIONS     += --include-after-body=$(TMP3)
OPTIONS     += $(EISVOGEL)
OPTIONS     += $(CLEANTHESIS)



## Targets

## Simple book layout
simple: $(TARGET)

## Use Eisvogel template (https://github.com/Wandmalfarbe/pandoc-latex-template)
eisvogel-dl:
	rm -rf $(EISVOGEL_DIR)
	git clone --single-branch --branch $(EISVOGEL_VERSION) --depth 1 $(EISVOGEL_GIT_REPO) $(EISVOGEL_DIR)
	cp $(EISVOGEL_DIR)/eisvogel.tex eisvogel.tex

eisvogel: EISVOGEL += -M eisvogel=true
eisvogel: OPTIONS  += --template=eisvogel.tex
eisvogel: $(TARGET)

## Use Clean Thesis template (https://github.com/derric/cleanthesis)
cleanthesis-dl:
	rm -rf $(CLEANTHESIS_DIR)
	git clone --single-branch --branch $(CLEANTHESIS_VERSION) --depth 1 $(CLEANTHESIS_GIT_REPO) $(CLEANTHESIS_DIR)
	cp $(CLEANTHESIS_DIR)/cleanthesis.sty cleanthesis.sty

cleanthesis: CLEANTHESIS += -M cleanthesis=true -M cleanthesisbibfile=$(BIBFILE:%.bib=%)
cleanthesis: OPTIONS     += --include-in-header=include-header.tex
cleanthesis: $(TARGET)



${TARGET}: $(SRC) $(REFERENCES) $(APPENDIX) $(META) $(BIBFILE) $(TMP)
	$(PANDOC) ${OPTIONS} -o $@ $(SRC) $(REFERENCES) $(APPENDIX)

$(TMP): __%.filled.tex: %.tex $(META)
	$(PANDOC) $(EISVOGEL) $(CLEANTHESIS) --template=$< --metadata-file=$(META) -o $@ $<



docker:
	cd docker && make



clean:
	rm -rf $(TMP) $(TMP_DIR)

distclean: clean
	rm -f $(TARGET)


.PHONY: all simple eisvogel cleanthesis docker clean distclean eisvogel-dl cleanthesis-dl
