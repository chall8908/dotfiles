# Ensure a consistent shell
SHELL = /bin/sh

# Set destination to the home dir of the current user
DESTDIR = ${HOME}

# Set srcdir based on our config dir
srcdir = ${abspath .}

# clear out suffixes; we don't need them anyway
.SUFFIXES:


install:
	ln -s ${srcdir}/.emacs.d ${DESTDIR}/.emacs.d

uninstall:
	rm ${DESTDIR}/.emacs.d
