######################################
#    General installation Makefile   #
######################################
# After working on this for a while, I begin to understand just how easy these
# things can become so dense that they're basically impossible for all but the
# original author (or those _very_ well versed in Makefiles) to understand.
#
# I've done my best to document this file, but some things here stretch my own
# understanding to the point where it's difficult for me to describe them.
######################################

# Ensure a consistent shell
SHELL = /bin/sh

# Set destination to the home dir of the current user
DESTDIR = ${HOME}

# Set srcdir based on our config dir
srcdir = ${abspath .}

# Grab some architecture information for use elsewhere.
# Mostly used when installing stuff from source for some multi-arch support
uname_s = $(shell uname -s | tr '[:upper:]' '[:lower:]')
uname_m = $(shell uname -m)

# Converts the uname versions of these things to their "common" names
COMMON_ARCH.x86_64 = amd64
COMMON_ARCH.aarch64 = arm64

# clear out suffixes; we don't need them anyway
.SUFFIXES:

# Locations of symlinks.  Their source files are below
TARGETS=${DESTDIR}/.emacs.d \
	${DESTDIR}/.bash_profile \
	${DESTDIR}/.gitconfig \
	${DESTDIR}/bin/power_menu \
	${DESTDIR}/bin/git-pretty-history \
	${DESTDIR}/.Xdefaults \
	${DESTDIR}/.xprofile \
	${DESTDIR}/.rvmrc \
	${DESTDIR}/.bundle/config \
	${DESTDIR}/.byobu/.tmux.conf \
	${DESTDIR}/.byobu/keybindings.tmux \
	${DESTDIR}/.config/kitty/kitty.conf \
	${DESTDIR}/.config/i3/config \
	${DESTDIR}/.config/i3/lock.sh \
	${DESTDIR}/.config/i3/lock.png \
	${DESTDIR}/.config/polybar/config \
	${DESTDIR}/.config/polybar/start.sh \
	${DESTDIR}/.config/polybar/spotify-status \
	${DESTDIR}/.config/rofi/config \
	${DESTDIR}/.config/rofi/slate.rasi \
	${DESTDIR}/.config/rofi/power_menu.rasi \
	${DESTDIR}/.config/libinput-gestures.conf \
	${DESTDIR}/.config/compton.conf \
	${DESTDIR}/.rvm/hooks/after_cd_nvm

# User service path for systemd
# Probably not super portable
service_path = ${DESTDIR}/.config/systemd/user

# User services that we want to launch
SERVICES=${service_path}/emacs.service \
	${service_path}/ssh-agent.service

# These are sub-modules inside this repository
REMOTES=${srcdir}/bash.d/bash-git-prompt

.PHONY: all install install-desktop uninstall xrdb i3 emacs init clean rvm nvm pyenv rustup spotify spotifyd byobu targets services

# Source files for our symlinks
${DESTDIR}/.emacs.d: ${srcdir}/emacs
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile ${srcdir}/bash.d/bash-git-prompt
${DESTDIR}/.gitconfig: ${srcdir}/gitconf/config
${DESTDIR}/bin/git-pretty-history: ${srcdir}/gitconf/git-pretty-history
${DESTDIR}/bin/power_menu: ${srcdir}/bin/power_menu
${DESTDIR}/.Xdefaults: ${srcdir}/x/defaults
${DESTDIR}/.xprofile: ${srcdir}/x/profile
${DESTDIR}/.rvmrc: ${srcdir}/rvmrc
${DESTDIR}/.bundle/config: ${srcdir}/bundler
${DESTDIR}/.byobu/.tmux.conf: ${srcdir}/byobu/.tmux.conf
${DESTDIR}/.byobu/keybindings.tmux: ${srcdir}/byobu/keybindings.tmux
${DESTDIR}/.config/kitty/kitty.conf: ${srcdir}/kitty/conf
${DESTDIR}/.config/i3/config: ${srcdir}/i3/config
${DESTDIR}/.config/i3/lock.sh: ${srcdir}/i3/lock.sh
${DESTDIR}/.config/i3/lock.png: ${srcdir}/i3/lock.png
${DESTDIR}/.config/polybar/config: ${srcdir}/polybar/config
${DESTDIR}/.config/polybar/start.sh: ${srcdir}/polybar/start.sh
${DESTDIR}/.config/polybar/spotify-status: ${srcdir}/polybar/spotify-status
${DESTDIR}/.config/rofi/config: ${srcdir}/rofi/config
${DESTDIR}/.config/rofi/slate.rasi: ${srcdir}/rofi/slate.rasi
${DESTDIR}/.config/rofi/power_menu.rasi: ${srcdir}/rofi/power_menu.rasi
${DESTDIR}/.config/libinput-gestures.conf: ${srcdir}/libinput-gestures/libinput-gestures.conf
${DESTDIR}/.config/compton.conf: ${srcdir}/i3/compton.conf
${DESTDIR}/.rvm/hooks/after_cd_nvm: ${srcdir}/rvm_hacks/after_cd_nvm

# Service links and their dependencies
${service_path}/emacs.service: ${srcdir}/systemd/emacs.service /usr/share/rvm/wrappers/emacs /usr/local/bin/emacs
${service_path}/ssh-agent.service: ${srcdir}/systemd/ssh-agent.service

$(REMOTES): init

$(TARGETS):
	mkdir -p ${@D}
	ln -sf $< $@

$(SERVICES):
	systemctl --user enable $<
	systemctl --user start "$(notdir $<)"

init:
	git submodule update --init --recursive

targets: $(TARGETS)

services: $(SERVICES)

# Install things used by terminal-only applications
install: targets services emacs rvm nvm pyenv rustup byobu /usr/bin/delta /usr/bin/fzf /usr/bin/bat

# Install additional GUI applications for the DE
install-desktop: install spotify i3

# Stuff used by i3 and my extensions to it
i3: /usr/bin/i3-msg /usr/local/bin/i3-grid /usr/bin/xss-lock /usr/bin/compton /usr/local/bin/splatmoji /usr/bin/libinput-gestures /usr/bin/rofi /usr/bin/hsetroot /usr/bin/redshift

/usr/bin/i3-msg:
	sudo apt install --yes i3

/usr/bin/hsetroot:
	sudo apt install --yes hsetroot

/usr/bin/xss-lock:
	sudo apt install --yes xss-lock

/usr/bin/rofi:
	sudo apt install --yes rofi

/usr/bin/compton: ${DESTDIR}/.config/compton.conf
	sudo apt install --yes compton

/usr/local/bin/i3-grid: /usr/local/src/i3-grid/i3-grid.py
	ln -s ${srcdir}/bin/i3-grid $@

/usr/local/src/i3-grid/i3-grid.py:
	sudo mkdir -p /usr/local/src/i3-grid
	sudo chown root:chall /usr/local/src/i3-grid
	sudo chmod g+w /usr/local/src/i3-grid
	git clone git@github.com:lukeshimanuki/i3-grid.git /usr/local/src/i3-grid

/usr/local/bin/splatmoji: /usr/local/src/splatmoji/splatmoji
	sudo ln -s /usr/local/src/splatmoji/splatmoji $@

/usr/local/src/splatmoji/splatmoji:
	sudo mkdir -p /usr/local/src/splatmoji
	sudo chown root:chall /usr/local/src/splatmoji
	sudo chmod g+w /usr/local/src/splatmoji
	git clone git@github.com:cspeterson/splatmoji.git /usr/local/src/splatmoji/
	sed -i'' -e 's/xsel_command.*/xsel_command=xclip -selection clipboard/' /usr/local/src/splatmoji/splatmoji.config

/usr/bin/libinput-gestures: /usr/local/src/libinput-gestures/Makefile
	sudo gpasswd -a $USER input
	sudo apt install --yes libinput-tools
	$(MAKE) -C /usr/local/src/libinput-gestures

/usr/local/src/libinput-gestures/Makefile:
	sudo mkdir -p /usr/local/src/libinput-gestures
	sudo chown root:chall /usr/local/src/libinput-gestures
	sudo chmod g+w /usr/local/src/libinput-gestures
	git clone https://github.com/bulletmark/libinput-gestures.git /usr/local/src/libinput-gestures

byobu: /usr/bin/byobu ${DESTDIR}/.byobu/.tmux.conf ${DESTDIR}/.byobu/keybindings.tmux

/usr/bin/byobu:
	sudo apt install --yes byobu

/usr/bin/bat:
	curl -L https://github.com/sharkdp/bat/releases/download/v0.18.0/bat_0.18.0_$(COMMON_ARCH.$(uname_m)).deb > /tmp/bat_0.18.0.deb
	sudo dpkg -i /tmp/bat_0.18.0.deb

/usr/bin/fzf:
ifeq ($(shell apt-cache show fzf; $?), 0)
	sudo apt install --yes fzf
else
	curl -L https://github.com/junegunn/fzf/releases/download/0.27.0/fzf-0.27.0-${uname_s}_$(COMMON_ARCH.$(uname_m)).tar.gz | sudo tar -C /usr/bin  -xz
endif

DELTA_VERSION = 0.7.1

/usr/bin/delta:
ifneq ($(shell apt-cache show libgcc-s1), 0)
# These dependencies aren't in the repos for Ubuntu's < 19.10
	curl -L http://ftp.us.debian.org/debian/pool/main/g/gcc-10/gcc-10-base_10.2.1-6_amd64.deb > /tmp/gcc-10-base_10.2.1-6_amd64.deb
	curl -L http://ftp.us.debian.org/debian/pool/main/g/gcc-10/libgcc-s1_10.2.1-6_amd64.deb > /tmp/libgcc-s1_10.2.1-6_amd64.deb
	sudo dpkg -i /tmp/gcc-10-base_10.2.1-6_amd64.deb
	sudo dpkg -i /tmp/libgcc-s1_10.2.1-6_amd64.deb
	rm /tmp/gcc-10-base_10.2.1-6_amd64.deb /tmp/libgcc-s1_10.2.1-6_amd64.deb
endif

	curl -L curl -L https://github.com/dandavison/delta/releases/download/${DELTA_VERSION}/git-delta_${DELTA_VERSION}_$(COMMON_ARCH.$(uname_m)).deb > /tmp/git-delta-${DELTA_VERSION}.deb
	sudo dpkg -i /tmp/git-delta-${DELTA_VERSION}.deb

	rm /tmp/git-delta-${DELTA_VERSION}.deb

/usr/bin/redshift:
	sudo apt install --yes redshift

# TODO: Unistall for emacs
emacs: /usr/local/bin/emacs

rvm: /usr/share/rvm/bin/rvm

nvm: ${DESTDIR}/.nvm/nvm.sh

pyenv: ${DESTDIR}/.pyenv/bin/pyenv

rustup: ${HOME}/.cargo/bin/rustup
	mkdir -p ${HOME}/.local/share/bash-completion/completions/
	${HOME}/.cargo/bin/rustup completions bash > ${HOME}/.local/share/bash-completion/completions/rustup

spotify: spotifyd ${DESTDIR}/bin/spotify-tui

spotifyd: ${DESTDIR}/bin/spotifyd ${DESTDIR}/.config/systemd/user/spotifyd.service
	sudo apt install --yes libsecret-tools
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
	rm -r /tmp/emacs-26.3
	rm -r /tmp/spotifyd-0.2.19

# Utility targets
xrdb: ${DESTDIR}/.Xdefaults ${DESTDIR}/.Xresources
	xrdb -merge -I${HOME} $^

/tmp/emacs-26.3:
	curl -L 'https://ftpmirror.gnu.org/emacs/emacs-26.3.tar.xz' | tar -C '/tmp' -xJ

/usr/local/bin/emacs: /tmp/emacs-26.3
	sudo sed -i'' 's/# deb-src/deb-src/' /etc/apt/sources.list
	sudo apt update
	sudo apt build-dep --yes emacs
	sudo apt install --yes libgnutls28-dev
	cd $^; ./configure
	${MAKE} -C $^
	sudo ${MAKE} -C $^ install

/usr/share/rvm/wrappers/emacs: /usr/share/rvm/bin/rvm
	rvm install 2.6.0
	rvm 2.6.0 gemset create emacs
	rvm alias create --create emacs 2.6.0@emacs

/usr/share/rvm/bin/rvm:
	sudo apt-add-repository -y ppa:rael-gc/rvm
	sudo apt-get install --yes rvm
	sudo useradd ${USER} rvm

${HOME}/.nvm/nvm.sh:
	curl -o- 'https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh' | bash

${HOME}/.pyenv/bin/pyenv:
	curl -L 'https://raw.githubusercontent.com/pyenv/pyenv-installer/dd3f7d0914c5b4a416ca71ffabdf2954f2021596/bin/pyenv-installer' | bash

${HOME}/.cargo/bin/rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

/tmp/spotifyd-0.2.19:
	curl -L 'https://github.com/Spotifyd/spotifyd/archive/v0.2.19.tar.gz' | tar -C '/tmp' -xa

${DESTDIR}/bin/spotifyd: /tmp/spotifyd-0.2.19
	cd $<; cargo build --release --features pulseaudio_backend,dbus_keyring,dbus_mpris
	cp $</target/release/spotifyd $@

${service_path}/spotifyd.service: /tmp/spotifyd-0.2.19
	mkdir -p ${@D}
	sed -e "s|/usr/bin/spotifyd|${DESTDIR}/bin/spotifyd|" $</contrib/spotifyd.service > $@

${DESTDIR}/bin/spotify-tui:
	curl -L https://github.com/Rigellute/spotify-tui/releases/download/v0.7.5/spotify-tui-linux.tar.gz | tar -C ${@D} -xa
	mv ${@D}/spt $<
