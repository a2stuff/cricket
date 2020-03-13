#!/bin/bash

# Use Cadius to create a disk image for distribution
# https://github.com/mach-kernel/cadius

set -e

PACKDIR=$(mktemp -d)
IMGFILE="out/cricket.po"
VOLNAME="cricket"

rm -f "$IMGFILE"
cadius CREATEVOLUME "$IMGFILE" "$VOLNAME" 140KB --no-case-bits --quiet

add_file () {
    cp "$1" "$PACKDIR/$2"
    cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/$2" --no-case-bits --quiet
}

add_file "out/ns.clock.system.SYS" "ns.clock.system#FF0000"
add_file "out/cricket.system.SYS" "cricket.system#FF0000"
add_file "out/test.BIN" "test#062000"
add_file "out/date.BIN" "date#062000"
add_file "out/set.date.BIN" "set.date#062000"
add_file "out/set.time.BIN" "set.time#062000"

rm -r "$PACKDIR"

cadius CATALOG "$IMGFILE"
