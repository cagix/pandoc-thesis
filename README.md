<!--  pandoc -s -f markdown -t markdown+smart-grid_tables-multiline_tables-simple_tables --columns=94 --reference-links=true  README.md  -o xxx.md  -->

# Pandoc Thesis Template

A template for thesis documents written in Markdown.

## About

This template makes it easy to write your thesis in Markdown. It uses an integrated toolchain
to translate your work into LaTeX, creating a properly formatted PDF document. So you don't
have to worry about the somewhat arcane TeX commands and you can still enjoy the centuries-old
art of letterpress printing, with its rules integrated into LaTeX.

You can choose between two different styles:

-   'simple'

    The 'Simple' theme uses the [scrbook LaTeX class] and adds a custom title page.

-   'Eisvogel'

    The 'Eisvogel' style is based on the [Eisvogel LaTeX template] and adds a back page for
    the cover sheet with all the information you need for a thesis.

Both styles let you add an acknowledgement, an abstract (in German and/or English) and a
restriction note.

## How to Start

There are two different ways you can start with this template:

1.  Working **locally** on your own machine:

    You will need [Docker] and the [`pandoc/extra`] docker image, as well as the contents of
    this template repository plus [GNU Make].

    <details>

    -   Fork this repository into your own namespace

        Here's a tip: If you don't need the history or future update, just click the '*Use
        this template*' button above!

    -   *Git clone* your repository locally to your machine

    -   Install [Docker]

    -   Fetch the [`pandoc/extra`] docker image containing all dependencies, e.g. pandoc and
        TeX Live: `make docker` or `docker pull pandoc/extra:latest-ubuntu`

        **Note**: You will need about 1.5GB of free disk space:

            $ docker image ls
            REPOSITORY       TAG             IMAGE ID       CREATED       SIZE
            pandoc/extra     latest-ubuntu   4be5559759ed   6 weeks ago   1.27GB

    -   Work on the [`thesis.md`] and [`references.bib`] files to create your thesis and build
        the PDF using `make simple` or `make eisvogel` (see below)

    </details>

2.  Working **remote** using GitHub workflows:

    Maintain a repository with the two relevant files [`thesis.md`] and [`references.bib`],
    and use a GitHub workflow to build the PDF.

    <details>

    -   Either fork this repository into your own namespace or create your own repository
        containing copies of both the [`thesis.md`] and [`references.bib`] files provided here

    -   Create a GitHub workflow in your repository using the GitHub action
        'cagix/pandoc-thesis' that is included in this template, e.g.:

        ``` yaml
        on:
          pull_request:

        jobs:
          compile:
            runs-on: ubuntu-latest
            steps:
              - uses: actions/checkout@v4
              - uses: cagix/pandoc-thesis@master
                with:
                  srcfile: thesis.md
                  targetfile: thesis.pdf
                  bibfile: references.bib
                  template: eisvogel
              - uses: actions/upload-artifact@v4
                with:
                  path: thesis.pdf
                  overwrite: true
        ```

        Please adjust the files names as needed.

    -   Work on the [`thesis.md`] and [`references.bib`] files to create your thesis and build
        the PDF by pushing to your repository (see below)

    </details>

## Working locally

1.  Maintain your references in [`references.bib`] (BibTeX format)

    There are many reference management programs offering BibTeX export. A nice example is
    [JabRef], which allows you to create and maintain your BibTeX file locally.

2.  Put the **title** of your thesis, your **name** and other meta information into the YAML
    header of [`thesis.md`]

3.  Adjust optional definitions in the YAML header of [`thesis.md`] to your needs:

    -   Disable extras like `abstract-*` or `acknowledgements` or `restrictionnote`: Remove or
        comment this optional definitions
    -   Modify content (text) of optional definitions like `abstract-*` or `acknowledgements`
        or `restrictionnote`

4.  Put your content into the markdown file [`thesis.md`]

    The default chapters correspond to a typical structure of a scientific thesis (see also
    `@Balzert2022`: *Balzert et al.* "Wissenschaftliches Arbeiten", 2022). You can just use
    this as starting point for your work ...

    *Hint*: You will find some help regarding the use of Markdown in the first chapter of
    [`thesis.md`] as well as typical number of pages for each chapter in the beginning of each
    chapter.

5.  Pandoc uses per default the *Chicago Manual of Style* for citations
    (cf. [pandoc.org/MANUAL.html#citations]).

    You can search [zotero.org/styles] or [editor.citationstyles.org/searchByName] for
    alternative style definitions, download the corresponding `.csl` file to your project
    folder and activate the style in the corresponding default file, i.e. [`eisvogel.yaml`] or
    [`simple.yaml`] (option `csl: XXX.csl` at the bottom of the file).

6.  Build the thesis:

    -   Locally:
        -   Simple layout: `make simple`
        -   Eisvogel theme: `make eisvogel`
    -   Remote:
        -   `git push` (and let your GitHub workflow do the heavy lifting)

7.  Clean up (when working locally):

    -   To remove temporary (generated) filed: `make clean`
    -   To also remove the generated thesis (PDF): `make distclean`

> [!WARNING]
> When switching between templates, please make sure to `make clean` first! Failing to do so
> may lead to strange behaviour or even to weird errors.

> [!IMPORTANT]
> Do not use Windows + Docker directly, but via WSL:
>
> -   Install WSL (see https://learn.microsoft.com/en-us/windows/wsl/install), any
>     distribution will work
> -   Start the subsystem to get access to its shell
> -   `git clone https://github.com/cagix/pandoc-thesis.git` to pull the project
> -   `make docker` to pull the `pandoc/extra` image
> -   `make simple` or `make eisvogel` to build the thesis
> -   Success!

## Submitting your thesis

HSBI students submit their work as a PDF using the upload form at
https://www.hsbi.de/hochschule/schriftliche-arbeiten.

A declaration of originality must also be submitted. The form can be found at
["Eigenständigkeitserklärung"] and must be completed, signed and uploaded together with the
thesis PDF.

## Preview

### Example using *Simple* Layout

| Simple Titlepage         | Simple Chapter         |
|--------------------------|------------------------|
| [![Simple Titlepage]][1] | [![Simple Chapter]][1] |

### Example using *Eisvogel* Template

| Eisvogel Titlepage         | Eisvogel Chapter         |
|----------------------------|--------------------------|
| [![Eisvogel Titlepage]][2] | [![Eisvogel Chapter]][2] |

----------------------------------------------------------------------------------------------

# License

This work by [Carsten Gips] and [contributors] is licensed under [MIT].

  [scrbook LaTeX class]: https://ctan.org/pkg/scrbook
  [Eisvogel LaTeX template]: https://github.com/Wandmalfarbe/pandoc-latex-template
  [Docker]: https://www.docker.com/
  [`pandoc/extra`]: https://hub.docker.com/r/pandoc/extra/
  [GNU Make]: https://www.gnu.org/software/make/
  [`thesis.md`]: thesis.md
  [`references.bib`]: references.bib
  [JabRef]: https://www.jabref.org/
  [pandoc.org/MANUAL.html#citations]: https://pandoc.org/MANUAL.html#citations
  [zotero.org/styles]: https://www.zotero.org/styles
  [editor.citationstyles.org/searchByName]: https://editor.citationstyles.org/searchByName/
  [`eisvogel.yaml`]: ./eisvogel.yaml
  [`simple.yaml`]: ./simple.yaml
  ["Eigenständigkeitserklärung"]: https://www.hsbi.de/media/hochschulverwaltung/dezernat-ii/studserv/pruefungsangelegenheiten/hochschulweite-ordnungen-formulare-und-antraege/eigenstaendigkeitserklaerung
  [Simple Titlepage]: examples/thesis_example_simple_titlepage.png
  [1]: examples/thesis_example_simple.pdf
  [Simple Chapter]: examples/thesis_example_simple_chapter.png
  [Eisvogel Titlepage]: examples/thesis_example_eisvogel_titlepage.png
  [2]: examples/thesis_example_eisvogel.pdf
  [Eisvogel Chapter]: examples/thesis_example_eisvogel_chapter.png
  [Carsten Gips]: https://github.com/cagix
  [contributors]: https://github.com/cagix/pandoc-thesis/graphs/contributors
  [MIT]: https://opensource.org/licenses/MIT
