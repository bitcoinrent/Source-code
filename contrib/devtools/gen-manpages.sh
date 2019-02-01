#!/usr/bin/env bash

export LC_ALL=C
TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
BUILDDIR=${BUILDDIR:-$TOPDIR}

BINDIR=${BINDIR:-$BUILDDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

BITCOINRENTD=${BITCOINRENTD:-$BINDIR/bitcoinrentd}
BITCOINRENTCLI=${BITCOINRENTCLI:-$BINDIR/bitcoinrent-cli}
BITCOINRENTTX=${BITCOINRENTTX:-$BINDIR/bitcoinrent-tx}
BITCOINRENTQT=${BITCOINRENTQT:-$BINDIR/qt/bitcoinrent-qt}

[ ! -x $BITCOINRENTD ] && echo "$BITCOINRENTD not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
BTTVER=($($BITCOINRENTCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for bitcoinrentd if --version-string is not set,
# but has different outcomes for bitcoinrent-qt and bitcoinrent-cli.
echo "[COPYRIGHT]" > footer.h2m
$BITCOINRENTD --version | sed -n '1!p' >> footer.h2m

for cmd in $BITCOINRENTD $BITCOINRENTCLI $BITCOINRENTTX $BITCOINRENTQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${BTTVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${BTTVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
