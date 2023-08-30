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

ARCH = $(shell dpkg --print-architecture)
CODENAME = $(shell lsb_release -c | awk '{ print $$2 }')

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
	${DESTDIR}/.config/i3/i3-battery-popup \
	${DESTDIR}/.config/i3/lock.sh \
	${DESTDIR}/.config/i3/lock.png \
	${DESTDIR}/.config/polybar/config \
	${DESTDIR}/.config/polybar/start.sh \
	${DESTDIR}/.config/polybar/spotify-status \
	${DESTDIR}/.config/rofi/config.rasi \
	${DESTDIR}/.config/rofi/slate.rasi \
	${DESTDIR}/.config/rofi/power_menu.rasi \
	${DESTDIR}/.config/libinput-gestures.conf \
	${DESTDIR}/.rvm/hooks/after_cd_nvm \
	${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf \
	${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf

SYSTEM_TARGETS=/etc/X11/xorg.conf.d/touchpad.conf

# User service path for systemd
# Probably not super portable
service_path = ${DESTDIR}/.config/systemd/user

# User services that we want to launch
SERVICES=${service_path}/emacs.service \
	${service_path}/ssh-agent.service

# These are sub-modules inside this repository
REMOTES=${srcdir}/bash.d/bash-git-prompt

.PHONY: all install install-desktop uninstall xrdb i3 emacs init clean rvm nvm pyenv rustup spotify spotifyd byobu targets services work fonts user

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
${DESTDIR}/.config/i3/i3-battery-popup: ${srcdir}/i3/i3-battery-popup
${DESTDIR}/.config/i3/lock.sh: ${srcdir}/i3/lock.sh
${DESTDIR}/.config/i3/lock.png: ${srcdir}/i3/lock.png
${DESTDIR}/.config/polybar/config: ${srcdir}/polybar/config
${DESTDIR}/.config/polybar/start.sh: ${srcdir}/polybar/start.sh
${DESTDIR}/.config/polybar/spotify-status: ${srcdir}/polybar/spotify-status
${DESTDIR}/.config/rofi/config.rasi: ${srcdir}/rofi/config
${DESTDIR}/.config/rofi/slate.rasi: ${srcdir}/rofi/slate.rasi
${DESTDIR}/.config/rofi/power_menu.rasi: ${srcdir}/rofi/power_menu.rasi
${DESTDIR}/.config/libinput-gestures.conf: ${srcdir}/libinput-gestures/libinput-gestures.conf
${DESTDIR}/.rvm/hooks/after_cd_nvm: ${srcdir}/rvm_hacks/after_cd_nvm
${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf: ${srcdir}/fonts/PowerlineExtraSymbols.otf
${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf: ${srcdir}/fonts/Font-Awesome-6-Free-Regular-400.otf

# System level symlinks
/etc/X11/xorg.conf.d/touchpad.conf: ${srcdir}/x/touchpad.conf

# Service links and their dependencies
${service_path}/emacs.service: ${srcdir}/systemd/emacs.service /usr/share/rvm/wrappers/emacs ${HOME}/.nvm/alias/emacs /usr/bin/emacs
${service_path}/ssh-agent.service: ${srcdir}/systemd/ssh-agent.service

$(REMOTES): init

$(TARGETS):
	mkdir -p ${@D}
	ln -sf $< $@

$(SYSTEM_TARGETS):
	sudo mkdir -p ${@D}
	sudo ln -sf $< $@

$(SERVICES):
	systemctl --user enable $<
	systemctl --user start "$(notdir $<)"

init:
	git submodule update --init --recursive

targets: $(TARGETS) $(SYSTEM_TARGETS)

services: $(SERVICES)

work: /usr/local/bin/aws /usr/bin/kubectl

fonts: /usr/share/fonts/truetype/firacode/FiraCode-Regular.ttf /usr/share/fonts/truetype/noto/NotoSansSymbols2-Regular.ttf /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf ${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf ${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf

user: rvm nvm pyenv

# Install things used by terminal-only applications
install: targets services emacs rvm nvm pyenv rustup byobu /usr/bin/delta /usr/bin/fzf /usr/bin/bat

# Install everything needed for a working DE
install-desktop: install i3 /snap/bin/firefox /snap/bin/thunderbird /usr/bin/xdg-open

# Stuff used by i3 and my extensions to it
i3: /usr/bin/startx /usr/bin/i3-msg /usr/local/bin/i3-grid /usr/bin/xss-lock /usr/local/bin/splatmoji /usr/bin/libinput-gestures /usr/bin/rofi /usr/bin/hsetroot /usr/bin/redshift /usr/bin/scrot /usr/bin/polybar /usr/bin/kitty /usr/bin/autorandr /usr/bin/mogrify fonts

/usr/local/bin/aws: /usr/local/bin/session-manager-plugin
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
	unzip -d /tmp /tmp/awscliv2.zip
	sudo /tmp/aws/install
	rm -r /tmp/aws /tmp/awscliv2.zip

/usr/local/bin/session-manager-plugin:
	curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
	sudo apt install --yes /tmp/session-manager-plugin.deb
	rm /tmp/session-manager-plugin.deb

/etc/apt/sources.list.d/kubernetes.list: /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt update

/etc/apt/keyrings/kubernetes-apt-keyring.gpg:
	curl -fsSL 'https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key' | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

/usr/bin/kubectl: /etc/apt/sources.list.d/kubernetes.list
	sudo apt install --yes kubectl

/usr/bin/xdg-open:
	sudo apt install --yes xdg-utils

/snap/bin/firefox:
	sudo snap install firefox

/snap/bin/thunderbird:
	sudo snap install thunderbird

/usr/bin/startx:
	sudo apt install --yes xorg

/usr/bin/i3-msg:
	sudo apt install --yes i3

/usr/bin/hsetroot:
	sudo apt install --yes hsetroot

/usr/bin/xss-lock:
	sudo apt install --yes xss-lock

/usr/bin/rofi:
	sudo apt install --yes rofi

/usr/bin/kitty:
	sudo apt install --yes kitty

/usr/bin/autorandr:
	sudo apt install --yes autorandr

/usr/share/fonts/truetype/firacode/FiraCode-Regular.ttf:
	sudo apt install --yes fonts-firacode

/usr/share/fonts/truetype/noto/NotoSansSymbols2-Regular.ttf:
	sudo apt install --yes fonts-noto-core

/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf:
	sudo apt install --yes fonts-noto-color-emoji

/usr/local/bin/i3-grid: /usr/local/src/i3-grid/i3-grid.py
	chmod +x ${srcdir}/bin/i3-grid
	sudo ln -fs ${srcdir}/bin/i3-grid $@

/usr/local/src/i3-grid/i3-grid.py:
	sudo mkdir -p /usr/local/src/i3-grid
	sudo chown root:chall /usr/local/src/i3-grid
	sudo chmod g+w /usr/local/src/i3-grid
	git clone https://github.com/lukeshimanuki/i3-grid.git /usr/local/src/i3-grid

/usr/local/bin/splatmoji: /usr/local/src/splatmoji/splatmoji
	sudo ln -s /usr/local/src/splatmoji/splatmoji $@

/usr/bin/scrot:
	sudo apt install --yes scrot

/usr/bin/mogrify:
	sudo apt install --yes imagemagick

/usr/bin/unzip:
	sudo apt install --yes unzip

/usr/bin/polybar: fonts /var/log/polybar
	sudo apt install --yes polybar

/var/log/polybar:
	sudo mkdir /var/log/polybar
	sudo chown root:${USER} /var/log/polybar
	sudo chmod g+w /var/log/polybar

/usr/local/src/splatmoji/splatmoji:
	sudo mkdir -p /usr/local/src/splatmoji
	sudo chown root:chall /usr/local/src/splatmoji
	sudo chmod g+w /usr/local/src/splatmoji
	git clone https://github.com/cspeterson/splatmoji.git /usr/local/src/splatmoji/
	sed -i'' -e 's/xsel_command.*/xsel_command=xclip -selection clipboard/' /usr/local/src/splatmoji/splatmoji.config

/usr/bin/libinput-gestures: /usr/local/src/libinput-gestures/Makefile
	sudo gpasswd -a ${USER} input
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
	sudo apt install --yes bat

/usr/bin/fzf:
	sudo apt install --yes fzf

/usr/bin/delta:
	sudo dpgk -i ${srcdir}/gitconf/git-delta_0.16.5_amd64.deb

/usr/bin/redshift:
	sudo apt install --yes redshift

# TODO: Unistall for emacs
emacs: /usr/bin/emacs /usr/share/rvm/wrappers/emacs ${HOME}/.nvm/alias/emacs

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

# Utility targets
xrdb: ${DESTDIR}/.Xdefaults ${DESTDIR}/.Xresources
	xrdb -merge -I${HOME} $^

/usr/bin/emacs: ${DESTDIR}/.emacs.d /usr/bin/xclip
	sudo apt install emacs

/usr/bin/xclip:
	sudo apt install --yes xclip

/usr/share/rvm/wrappers/emacs: /usr/share/rvm/bin/rvm
	/usr/share/rvm/bin/rvm install 3.2.2
	/usr/share/rvm/bin/rvm 3.2.2 gemset create emacs
	/usr/share/rvm/bin/rvm alias create --create emacs 3.2.2@emacs

${HOME}/.nvm/alias/emacs: ${HOME}/.nvm/nvm.sh
	/bin/bash -lc "source ~/.nvm/nvm.sh; nvm install lts/hydrogen; nvm alias emacs lts/hydrogen"

/usr/share/rvm/bin/rvm:
	sudo apt-add-repository -y ppa:rael-gc/rvm
	sudo apt-get install --yes rvm
	sudo adduser ${USER} rvm

${HOME}/.nvm/nvm.sh:
	curl -o- 'https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh' | bash

${HOME}/.pyenv/bin/pyenv:
	curl -L 'https://raw.githubusercontent.com/pyenv/pyenv-installer/dd3f7d0914c5b4a416ca71ffabdf2954f2021596/bin/pyenv-installer' | bash

${HOME}/.cargo/bin/rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
