# pandoc-thesis

A Template for Thesis Documents written in Markdown


## Installation

### Docker (recommended)

1.  Install docker from <https://hub.docker.com/search/?type=edition&offering=community>
2.  Build docker image containing pandoc and TeX Live: `make docker`

### Alternative Route

1.  Install pandoc from <https://pandoc.org/>
2.  You also need to install LaTeX, e.g. from <https://www.tug.org/texlive/>
3.  Install packages needed by pandoc: <https://pandoc.org/MANUAL.html#creating-a-pdf>
4.  Either set an environment variable `PANDOC` to the location of your pandoc installation or change in the line
    `PANDOC      ?= docker run --rm -v $(PWD):/pandoc pandoc-thesis pandoc` in the [`Makefile`](Makefile) to reflect
    your settings

### Additional Templates

*   Eisvogel: For using the [Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template), download the latest
    version of the template [`eisvogel.tex`](https://github.com/Wandmalfarbe/pandoc-latex-template/blob/master/eisvogel.tex)
    and move it to the project folder
*   Clean Thesis: For using the [Clean Thesis template](https://github.com/derric/cleanthesis), download the latest version
    of the template [`cleanthesis.sty`](https://github.com/derric/cleanthesis/blob/master/cleanthesis.sty) and move it to the
    project folder


## Usage Example

1.  Maintain your references in [`references.bib`](references.bib)
2.  Put the title of your thesis, your name and other meta information in [`md/metadata.yaml`](md/metadata.yaml)
3.  Fill the markdown files under [`md/`](md)
    *   The default files in the folder [`md/`](md) correspond to a typical structure of a scientific thesis (see also
        `@Balzert2017`: *Balzert et al.* "Wissenschaftliches Arbeiten", Springer, 2017). You can just use this as starting
        point for your work ...  *Hint*: You will find some help regarding the use of Markdown in
        [`md/introduction.md`](md/introduction.md) as well as typical number of pages for each chapter in the comment section
        of each file.
    *   In case you see need for an other layout, please do not forget to reflect the changed filenames in [`Makefile`](Makefile).
4.  Build the thesis:
    *   Using the simple layout: `make simple`
    *   Using Eisvogel: `make eisvogel`
    *   Using Clean Thesis: `make cleanthesis`
5.  Clean up:
    *   To remove temporary (generated) filed: `make clean`
    *   To also remove the generated thesis (PDF): `make distclean`

The above mentioned files constitute a minimal working example. You can start your own project by just customizing those files.


## Preview

### Example using *Simple* Layout

| Simple Titlepage                                                                                        | Simple Chapter                                                                                      |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| [![Simple Titlepage](examples/thesis_example_simple_titlepage.png)](examples/thesis_example_simple.pdf) | [![Simple Chapter](examples/thesis_example_simple_chapter.png)](examples/thesis_example_simple.pdf) |

### Example using *Eisvogel* Template

| Eisvogel Titlepage                                                                                            | Eisvogel Chapter                                                                                          |
|---------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [![Eisvogel Titlepage](examples/thesis_example_eisvogel_titlepage.png)](examples/thesis_example_eisvogel.pdf) | [![Eisvogel Chapter](examples/thesis_example_eisvogel_chapter.png)](examples/thesis_example_eisvogel.pdf) |

### Example using *Clean Thesis* Template

| Clean Thesis Titlepage                                                                                                  | Clean Thesis Chapter                                                                                                |
|-------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------|
| [![Clean Thesis Titlepage](examples/thesis_example_cleanthesis_titlepage.png)](examples/thesis_example_cleanthesis.pdf) | [![Clean Thesis Chapter](examples/thesis_example_cleanthesis_chapter.png)](examples/thesis_example_cleanthesis.pdf) |



---

# License

Copyright (c) 2019, Carsten Gips

[MIT licensed](http://opensource.org/licenses/MIT)
