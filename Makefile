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
	${DESTDIR}/.rvmrc \
	${DESTDIR}/.config/kitty/kitty.conf

REMOTES=${srcdir}/bash.d/bash-git-prompt

.PHONY: all install uninstall xrdb emacs init clean rvm nvm pyenv spotify spotifyd

all: $(TARGETS)

install: all emacs rvm nvm pyenv spotify

# TODO: Unistall for emacs
emacs: /usr/local/bin/emacs

rvm: ${DESTDIR}/.rvm/bin/rvm

nvm: ${DESTDIR}/.nvm/nvm.sh

pyenv: ${DESTDIR}/.pyenv/bin/pyenv

spotify: spotifyd ${DESTDIR}/bin/spt

spotifyd: ${DESTDIR}/bin/spotifyd ${DESTDIR}/.config/systemd/user/spotifyd.service
	sudo apt install -y libsecret-tools
	systemctl --user enable spotifyd.service

# Cleanup
uninstall: clean
	systemctl --user disable spotifyd.service
	systemctl --user stop spotifyd.service
	rm -r ${DESTDIR}/.rvm
	rm -r ${DESTDIR}/.nvm
	rm -r ${DESTDIR}/.pyenv
	rm ${DESTDIR}/.config/systemd/user/spotifyd.service
	rm ${DESTDIR}/bin/spotifyd
	rm ${DESTDIR}/bin/spt
	rm $(TARGETS)
	sudo apt remove -y libsecret-tools
	sudo apt autoremove -y

# Cleans up installation artifacts
# NOTE: This will trigger a recompile of spotifyd if make is run again!!!
clean:
	rm -r ${PERSONAL_DIR}/emacs-26.3
	rm -r ${PERSONAL_DIR}/spotifyd-0.2.19

# Utility targets
xrdb: ${DESTDIR}/.Xdefaults ${DESTDIR}/.Xresources
	xrdb -merge -I${HOME} $^

init:
	git submodule update --init --recursive

${DESTDIR}/.emacs.d: ${srcdir}/emacs
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile
${DESTDIR}/.gitconfig: ${srcdir}/gitconf/config
${DESTDIR}/bin/git-pretty-history: ${srcdir}/gitconf/git-pretty-history
${DESTDIR}/.Xdefaults: ${srcdir}/x/defaults
${DESTDIR}/.rvmrc: ${srcdir}/rvmrc
${DESTDIR}/.config/kitty/kitty.conf: ${srcdir}/kitty/conf

$(REMOTES): init

$(TARGETS):
	mkdir -p ${@D}
	ln -s $< $@

${PERSONAL_DIR}/emacs-26.3:
	curl -L 'https://mirror.clarkson.edu/gnu/emacs/emacs-26.3.tar.xz' | tar -C "${PERSONAL_DIR}" -xa

/usr/local/bin/emacs: ${PERSONAL_DIR}/emacs-26.3
	sudo apt build-dep -y emacs
	cd $^; ./configure
	${MAKE} -C $^
	sudo ${MAKE} -C $^ install

${DESTDIR}/.rvm/bin/rvm:
	gpg --keyserver 'hkp://keys.gnupg.net' --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
	curl -sSL 'https://get.rvm.io' | bash -s stable -- --ignore-dotfiles
	ln -s "${DESTDIR}/.rvm/hooks/after_cd_nvm" "${srcdir}/rvm_hacks/after_cd_nvm"

${DESTDIR}/.nvm/nvm.sh:
	curl -o- 'https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh' | bash

${DESTDIR}/.pyenv/bin/pyenv:
	curl -L 'https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer' | bash

${PERSONAL_DIR}/spotifyd-0.2.19:
	curl -L 'https://github.com/Spotifyd/spotifyd/archive/v0.2.19.tar.gz' | tar -C $PERSONAL_DIR -xa

${DESTDIR}/bin/spotifyd: ${PERSONAL_DIR}/spotifyd-0.2.19
	cd $<; cargo build --release --features pulseaudio_backend,dbus_keyring,dbus_mpris
	cp $</target/release/spotifyd $@

${DESTDIR}/.config/systemd/user/spotifyd.service: ${PERSONAL_DIR}/spotifyd-0.2.19
	mkdir -p ${@D}
	sed -e "s|/usr/bin/spotifyd|${DESTDIR}/bin/spotifyd|" $</contrib/spotifyd.service > $@

${DESTDIR}/bin/spt:
	curl -L https://github.com/Rigellute/spotify-tui/releases/download/v0.7.5/spotify-tui-linux.tar.gz | tar -C ${@D} -xa
