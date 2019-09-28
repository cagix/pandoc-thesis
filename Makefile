
## Path to this repository and setup docker
PWD          = $(shell pwd)
PANDOC      ?= docker run --rm -v $(PWD):/pandoc pandoc-thesis pandoc

## Template variables
TMP_DIR                 = ./tmp

TEMPLATE_NAME           =
TEMPLATE_FILE           =
TEMPLATE_DIR            = $(TMP_DIR)/templates/$(TEMPLATE_NAME)
TEMPLATE_GIT_REPO       =
TEMPLATE_VERSION        =



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



## Functions

define template-dl
	$(eval TEMPLATE_NAME     = $(or $(TEMPLATE_NAME),$(1)))
	$(eval TEMPLATE_FILE     = $(or $(TEMPLATE_FILE),$(2)))
	$(eval TEMPLATE_GIT_REPO = $(or $(TEMPLATE_GIT_REPO),$(3)))
	$(eval TEMPLATE_VERSION  = $(or $(TEMPLATE_VERSION),$(4)))

	rm -rf $(TEMPLATE_DIR)
	git clone --single-branch --branch $(TEMPLATE_VERSION) --depth 1 $(TEMPLATE_GIT_REPO) $(TEMPLATE_DIR)
	cp $(TEMPLATE_DIR)/$(TEMPLATE_FILE) ./$(TEMPLATE_FILE)
endef



## Targets

## Simple book layout
simple: $(TARGET)

## Use Eisvogel template (https://github.com/Wandmalfarbe/pandoc-latex-template)
eisvogel.tex:
	$(call template-dl,eisvogel,eisvogel.tex,https://github.com/Wandmalfarbe/pandoc-latex-template,v1.2.4)

eisvogel: EISVOGEL  += -M eisvogel=true
eisvogel: OPTIONS   += --template=eisvogel.tex
eisvogel: eisvogel.tex $(TARGET)

## Use Clean Thesis template (https://github.com/derric/cleanthesis)
cleanthesis.sty:
	$(call template-dl,cleanthesis,cleanthesis.sty,https://github.com/derric/cleanthesis,v0.4.0)

cleanthesis: CLEANTHESIS += -M cleanthesis=true -M cleanthesisbibfile=$(BIBFILE:%.bib=%)
cleanthesis: OPTIONS     += --include-in-header=include-header.tex
cleanthesis: cleanthesis.sty $(TARGET)



${TARGET}: $(SRC) $(REFERENCES) $(APPENDIX) $(META) $(BIBFILE) $(TMP)
	$(PANDOC) ${OPTIONS} -o $@ $(SRC) $(REFERENCES) $(APPENDIX)

$(TMP): __%.filled.tex: %.tex $(META)
	$(PANDOC) $(EISVOGEL) $(CLEANTHESIS) --template=$< --metadata-file=$(META) -o $@ $<



docker:
	cd docker && make



clean:
	rm -rf $(TMP) $(TMP_DIR)

distclean: clean
	rm -f $(TARGET) eisvogel.tex cleanthesis.sty



.PHONY: all simple eisvogel cleanthesis docker clean distclean template-dl
