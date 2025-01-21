# Pandoc Thesis Template

A Template for Thesis Documents written in Markdown.


## Installation

### Docker

1.  Install docker from <https://www.docker.com/>
2.  Fetch the [`pandoc/extra`](https://hub.docker.com/r/pandoc/extra/) docker image containing all
    dependencies, e.g. pandoc and TeX Live: `make docker` or `docker pull pandoc/extra:latest-ubuntu`

**Note**: You will need about 1.5GB of free disk space:

```
$ docker image ls
REPOSITORY       TAG             IMAGE ID       CREATED       SIZE
pandoc/extra     latest-ubuntu   4be5559759ed   6 weeks ago   1.27GB
```

### Additional Templates

A fairly up-to-date version of the [Eisvogel template](https://github.com/Wandmalfarbe/pandoc-latex-template)
is already included in `pandoc/extra`. It no longer needs to be downloaded and installed separately.


## Usage Example

1.  Maintain your references in [`references.bib`](references.bib)
2.  Put the title of your thesis, your name and other meta information in [`md/metadata.yaml`](md/metadata.yaml)
3.  Adjust optional definitions in [`md/metadata.yaml`](md/metadata.yaml) to your needs:
    -   Disable extras like `abstract-*` or `acknowledgements` or `restrictionnote`: Remove or comment this optional definitions
    -   Modify content (text) of optional definitions like `abstract-*` or `acknowledgements` or `restrictionnote`
    -   If you like Eisvogel but want a more useful`^W`conventional page header (i.e. chapter/section instead of the thesis title) activate (i.e. remove comment in front of) `headeralternative`
4.  Fill the markdown files under [`md/`](md) with your content
    *   The default files in the folder [`md/`](md) correspond to a typical structure of a scientific thesis (see also
        `@Balzert2017`: *Balzert et al.* "Wissenschaftliches Arbeiten", Springer, 2017). You can just use this as starting
        point for your work ...  *Hint*: You will find some help regarding the use of Markdown in
        [`md/introduction.md`](md/introduction.md) as well as typical number of pages for each chapter in the comment section
        of each file.
    *   In case you see need for an other layout, please do not forget to reflect the changed filenames in [`Makefile`](Makefile).
5.  Pandoc uses per default the *Chicago Manual of Style* for citations (cf. [pandoc.org/MANUAL.html#citations](https://pandoc.org/MANUAL.html#citations)).
    You can search [zotero.org/styles](https://www.zotero.org/styles) or [editor.citationstyles.org/searchByName](https://editor.citationstyles.org/searchByName/)
    for alternative style definitions, download the corresponding `.csl` file to your project folder and activate the style in the
    [`Makefile`](Makefile) (option `--csl=XXX.csl`).
6.  Build the thesis:
    *   Using the simple layout: `make simple`
    *   Using Eisvogel: `make eisvogel`
7.  Clean up:
    *   To remove temporary (generated) filed: `make clean`
    *   To also remove the generated thesis (PDF): `make distclean`

The above mentioned files constitute a minimal working example. To start your own project, simply clone this project and customize
the files mentioned above.

The generated PDF is intended to be printed **double sided** like a book. Also, chapters start always on a new (right) page, i.e.
this may produce an empty left page at the end of a chapter.

**Note**: *When switching between templates, please make sure to `make clean` first! Failing to do so may lead to strange behaviour
or even to weird errors.*


## Preview

### Example using *Simple* Layout

| Simple Titlepage                                                                                        | Simple Chapter                                                                                      |
|---------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| [![Simple Titlepage](examples/thesis_example_simple_titlepage.png)](examples/thesis_example_simple.pdf) | [![Simple Chapter](examples/thesis_example_simple_chapter.png)](examples/thesis_example_simple.pdf) |

### Example using *Eisvogel* Template

| Eisvogel Titlepage                                                                                            | Eisvogel Chapter                                                                                          |
|---------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------|
| [![Eisvogel Titlepage](examples/thesis_example_eisvogel_titlepage.png)](examples/thesis_example_eisvogel.pdf) | [![Eisvogel Chapter](examples/thesis_example_eisvogel_chapter.png)](examples/thesis_example_eisvogel.pdf) |



---

# License

This work by [Carsten Gips](https://github.com/cagix) and [contributors](https://github.com/cagix/pandoc-thesis/graphs/contributors) is licensed under [MIT](https://opensource.org/licenses/MIT).

