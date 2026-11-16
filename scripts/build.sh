#!/bin/sh
# Builds index.html (a standalone page you can open in any browser or serve with GitHub Pages)
# from snowbelt-desk.html (the source published as the claude.ai artifact, which has no <html>/<head> wrapper).
set -e
cd "$(dirname "$0")/.."
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><style>:root{color-scheme:light;padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0;font:14px/1.45 system-ui,sans-serif}img{max-width:100%%}[hidden]{display:none!important}</style></head><body>\n'
  cat snowbelt-desk.html
  printf '\n</body></html>\n'
} > index.html
echo "Wrote index.html"
