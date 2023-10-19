#!/bin/sh
usage="\
usage: tdlv [URL...] command
       ... | tdlv command"

for cmd; do true; done
tmpdir="$(mktemp -d /tmp/tdlv.XXXXXXXXXX)"
if [ -z "$tmpdir" ] || [ ! -d "$tmpdir" ]; then
    exit 1
fi

trap clean HUP INT QUIT TERM EXIT
clean() {
    if [ -d "$tmpdir" ]; then
        rm -r "$tmpdir"
    fi
}

die() {
    if [ -n "$1" ]; then
        >&2 echo "$@"
    fi
    exit 1
}

if [ $# -lt 1 ]; then
    die "$usage"
fi

if [ $# -gt 1 ]; then
    urls="$(echo "$@" | cut -d ' ' -f -"$(($# - 1))")"
fi

if [ ! -t 0 ]; then
    urls="$(printf '%s\n%s' "$(sed '/^$/d')" "$urls")"
fi

for url in $urls; do
   name="$(basename "$url" | cut -d '?' -f 1)"
   if [ ${#name} -gt 255 ]; then
       name="$(printf '%s' "$name" | md5sum | cut -d ' ' -f 1).tdlv"
   fi
   file="$tmpdir/$name"
   files="$(printf '%s\n%s' "$files" "$file")"
   curls="$(printf '%s\n--url "%s"\n-o "%s"' "$curls" "$url" "$file")"
done
files="$(echo "$files" | tail -n +2)"
curls="$(echo "$curls" | tail -n +2)"

echo "$curls" | curl -sS -L -Z --parallel-max 24 --no-clobber -K -
echo "$files" | $cmd
