# Ensure a consistent shell
SHELL = /bin/sh

# Set destination to the home dir of the current user
DESTDIR = ${HOME}

# Set srcdir based on our config dir
srcdir = ${abspath .}

# clear out suffixes; we don't need them anyway
.SUFFIXES:

TARGETS=${DESTDIR}/.emacs.d \
	${DESTDIR}/.bash_profile \
	${DESTDIR}/.gitconfig \
	${DESTDIR}/.Xresources \
	${DESTDIR}/.rvmrc

REMOTES=${srcdir}/emacs \
	${srcdir}/bash.d/bash-git-prompt

.PHONY: all install uninstall xrdb init

all: $(TARGETS)

install:
	${srcdir}/install-all.sh

${DESTDIR}/.emacs.d: ${srcdir}/emacs
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile
${DESTDIR}/.gitconfig: ${srcdir}/gitconf/config
${DESTDIR}/.Xresources: ${srcdir}/.Xresources
${DESTDIR}/.rvmrc: ${srcdir}/rvmrc

$(REMOTES): init

$(TARGETS):
	ln -s $< $@

# Cleanup
uninstall:
	${srcdir}/uninstall-all.sh
	rm $(TARGETS) # must be run _after_ uninstall script

# Utility targets
xrdb: ${DESTDIR}/.Xresources
	xrdb -merge $<

init:
	git submodule update --init --recursive
