# Makefile para generar el pdf
SHELL := /bin/bash

LATEX=latex
DVI=dvips
PS=ps2pdf
#PDFLATEX=xelatex
PDFLATEX_OPTS=-interaction=nonstopmode -halt-on-error -shell-escape

TEX_FILE=laboratorio1_noblia.tex
DVI_FILE=laboratorio1_noblia.dvi
PS_FILE=laboratorio1_noblia.ps

.PHONY: all pdf clean

all : pdf

pdf: $(TEX_FILE)
	$(LATEX) $(PDFLATEX_OPTS) $(TEX_FILE)
	$(DVI) $(DVI_FILE)
	$(PS) $(PS_FILE)

clean:
	rm -fv *.{aux,log,nav,out,snm,toc,vrb}
