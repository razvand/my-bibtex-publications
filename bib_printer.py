#!/usr/bin/env python3

"""
Parse contents of .bib file and print it as table (Tab-separated) text list.
"""

import sys
import bibtexparser


def main():
    """Do everything in the main() function:
         - open .bib file
         - parse .bib file using bibtexparser API
         - walk entries
         - extract and process required fields in each entry
         - print fields in table format (Tab-separated)
    """

    with open('publications.bib') as bibfile:
        content = bibfile.read()
        content = content.replace("\"\n}", "\",\n}")
        bibdb = bibtexparser.loads(content)

    for entry in bibdb.entries:
        year = entry['year']
        title = entry['title']

        doi = ""
        if 'doi' in entry.keys():
            doi = entry['doi']

        wos = ""
        if 'note' in entry.keys():
            if entry['note'].find('WOS') != -1:
                wos = entry['note'].split(':')[1]

        venue = ""
        if entry['ENTRYTYPE'] == 'inproceedings':
            venue = entry['booktitle']
        elif entry['ENTRYTYPE'] == 'article':
            volume = ""
            number = ""
            if 'volume' in entry.keys():
                volume = entry['volume']
            if 'number' in entry.keys():
                number = entry['number']
            venue = "{}, vol. {}, num. {}".format(entry['journal'], volume, number)

        issn = ""
        isbn = ""
        if 'isbn' in entry:
            isbn = entry['isbn']
        if 'issn' in entry:
            issn = entry['issn']

        print("{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}\t{}".format(
            year, title, doi, wos, "", venue, issn, "", isbn))


if __name__ == "__main__":
    sys.exit(main())
