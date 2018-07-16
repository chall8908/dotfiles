# Ensure a consistent shell 
SHELL = /bin/sh

# Set destination to the home dir of the current user
DESTDIR = ${HOME}

# Set srcdir based on our config dir
srcdir = ${abspath .}

# clear out suffixes; we don't need them anyway
.SUFFIXES:

TARGETS= ${DESTDIR}/.emacs.d ${DESTDIR}/.bash_profile ${DESTDIR}/.gitconfig
REMOTES= ${srcdir}/emacs/.emacs.d ${srcdir}/gitconf/.gitconfig

all: $(TARGETS)

init: $(REMOTES)

${DESTDIR}/.emacs.d: ${srcdir}/emacs/.emacs.d
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile
${DESTDIR}/.gitconfig: ${srcdir}/gitconf/.gitconfig

$(REMOTES):
	git submodule update --init $(dirname $@)

$(TARGETS):
	ln -s $< $@
