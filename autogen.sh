#!/bin/bash

srcdir=`dirname $0`
test -z "$srcdir" && srcdir=.

pushd $srcdir >/dev/null

if [ "$1" = "clean" ]; then
  [ -f "Makefile" ] && make maintainer-clean

  rm -f aclocal.m4 configure missing install-sh \
    depcomp ltmain.sh config.guess config.sub \
    config.h.in `find . -name Makefile.in` compile
  rm -rf autom4te.cache

  popd &>/dev/null
  exit 0
fi

touch ChangeLog INSTALL

autoreconf -ifv
result=$?

if [ $result -eq 0 ] && [ -z "$NOCONFIGURE" ]; then
  "$srcdir/configure" "$@"
  result=$?
fi

popd >/dev/null

exit $result
