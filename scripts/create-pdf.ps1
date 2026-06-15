#!/usr/bin/env powershell
$ErrorActionPreference = "Stop"

$SCRIPT_DIR = $PSScriptRoot
$ROOT_DIR = Split-Path -Parent $SCRIPT_DIR
$BUILD_DIR = Join-Path -Path $ROOT_DIR -ChildPath "build"
$TEX_FILE = Join-Path -Path $ROOT_DIR -ChildPath "src\main.tex"

if (-not (Test-Path -Path $TEX_FILE)) {
    Write-Error "Error: $TEX_FILE not found." 
    exit 1
}

if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    Write-Error "latexmk is not installed"
    exit 1
}

if (-not (Test-Path -Path $BUILD_DIR)) {
    New-Item -ItemType Directory -Path $BUILD_DIR | Out-Null
}

Write-Host "Creating pdf inside $BUILD_DIR"
& latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -bibtex -outdir="$BUILD_DIR" "$TEX_FILE"

Write-Host "Pdf generated at $BUILD_DIR/main.pdf!"