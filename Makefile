# KnowhutImean?
TARGET = mss
BIBFILE = mss
# Everything the PDF depends on, so an edit to the style file, a vendored
# font, or an image triggers a rebuild.  The tracked PDF defeats mtime
# comparison on a fresh clone; use `make force` for an unconditional build.
DEPS = ustj.sty listings-rust.sty $(wildcard *.otf) $(wildcard *.pdf_tex) \
       ustj-logo.pdf ustj-logo-hollow.pdf

all: $(TARGET).pdf

force:
	touch $(TARGET).tex
	$(MAKE) $(TARGET).pdf

$(TARGET).pdf: $(TARGET).tex $(BIBFILE).bib $(DEPS)
	xelatex -interaction=nonstopmode $(TARGET)
	biber $(TARGET)
	xelatex -interaction=nonstopmode $(TARGET)
	xelatex -interaction=nonstopmode $(TARGET)

clean:
	rm -f $(TARGET).pdf *.aux *.bbl *.bcf *.blg *.log *.out *.run.xml *.toc

.PHONY: all clean force
