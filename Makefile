.PHONY: all clean

all: ebproof.zip

clean:
	rubber -d --clean ebproof.dtx
	rm -f example.tex *.zip

ebproof.pdf: ebproof.dtx ebproof.sty
	rubber -df $<

ebproof.sty: ebproof.dtx
	pdflatex -interaction=batchmode ebproof.ins

ebproof.zip: README.md ebproof.dtx ebproof.ins ebproof.pdf
	rm -f $@ ebproof
	ln -s . ebproof
	zip -qr $@ $(addprefix ebproof/,$^)
	rm -f ebproof
