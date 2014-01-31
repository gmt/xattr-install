#!/bin/sh

[[ -f install.wrapper.c &&  -x gen_autotools_stuff.sh ]] || \
	{ echo "Be in the source dir." >&2; exit 1; }

rm -rvf autom4te.cache/ Makefile.in compile configure depcomp install-sh missing aclocal.m4

autoreconf --install

rm -rf autom4te.cache/
