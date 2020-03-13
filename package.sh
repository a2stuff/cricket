#!/bin/bash

# Use Cadius to create a disk image for distribution
# https://github.com/mach-kernel/cadius

set -e

PACKDIR="out/package"
FINFO="$PACKDIR/_FileInformation.txt"
IMGFILE="cricket.po"
VOLNAME="cricket"

mkdir -p "$PACKDIR"
echo "" > "$FINFO"

# Copy renamed files (with type/auxtype info) into package directory.

cp "out/ns.clock.system.SYS" "$PACKDIR/ns.clock.system#FF0000"
cp "out/cricket.system.SYS" "$PACKDIR/cricket.system#FF0000"
cp "out/test.BIN" "$PACKDIR/test#062000"
cp "out/date.BIN" "$PACKDIR/date#062000"
cp "out/set.date.BIN" "$PACKDIR/set.date#062000"
cp "out/set.time.BIN" "$PACKDIR/set.time#062000"
\
# Create a new disk image.

rm -f "$IMGFILE"

cadius CREATEVOLUME "$IMGFILE" "$VOLNAME" 140KB --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/ns.clock.system#FF0000" --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/cricket.system#FF0000" --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/test#062000" --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/date#062000" --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/set.date#062000" --no-case-bits --quiet
cadius ADDFILE "$IMGFILE" "/$VOLNAME" "$PACKDIR/set.time#062000" --no-case-bits --quiet

rm -r "$PACKDIR"

cadius CATALOG "$IMGFILE"
