.PHONY: all clean

all: ebproof.zip

clean:
	rubber -d --clean ebproof.dtx
	rm -f example.tex *.zip

ebproof.pdf: ebproof.dtx ebproof.sty
	rubber -df $<

ebproof.sty: ebproof.dtx
	pdflatex -interaction=batchmode ebproof.ins

ebproof.tds.zip: README.md ebproof.sty ebproof.pdf
	rm -rf ebproof.tds.zip tds
	install -d tds/tex/latex/ebproof
	install -t tds/tex/latex/ebproof ebproof.sty
	install -d tds/doc/latex/ebproof
	install -t tds/doc/latex/ebproof README.md ebproof.pdf ebproof.dtx
	cd tds ; zip -qr ../ebproof.tds.zip *
	rm -rf tds

PACKED = README.md ebproof.sty ebproof.dtx ebproof.pdf

ebproof.zip: $(PACKED) ebproof.tds.zip
	rm -f $@ ebproof
	ln -s . ebproof
	zip -qr $@ $(addprefix ebproof/,$(PACKED)) ebproof.tds.zip
	rm -f ebproof
