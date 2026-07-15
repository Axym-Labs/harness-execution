#!/usr/bin/env bash
set -euo pipefail

export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$PATH"

if [[ $# -lt 1 || $# -gt 2 ]]; then
    echo "Usage: render-pdf.sh INPUT.{tex,md} [OUTPUT.pdf]" >&2
    exit 2
fi

input="$1"
output="${2:-${input%.*}.pdf}"
ext="${input##*.}"
workdir="$(cd "$(dirname "$input")" && pwd)"
base="$(basename "$input")"

case "$ext" in
    tex)
        if command -v latexmk >/dev/null 2>&1; then
            latexmk -pdf -interaction=nonstopmode -halt-on-error -outdir="$workdir" "$input"
            built="$workdir/${base%.tex}.pdf"
        elif command -v xelatex >/dev/null 2>&1; then
            (cd "$workdir" && xelatex -interaction=nonstopmode -halt-on-error "$base")
            built="$workdir/${base%.tex}.pdf"
        elif command -v lualatex >/dev/null 2>&1; then
            (cd "$workdir" && lualatex -interaction=nonstopmode -halt-on-error "$base")
            built="$workdir/${base%.tex}.pdf"
        elif command -v pdflatex >/dev/null 2>&1; then
            (cd "$workdir" && pdflatex -interaction=nonstopmode -halt-on-error "$base")
            built="$workdir/${base%.tex}.pdf"
        elif command -v tectonic >/dev/null 2>&1; then
            tectonic --outdir "$workdir" "$input"
            built="$workdir/${base%.tex}.pdf"
        else
            echo "No LaTeX renderer found. Install latexmk+TeX Live, xelatex, lualatex, pdflatex, or tectonic." >&2
            exit 1
        fi
        ;;
    md|markdown)
        if ! command -v pandoc >/dev/null 2>&1; then
            echo "No Markdown PDF renderer found. Install pandoc plus a LaTeX engine." >&2
            exit 1
        fi
        pandoc "$input" -o "$output"
        built="$output"
        ;;
    *)
        echo "Unsupported input extension: .$ext. Use .tex for structured/math output or .md for text-only output." >&2
        exit 2
        ;;
esac

if [[ "$built" != "$output" ]]; then
    cp "$built" "$output"
fi

echo "$output"
