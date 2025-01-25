---
title: "Title of my Thesis"
#subtitle: "From Markdown to LaTeX to PDF"
author: "Surname Name"

studentnumber: "12345678"
date: "20. Juli 2025"

reviewer1:  "XXX, HSBI"
reviewer2:  "XXX, Wuppie GmbH"

keywords: [Markdown, Example]
lang: de-DE


## The behaviour of headers and footers in Eisvogel is a bit ... unusual. The following
## metadata variables change the format to the standard format. Please adjust as needed.
##
## When using Eisvogel, very long titles may require (multiple) line breaks in the page
## headers. In this case, please define a shortened one-line version of your long title
## to be used in the page headers.
### Example: header-left: "Shortened version of title for running page headers ..."
##
header-left:   "\\hspace{1mm}"  # off
header-center: "\\headmark"     # chapter name
header-right:  "\\hspace{1mm}"  # off
footer-left:   "\\hspace{1mm}"  # off
footer-center: "\\pagemark"     # page number
footer-right:  "\\hspace{1mm}"  # off


## optional (mandatory, if english abstract enabled)
abstract-de: |
  Dies ist die Zusammenfassung auf Deutsch.


## optional
abstract-en: |
  This is an english abstract.


## optional
acknowledgements: |
  Hier kommt die Danksagung hin.


## optional
restrictionnote: |
  Die vorliegende Arbeit enthält vertrauliche Daten der Firma XYZ. Veröffentlichungen
  oder Vervielfältigungen der Arbeit -- auch nur auszugsweise -- sind ohne ausdrückliche
  Genehmigung des beteiligten Unternehmens nicht gestattet.

  Die Arbeit ist nur den Prüfern bzw. den Korrektoren sowie den Mitgliedern des
  Prüfungsausschusses bzw. der oder dem Prüfungsbeauftragten zugänglich zu machen.


## mandatory
##
## HSBI students will need to submit the form provided by the university, which can be found at
## https://www.hsbi.de/media/hochschulverwaltung/dezernat-ii/studserv/pruefungsangelegenheiten/hochschulweite-ordnungen-formulare-und-antraege/eigenstaendigkeitserklaerung.pdf
##
## All others can just uncomment the following section:
##
#declaration: |
#  Ich erkläre hiermit an Eides Statt, dass ich die vorliegende Arbeit selbstständig
#  angefertigt habe. Die aus fremden Quellen direkt oder indirekt übernommenen Gedanken
#  sind entsprechend kenntlich gemacht.
#
#  Ich habe die Arbeit bisher weder in gleicher noch in ähnlicher Form einer anderen
#  Prüfungsbehörde vorgelegt und auch noch nicht veröffentlicht. Das PDF-Exemplar stimmt
#  mit den eingereichten Exemplaren überein.
---





# Einleitung

*   Worum geht es hier? Was ist das betrachtete Problem bzw. die Fragestellung der Arbeit?
*   Darstellung der Bedeutung und Relevanz: Warum sollte die Fragestellung bearbeitet werden?
*   Einordnung in den Kontext
*   Abgrenzung: Welche Probleme werden im Rahmen der Arbeit *nicht* gelöst?
*   Zielsetzung: Möglichst genaue Beschreibung der Ziele der Arbeit, etwa erwarteter Nutzen oder wissenschaftlicher Beitrag

Umfang: typisch ca. 8% ... 10% der Arbeit


## Aufbau einer wissenschaftlichen Arbeit

Bitte lesen Sie den online frei verfügbaren Text zum wissenschaftlichen Arbeiten von @Balzert2022 durch.


## Markdown und -Erweiterungen durch Pandoc

Für eine Einführung in (Pandoc-) Markdown vgl. [pandoc.org/MANUAL.html](https://pandoc.org/MANUAL.html).

Da als Backend \LaTeX{} zum Einsatz kommt, können alle entsprechenden Befehle und Umgebungen ebenfalls
genutzt werden (ggf. muss noch das jeweilige Paket importiert werden).

**Tipp**: Für eine schnelle Übersicht einfach den Quelltext dieser Datei ansehen ([thesis.md](./thesis.md)).


## Zitieren

Einfach den Bibtex-Key mit einem `@` davor in eckigen Klammern schreiben: Aus `[@Dietz2018]` wird [@Dietz2018] ...
Mit Seiten- oder Kapitelangabe: Aus `[@Dietz2018, Seite 111]` oder `[@Dietz2018, Kapitel 111]` wird
[@Dietz2018, Seite 111] oder [@Dietz2018, Kapitel 111] ...

Pandoc (bzw. `pandoc-citeproc`) nutzt per Default den *Chicago Manual of Style*-Stil^[vgl.
[pandoc.org/MANUAL.html#citations](https://pandoc.org/MANUAL.html#citations)].
Für andere Zitierstile (etwa numerisch oder als Fußnote) sind auf [zotero.org/styles](https://www.zotero.org/styles)
die passenden CSL-Dateien zum Download zu finden. Die Aktivierung erfolgt über die Option
`--csl=XXX.csl` in der Datei `Makefile`.

**Tipp**: Unter [editor.citationstyles.org/searchByName/](https://editor.citationstyles.org/searchByName/)
können Sie sich die Wirkung der jeweiligen Zitierstile/CSL-Definitionen anschauen.


## Abbildungen

![Hier steht die Bildunterschrift, Quelle: [@Dietz2018] \label{fig:foo}](figs/wuppie.png){width=80%}


## Source-Code

```{.python caption="The preprocessing step, cf. [@Dietz2018]" #lst:huh}
def foo():
  """ Wuppie! """
  pass
```

## Mathe

Display-Math geht wie in \LaTeX{} mit einem doppelten Dollarzeichen (entspricht der `equation`-Umgebung):

$$
    \label{eq:wuppie}
    \nabla E(\mathbf{w}) = \left( \frac{\partial E}{\partial w_{0}}, \frac{\partial E}{\partial w_{1}}, \ldots, \frac{\partial E}{\partial w_{n}} \right)^T
$$

Inline-Math geht mit einem einfachen Dollar-Zeichen: $\mathbf{w} \gets \mathbf{w} + \Delta\mathbf{w}$ ...


## Tabellen

| Rechtsbündig | Linksbündig | Default | Zentriert |
|-------------:|:------------|---------|:---------:|
|          foo | foo         | foo     |    foo    |
|          123 | 123         | 123     |    123    |
|          bar | bar         | bar     |    bar    |

: Tabelle als Markdown-Pipe-Table, vgl. [@Dietz2018] \label{tab:ugh}


Leider gibt es derzeit einen Bug (siehe [github.com/Wandmalfarbe/pandoc-latex-template/issues/29](https://github.com/Wandmalfarbe/pandoc-latex-template/issues/29)
bzw. [github.com/jgm/pandoc/issues/3929](https://github.com/jgm/pandoc/issues/3929)), wodurch die Breite beim Einfärben der
Tabellenzeilen etwas zu breit wird. Wenn das stört, kann man immer noch normale \LaTeX{}-Tabellen nutzen (siehe
Tabelle \ref{tab:ieks}).

\begin{longtable}[]{rllc}
\caption{Tabelle als \LaTeX{}-Table \label{tab:ieks}} \\
\toprule
Rechtsbündig & Linksbündig & Default & Zentriert \tabularnewline
\midrule
\endhead
foo & foo & foo & foo \tabularnewline
123 & 123 & 123 & 123 \tabularnewline
bar & bar & bar & bar \tabularnewline
\bottomrule
\end{longtable}


## Querverweise

Querverweise funktionieren in Markdown leider nicht so richtig wie von \LaTeX{} gewohnt.

Hier kann aber einfach auf die entsprechenden \LaTeX{}-Pendants ausgewichen werden:

*   Definieren einer Referenz mit `\label{<id>}`{.latex} (beispielsweise in den jeweiligen Unterschriften
    unter einer Abbildung/Tabelle/Code-Schnipsel), und
*   Bezugnahme auf eine Referenz im Text mit `\ref{<id>}`{.latex}.

Vgl. Abbildung \ref{fig:foo} oder Tabelle \ref{tab:ugh} oder Listing \ref{lst:huh} ...

Wer mehr braucht, kann sogenannte Filter^[vgl. [pandoc.org/filters.html](https://pandoc.org/filters.html)
bzw. [pandoc.org/lua-filters.html](https://pandoc.org/lua-filters.html)] einsetzen, beispielsweise
[github.com/lierdakil/pandoc-crossref](https://github.com/lierdakil/pandoc-crossref).





# Stand der Technik/Forschung, vergleichbare Arbeiten

*   Darstellung relevanter Ansätze aus der Praxis bzw. Forschung
*   Einordnung und Bewertung der Konzepte und Lösungen in Bezug auf die Ziele der Arbeit

Umfang: typisch ca. 15% ... 20% der Arbeit





# Eigene Ideen, Konzepte, Methoden

*   Darstellung der eigenen Ideen und Konzepte zur Lösung der Fragestellung
*   Vergleich mit bekannten Lösungen: Worin unterscheiden sich die eigenen Ansätze von den bekannten? Wo liegen mögliche Vor- oder Nachteile?
*   Wie soll das Konzept umgesetzt werden? Beschreibung der zur Umsetzung eingesetzten Methoden

Umfang: typisch ca. 20% ... 30% der Arbeit





# Realisierung, Evaluation

*   Beschreibung der Umsetzung des Lösungskonzepts
*   Darstellung der aufgetretenen Probleme sowie deren Lösung bzw. daraus resultierende Einschränkungen des Ergebnisses (falls keine Lösung)
*   Auswertung und Interpretation der Ergebnisse
*   Vergleich mit der ursprünglichen Zielsetzung (ausführlich): Was wurde erreicht, was nicht (und warum)? (inkl. Begründung/Nachweis)

Umfang: typisch ca. 30% ... 40% der Arbeit





# Zusammenfassung

*   Fazit: Vergleich mit der ursprünglichen Zielsetzung (komprimiert/zusammengefasst)
*   Ausblick: Darstellung ungelöster Probleme und weiterer relevanter Ideen

Umfang: typisch ca. 5% ... 10% der Arbeit


## Fazit

Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.


## Ausblick

Lorem ipsum dolor sit amet, consectetur adipisici elit, sed eiusmod tempor incidunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquid ex ea commodi consequat. Quis aute iure reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint obcaecat cupiditat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.





<!-- ==============  DO NOT EDIT THE SECTION BELOW  ============== -->

# Quellen {.unnumbered}

\markboth{Quellen}{Quellen}

<!--
References are automatically generated from the BibTex file (references.bib)
... which you should create/maintain using a reference manager.
-->

::: {#refs}
:::


\appendix

<!-- ==============  DO NOT EDIT THE SECTION ABOVE  ============== -->





# Appendix 1: Some extra stuff

Platz für *wichtige* Materialien, die zu umfangreich für den eigentlichen Textteil sind.

Der Anhang gehört *nicht* zum Textteil (wird nicht zum Seitenumfang hinzugerechnet).
Der Umfang des Anhangs sollte möglichst klein sein!


## Bilder

wuppie!

## Code

fluppie?

## Tabellen

foo! bar!

# Wuppie
