export PYTEX=$(shell pwd)/pytex/

START = noxxxnote nodraft noblue
END = missing
CLASS = ./IEEEtran.cls

all: wc paper ABSTRACT

open: paper.pdf
	@nohup acroread -openInNewWindow paper.pdf 1>/dev/null 2>/dev/null &

figures:
	@cd figures ; make

ABSTRACT: $(PYTEX)/bin/clean $(PYTEX)/bin/lib.py abstract.tex
	@$(PYTEX)/bin/clean abstract.tex ABSTRACT

# 16 Nov 2010 : GWA : Add other cleaning rules here.

wc: abstract.tex $(PYTEX)/bin/wc $(PYTEX)/bin/lib.py
	@$(PYTEX)/bin/wc abstract.tex -

clean: rulesclean
	@rm -f ABSTRACT

include $(PYTEX)/make/Makerules

spellcheck: .spellcheck | silent

.spellcheck: $(PAPER_TEXFILES) .okwords
	@hunspell -t -l -p $(PWD)/.okwords $(PAPER_TEXFILES) | sort -f | uniq | tee badwords && touch .spellcheck

silent:
	@:
