#!/bin/sh

BASENAME="$1"
EXTENSION="${BASENAME##*.}"

[ "${BASENAME}" = "${EXTENSION}" ] && EXTENSION=txt
[ -z "${EXTENSION}" ] && EXTENSION=txt

[ "${BASENAME%%.*}" = "Makefile" ] && EXTENSION=mk

exec highlight --force -f -I -O xhtml -S "$EXTENSION" 2>/dev/null
