#!/bin/bash

case "$1" in
    *youtube.com*|*youtu.be*)
        iina "$1" --mpv-fs
        ;;
    *.png*|*.jpg*|*.jpeg*|*.gif*|*.webp*)
        clean_url="${1%%\?*}"
        ext="${clean_url##*.}"
        tmpfile=$(mktemp "/tmp/img.XXXXXX.$ext")
        trap 'rm -f "$tmpfile"' EXIT
        curl -s -L -v "$1" -o "$tmpfile" && /Applications/qView.app/Contents/MacOS/qView "$tmpfile"
        ;;
    *)
        librewolf "$1"
        ;;
esac
