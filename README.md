# Manage BibTeX Publications

This is a template repository for managing your list of BibTeX publications.
[BibTeX](http://www.bibtex.org/) is a format and a set of tools for managing bibliographical references.
You store your publications in the `publications.bib` file and your can then include them in your LaTeX files, process them and list them.

The `publications.bib` file stores some sample BibTeX entries for testing.
Update it with your own publications in BibTeX format.
Most publishing and indexing services (such as [ACM Digital Library](https://dl.acm.org/), [IEEExplore](https://ieeexplore.ieee.org/Xplore/home.jsp), [DBLP](https://dblp.org/), [SCOPUS](https://www.scopus.com/home.uri), [arXiv](https://arxiv.org/)) allow you to export citations in BibTeX format; you don't have to do it from scratch.

List your publications in PDF format using the `publications.tex` file by running `make`.
Once you run `make`, you create the `publications.pdf` file.
If you update the `publications.bib` file, you run `make` again to regenerate the `publications.pdf` file.
The `publications.tex` file is a basic LaTeX file; update it / customize it to your needs.

## Process Publications

In order to process your publications to be listed in a given format, you can use either [`bibtexconv`](https://manpages.ubuntu.com/manpages/bionic/man1/bibtexconv.1.html) or the [BibtexParser Python library](https://bibtexparser.readthedocs.io/en/master/).

### bibtexconv

`bibtexconv` doesn't seem to be maintained anymore, but the Ubuntu/Debian package does the work.
Install it using:

```console
$ sudo apt install bibtexconv
```

`bibtexconv` uses an internal scripting language: define a template for each entry and then print / sort entries in the required format.
On a default Ubuntu/Debian install, sample script files are located in `/usr/share/doc/bibtexconv/examples/`.
Other specific scripts are located in the `bibtextconv/` folder, each for a different type of printing:

```console
$ ls bibtexconv/
cnatdcu-doi.export  cnatdcu-table.export  cnatdcu-wos.export  list.export
```

Pass the script file at the standard input of `bibtexconv` to print entries in the requested format:

```console
$ bibtexconv publications.bib < /usr/share/doc/bibtexconv/examples/text-example.export

$ bibtexconv publications.bib < bibtexconv/list.export

$ bibtexconv publications.bib < bibtexconv/cnatdcu-table.export

$ bibtexconv publications.bib < bibtexconv/cnatdcu-wos.export

$ bibtexconv publications.bib < bibtexconv/cnatdcu-doi.export
```

### BibtexParser

BibtexParser gives you access to the fields in each BibTeX item.
You can then print certain fields or select some entries.
See the `bib_printer.py` as a sample BibtexParser processing script;
it prints the publication year, title, DOI (_Digital Object Identifier_) and other fields for entries in the `publications.bib` file:

```console
$ ./bib_printer.py
[...]
2021	A Framework for Analyzing GPU-Executed Malware	10.1109/CSCS52396.2021.00034[...]
2022	Using Cybersecurity Exercises as Essential Learning Tools in Universities	10.5220/0010994700003182[...]
2022	Safer Linux Kernel Modules using the D Programming Language	10.1109/ACCESS.2022.3229461[...]
[...]
```
