PROJECT = hqss
SRC = src/$(PROJECT).tex
OUT_DIR = build

# 基底エンジン
LUALATEX = lualatex -interaction=nonstopmode -halt-on-error -file-line-error -synctex=1

# %O に -jobname や -outdir などの latexmk 引数が自動展開されます
LATEX_CMD_JA = $(LUALATEX) %O "\PassOptionsToClass{}{article}\newif\ifja\jatrue\input{%S}"
LATEX_CMD_EN = $(LUALATEX) %O "\PassOptionsToClass{}{article}\newif\ifja\jafalse\input{%S}"

LATEXMK = latexmk -pdf -outdir=$(OUT_DIR)

.PHONY: all ja en clean distclean

all: ja en

ja: $(OUT_DIR)/$(PROJECT)_ja.pdf

$(OUT_DIR)/$(PROJECT)_ja.pdf: $(SRC)
	@mkdir -p $(OUT_DIR)
	$(LATEXMK) -jobname=$(PROJECT)_ja -pdflatex='$(LATEX_CMD_JA)' $<

en: $(OUT_DIR)/$(PROJECT)_en.pdf

$(OUT_DIR)/$(PROJECT)_en.pdf: $(SRC)
	@mkdir -p $(OUT_DIR)
	$(LATEXMK) -jobname=$(PROJECT)_en -pdflatex='$(LATEX_CMD_EN)' $<

clean:
	@if [ -d "$(OUT_DIR)" ]; then \
		latexmk -c -outdir=$(OUT_DIR) -jobname=$(PROJECT)_ja $(SRC) 2>/dev/null || true; \
		latexmk -c -outdir=$(OUT_DIR) -jobname=$(PROJECT)_en $(SRC) 2>/dev/null || true; \
	fi
	rm -f $(PROJECT).pdf $(PROJECT).log $(PROJECT).aux $(PROJECT).synctex.gz

distclean:
	rm -rf $(OUT_DIR)
	rm -f $(PROJECT).pdf $(PROJECT).log $(PROJECT).aux $(PROJECT).synctex.gz
