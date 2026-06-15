!#/usr/bin/bash
set -eux

CURRENT_DIR="$(pwd)"

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$ROOT_DIR/build"
TEX_FILE="$ROOT_DIR/src/main.tex"

if [ ! -f "$TEX_FILE" ]; then
    echo "Error: $TEX_FILE not found." >&2
    exit 1
fi

command -v latexmk >/dev/null 2>&1 || { echo "latexmk is not installed" >&2; exit 1; }

mkdir -p "$BUILD_DIR"

echo "Creating pdf inside $BUILD_DIR"
latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir="$BUILD_DIR" "$TEX_FILE"

echo "Pdf generated at $BUILD_DIR/main.pdf!"
