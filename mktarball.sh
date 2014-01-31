#!/bin/bash

[[ -f install.wrapper.c &&  -x gen_autotools_stuff.sh ]] || \
	{ echo "Be in the source dir." >&2; exit 1; }

VER=$( echo $( sed -e '/^AC_INIT/ { s/^.*\[xattr-install][^[]*\[//;s/].*$//;t } ; /^AC_INIT/! s/^.*$//' < configure.ac ) )

[[ ${VER} ]] || { echo Cant figure out version >&2; exit 1; }

[[ -d tarball ]] || mkdir -v "$(pwd)"/tarball

tb=(
	--no-xattrs
	--no-selinux
	--no-acls
	--owner=portage
	--group=portage
	--show-transformed-names
	--transform 's|^|xattr-install/|'
	-cJvf
	"tarball/xattr-install-${VER}.tar.xz"
	$( git ls-files | grep -v .gitignore )
)

[[ -f tarball/xattr-install-${VER}.tar.xz ]] && rm -v xattr-install-${VER}.tar.xz

echo "Version detected: ${VER}"
echo "Running: tar ${tb[*]}"
tar "${tb[@]}" || { echo tar failed. >&2 ; exit 1; }
