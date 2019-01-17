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
	${DESTDIR}/bin/git-pretty-history \
	${DESTDIR}/.Xdefaults \
	${DESTDIR}/.rvmrc

REMOTES=${srcdir}/bash.d/bash-git-prompt

.PHONY: all install uninstall xrdb init clean

all: $(TARGETS)

install: all
	${srcdir}/install-all.sh

${DESTDIR}/.emacs.d: ${srcdir}/emacs
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile
${DESTDIR}/.gitconfig: ${srcdir}/gitconf/config
${DESTDIR}/bin/git-pretty-history: ${srcdir}/gitconf/git-pretty-history
${DESTDIR}/.Xdefaults: ${srcdir}/x/defaults
${DESTDIR}/.rvmrc: ${srcdir}/rvmrc

$(REMOTES): init

$(TARGETS):
	mkdir -p ${@D}
	ln -s $< $@

# Cleanup
uninstall:
	${srcdir}/uninstall-all.sh
	rm $(TARGETS) # must be run _after_ uninstall script

clean:
	rm $(TARGETS)

# Utility targets
xrdb: ${DESTDIR}/.Xdefaults ${DESTDIR}/.Xresources
	xrdb -merge -I${HOME} $^

init:
	git submodule update --init --recursive
