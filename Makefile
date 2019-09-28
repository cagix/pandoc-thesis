
###############################################################################
## Setup (public)
###############################################################################


## Pandoc
## (Defaults to docker. To use pandoc and TeX-Live directly, create an
## environment variable `PANDOC` pointing to the location of your
## pandoc installation.)
PANDOC      ?= docker run --rm -v $(shell pwd):/pandoc pandoc-thesis pandoc


## Source files
## (Adjust to your needs. Order of markdown files in $(SRC) matters!)
META         = md/metadata.yaml
SRC          = md/introduction.md       \
               md/relatedwork.md        \
               md/concept.md            \
               md/realisation.md        \
               md/conclusion.md
BIBFILE	     = references.bib
APPENDIX     = md/appendix.md

TARGET       = thesis.pdf





###############################################################################
## Setup (internal: do not change)
###############################################################################


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
AUX_OPTS     =

OPTIONS      = -f markdown
OPTIONS     += --pdf-engine=pdflatex
OPTIONS     += --filter=pandoc-citeproc
OPTIONS     += --metadata-file=$(META)
OPTIONS     += -M bibliography=$(BIBFILE)
OPTIONS     += --listings
OPTIONS     += --include-in-header=$(TMP1)
OPTIONS     += --include-before-body=$(TMP2)
OPTIONS     += --include-after-body=$(TMP3)


## Template variables
TMP_DIR                 = ./tmp

TEMPLATE_NAME           =
TEMPLATE_FILE           =
TEMPLATE_DIR            = $(TMP_DIR)/templates/$(TEMPLATE_NAME)
TEMPLATE_GIT_REPO       =
TEMPLATE_VERSION        =


## Functions
define template-dl
	$(eval TEMPLATE_NAME     = $(or $(TEMPLATE_NAME),$(1)))
	$(eval TEMPLATE_FILE     = $(or $(TEMPLATE_FILE),$(2)))
	$(eval TEMPLATE_GIT_REPO = $(or $(TEMPLATE_GIT_REPO),$(3)))
	$(eval TEMPLATE_VERSION  = $(or $(TEMPLATE_VERSION),$(4)))

	rm -rf $(TEMPLATE_DIR)
	git clone --quiet --single-branch --branch $(TEMPLATE_VERSION) --depth 1 $(TEMPLATE_GIT_REPO) $(TEMPLATE_DIR) 2>/dev/null
	cp $(TEMPLATE_DIR)/$(TEMPLATE_FILE) ./$(TEMPLATE_FILE)
endef





###############################################################################
## Targets (internal: do not change)
###############################################################################


## Simple book layout
simple: $(TARGET)


## Use Eisvogel template (https://github.com/Wandmalfarbe/pandoc-latex-template)
eisvogel.tex:
	$(call template-dl,eisvogel,eisvogel.tex,https://github.com/Wandmalfarbe/pandoc-latex-template,v1.2.4)

eisvogel: AUX_OPTS  += -M eisvogel=true
eisvogel: OPTIONS   += --template=eisvogel.tex $(AUX_OPTS)
eisvogel: eisvogel.tex $(TARGET)


## Use Clean Thesis template (https://github.com/derric/cleanthesis)
cleanthesis.sty:
	$(call template-dl,cleanthesis,cleanthesis.sty,https://github.com/derric/cleanthesis,v0.4.0)

cleanthesis: AUX_OPTS += -M cleanthesis=true -M cleanthesisbibfile=$(BIBFILE:%.bib=%)
cleanthesis: OPTIONS  += --include-in-header=include-header.tex $(AUX_OPTS)
cleanthesis: cleanthesis.sty $(TARGET)


## Build thesis
${TARGET}: $(SRC) $(REFERENCES) $(APPENDIX) $(META) $(BIBFILE) $(TMP)
	$(PANDOC) ${OPTIONS} -o $@ $(SRC) $(REFERENCES) $(APPENDIX)


## Build auxiliary files (title page, frontmatter, backmater, references)
$(TMP): __%.filled.tex: %.tex $(META)
	$(PANDOC) $(AUX_OPTS) --template=$< --metadata-file=$(META) -o $@ $<


## Build docker image ("pandoc-thesis") containing pandoc and TeX-Live
docker:
	cd docker && make


## Clean-up: Remove temporary (generated) files and download folder
clean:
	rm -rf $(TMP) $(TMP_DIR)


## Clean-up: Remove also genereated thesis and template files
distclean: clean
	rm -f $(TARGET) eisvogel.tex cleanthesis.sty



.PHONY: all simple eisvogel cleanthesis docker clean distclean template-dl
