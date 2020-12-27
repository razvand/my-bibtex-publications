BASENAME_RO = Razvan_Deaconescu_Publicatii
BASENAME_EN = Razvan_Deaconescu_Publications
PDF_RO = $(addsuffix .pdf, $(BASENAME_RO))
TEX_RO = $(addsuffix .tex, $(BASENAME_RO))
PDF_EN = $(addsuffix .pdf, $(BASENAME_EN))
TEX_EN = $(addsuffix .tex, $(BASENAME_EN))
BIB = publications.bib
PDFLATEX = pdflatex
BIBTEX = bibtex
OUT_DIR = texfiles

.PHONY: clean all

all: $(PDF_RO) $(PDF_EN)

$(PDF_RO): $(TEX_RO) $(BIB)
	# Create out directory.
	-test -d $(OUT_DIR) || mkdir $(OUT_DIR)
	# Run twice, so TOC is also updated.
	$(PDFLATEX) -output-directory $(OUT_DIR) -jobname $(basename $@) $<
	$(BIBTEX) $(OUT_DIR)/$(basename $@)
	$(PDFLATEX) -output-directory $(OUT_DIR) -jobname $(basename $@) $<
	ln -f $(OUT_DIR)/$@ .

$(PDF_EN): $(TEX_EN) $(BIB)
	# Create out directory.
	-test -d $(OUT_DIR) || mkdir $(OUT_DIR)
	# Run twice, so TOC is also updated.
	$(PDFLATEX) -output-directory $(OUT_DIR) -jobname $(basename $@) $<
	$(BIBTEX) $(OUT_DIR)/$(basename $@)
	$(PDFLATEX) -output-directory $(OUT_DIR) -jobname $(basename $@) $<
	ln -f $(OUT_DIR)/$@ .

clean:
	-test -d $(OUT_DIR) && rm -fr $(OUT_DIR)
	-rm -f $(PDF_RO) $(PDF_EN)
