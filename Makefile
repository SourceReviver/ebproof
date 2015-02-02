.PHONY: all clean

all: ebproof.zip

clean:
	rubber -d --clean ebproof.tex
	rm -f example.tex *.zip

ebproof.pdf: ebproof.tex ebproof.sty
	rubber -df $<

ebproof.tds.zip: README ebproof.sty ebproof.pdf
	rm -rf ebproof.tds.zip tds
	install -d tds/tex/latex/ebproof
	install -t tds/tex/latex/ebproof ebproof.sty
	install -d tds/doc/latex/ebproof
	install -t tds/doc/latex/ebproof README ebproof.pdf
	cd tds ; zip -qr ../ebproof.tds.zip *
	rm -rf tds

PACKED = README ebproof.sty ebproof.tex ebproof.pdf

ebproof.zip: $(PACKED) ebproof.tds.zip
	rm -f $@ ebproof
	ln -s . ebproof
	zip -qr $@ $(addprefix ebproof/,$(PACKED)) ebproof.tds.zip
	rm -f ebproof
