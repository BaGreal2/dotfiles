#!/bin/bash

case "$1" in
    *youtube.com*|*youtu.be*)
        iina "$1" --mpv-fs
        ;;
    *)
        librewolf "$1"
        ;;
esac
