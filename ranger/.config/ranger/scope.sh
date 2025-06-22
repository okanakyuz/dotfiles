#!/usr/bin/env bash

FILEPATH="$1"

preview_image() {
    ueberzug layer --parser bash 2>/dev/null <<EOF
    add image_preview 0 0 50% 100% "$FILEPATH"
EOF
}

preview_text_with_pygments() {
    pygmentize -f terminal256 -O style=monokai -g "$FILEPATH"
}

case "$FILEPATH" in
    *.png|*.jpg|*.jpeg|*.gif|*.bmp)
        preview_image
        exit 0
        ;;
    *.c|*.cpp|*.py|*.rs|*.go|*.sh|*.lua|*.js|*.ts|*.java|*.html|*.css)
        preview_text_with_pygments
        exit 5
        ;;
    *)
        exit 1
        ;;
esac
