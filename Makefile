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
PLATFORM = $(shell uname --machine)
CODENAME = $(shell lsb_release -c | awk '{ print $$2 }')

# clear out suffixes; we don't need them anyway
.SUFFIXES:

# Locations of symlinks.  Their source files are below
TARGETS=${DESTDIR}/.emacs.d \
	${DESTDIR}/.bash_profile \
	${DESTDIR}/.config/git/config \
	${DESTDIR}/.config/git/ignore \
	${DESTDIR}/bin/power_menu \
	${DESTDIR}/bin/git-pretty-history \
	${DESTDIR}/.Xdefaults \
	${DESTDIR}/.xprofile \
	${DESTDIR}/.bundle/config \
	${DESTDIR}/.byobu/.tmux.conf \
	${DESTDIR}/.byobu/keybindings.tmux \
	${DESTDIR}/.config/kitty/kitty.conf \
	${DESTDIR}/.config/i3/config \
	${DESTDIR}/.config/i3/i3-battery-popup \
	${DESTDIR}/.config/i3/lock.sh \
	${DESTDIR}/.config/i3/lock.png \
	${DESTDIR}/.config/picom.conf \
	${DESTDIR}/.irbrc \
	${DESTDIR}/.config/polybar/config \
	${DESTDIR}/.config/polybar/start.sh \
	${DESTDIR}/.config/polybar/spotify-status \
	${DESTDIR}/.config/rofi/config.rasi \
	${DESTDIR}/.config/rofi/slate.rasi \
	${DESTDIR}/.config/rofi/power_menu.rasi \
	${DESTDIR}/.config/libinput-gestures.conf \
	${DESTDIR}/.config/dunst/dunstrc \
	${DESTDIR}/.config/mise/config.toml \
	${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf \
	${DESTDIR}/.local/share/fonts/FiraCodeNerdFont-Regular.ttf \
	${DESTDIR}/.local/share/fonts/FiraCodeNerdFontMono-Regular.ttf \
	${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf \
	${DESTDIR}/.local/share/sounds/camera-shutter.mp3

SYSTEM_TARGETS=/etc/X11/xorg.conf.d/touchpad.conf \
  /usr/local/bin/i3-grid \
  /usr/local/bin/splatmoji \
  /etc/udev/rules.d/50-zsa.rules \
	/usr/share/pam-configs/yubikey

# User service path for systemd
# Probably not super portable
service_path = ${DESTDIR}/.config/systemd/user

# User services that we want to launch
SERVICES=${service_path}/emacs.service \
	${service_path}/ssh-agent.service

# These are sub-modules inside this repository
REMOTES=${srcdir}/bash.d/bash-git-prompt

.PHONY: all install install-desktop uninstall xrdb i3 emacs init clean rustup spotify spotifyd byobu targets services work fonts user keyboard pam  yubikey-setup yubikey-reset mise

# Source files for our symlinks
${DESTDIR}/.emacs.d: ${srcdir}/emacs
${DESTDIR}/.bash_profile: ${srcdir}/bash.d/profile ${srcdir}/bash.d/bash-git-prompt
${DESTDIR}/.config/git/config: ${srcdir}/gitconf/config
${DESTDIR}/.config/git/ignore: ${srcdir}/gitconf/ignore
${DESTDIR}/bin/git-pretty-history: ${srcdir}/gitconf/git-pretty-history
${DESTDIR}/bin/power_menu: ${srcdir}/bin/power_menu
${DESTDIR}/.Xdefaults: ${srcdir}/x/defaults
${DESTDIR}/.xprofile: ${srcdir}/x/profile
${DESTDIR}/.irbrc: ${srcdir}/irbrc
${DESTDIR}/.bundle/config: ${srcdir}/bundler
${DESTDIR}/.byobu/.tmux.conf: ${srcdir}/byobu/.tmux.conf
${DESTDIR}/.byobu/keybindings.tmux: ${srcdir}/byobu/keybindings.tmux
${DESTDIR}/.config/kitty/kitty.conf: ${srcdir}/kitty/conf
${DESTDIR}/.config/i3/config: ${srcdir}/i3/config
${DESTDIR}/.config/i3/i3-battery-popup: ${srcdir}/i3/i3-battery-popup
${DESTDIR}/.config/i3/lock.sh: ${srcdir}/i3/lock.sh
${DESTDIR}/.config/i3/lock.png: ${srcdir}/i3/lock.png
${DESTDIR}/.config/picom.conf: ${srcdir}/i3/picom.conf
${DESTDIR}/.config/polybar/config: ${srcdir}/polybar/config
${DESTDIR}/.config/polybar/start.sh: ${srcdir}/polybar/start.sh
${DESTDIR}/.config/polybar/spotify-status: ${srcdir}/polybar/spotify-status
${DESTDIR}/.config/rofi/config.rasi: ${srcdir}/rofi/config
${DESTDIR}/.config/rofi/slate.rasi: ${srcdir}/rofi/slate.rasi
${DESTDIR}/.config/rofi/power_menu.rasi: ${srcdir}/rofi/power_menu.rasi
${DESTDIR}/.config/libinput-gestures.conf: ${srcdir}/libinput-gestures/libinput-gestures.conf
${DESTDIR}/.config/dunst/dunstrc: ${srcdir}/i3/dunst.conf
${DESTDIR}/.config/mise/config.toml: ${srcdir}/mise/config.toml
${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf: ${srcdir}/fonts/PowerlineExtraSymbols.otf
${DESTDIR}/.local/share/fonts/FiraCodeNerdFont-Regular.ttf: ${srcdir}/fonts/FiraCodeNerdFont-Regular.ttf
${DESTDIR}/.local/share/fonts/FiraCodeNerdFontMono-Regular.ttf: ${srcdir}/fonts/FiraCodeNerdFontMono-Regular.ttf
${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf: ${srcdir}/fonts/Font-Awesome-6-Free-Regular-400.otf
${DESTDIR}/.local/share/sounds/camera-shutter.mp3: ${srcdir}/sounds/camera-shutter.mp3

# System level symlinks
/etc/X11/xorg.conf.d/touchpad.conf: ${srcdir}/x/touchpad.conf
/usr/local/bin/i3-grid: ${srcdir}/bin/i3-grid /usr/local/src/i3-grid/i3-grid.py
/usr/local/bin/splatmoji: /usr/local/src/splatmoji/splatmoji
/etc/udev/rules.d/50-zsa.rules: ${srcdir}/udev/50-zsa.rules
/usr/share/pam-configs/yubikey: ${srcdir}/pam/yubikey

# Service links and their dependencies
${service_path}/emacs.service: ${srcdir}/systemd/emacs.service /usr/bin/emacs
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

# TODO: Install jq
work: /usr/local/bin/aws /usr/bin/kubectl /usr/bin/docker

fonts: /usr/share/fonts/truetype/firacode/FiraCode-Regular.ttf /usr/share/fonts/truetype/noto/NotoSansSymbols2-Regular.ttf /usr/share/fonts/truetype/noto/NotoColorEmoji.ttf ${DESTDIR}/.local/share/fonts/PowerlineExtraSymbols.otf ${DESTDIR}/.local/share/fonts/Font-Awesome-6-Free-Regular-400.otf

# Install things used by terminal-only applications
install: targets services emacs mise rustup byobu pam /usr/bin/delta /usr/bin/fzf /usr/bin/bat

# Install everything needed for a working DE
install-desktop: install i3 /snap/bin/firefox /snap/bin/thunderbird /usr/bin/xdg-open

# Stuff used by i3 and my extensions to it
i3: /usr/bin/startx /usr/bin/i3-msg /usr/local/bin/i3-grid /usr/bin/i3lock /usr/bin/xss-lock /usr/local/bin/splatmoji /usr/bin/libinput-gestures /usr/bin/rofi /usr/bin/hsetroot /usr/bin/redshift /usr/bin/scrot /usr/bin/polybar /usr/bin/kitty /usr/bin/autorandr /usr/bin/mogrify /usr/bin/picom /usr/bin/dunst fonts

keyboard: ${DESTDIR}/bin/wally

${DESTDIR}/bin/wally:
	sudo apt install libusb-1.0-0-dev
	curl -L "https://configure.ergodox-ez.com/wally/linux" -o $@
	chmod +x $@

/usr/local/bin/aws: /usr/local/bin/session-manager-plugin
	curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip"
	unzip -d /tmp /tmp/awscliv2.zip
	sudo /tmp/aws/install
	rm -r /tmp/aws /tmp/awscliv2.zip

/usr/local/bin/session-manager-plugin:
	curl "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb" -o "/tmp/session-manager-plugin.deb"
	sudo apt install --yes /tmp/session-manager-plugin.deb
	rm /tmp/session-manager-plugin.deb

/etc/apt/keyrings/kubernetes-apt-keyring.gpg:
	curl -fsSL 'https://pkgs.k8s.io/core:/stable:/v1.28/deb/Release.key' | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

/etc/apt/sources.list.d/kubernetes.list: /etc/apt/keyrings/kubernetes-apt-keyring.gpg
	echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.28/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list
	sudo apt update

/usr/bin/kubectl: /etc/apt/sources.list.d/kubernetes.list
	sudo apt install --yes kubectl

/etc/apt/keyrings/docker.gpg:
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
	sudo chmod a+r /etc/apt/keyrings/docker.gpg

/etc/apt/sources.list.d/docker.list: /etc/apt/keyrings/docker.gpg
	echo "deb [arch="${ARCH}" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu "${CODENAME}" stable" | sudo tee /etc/apt/sources.list.d/docker.list
	sudo apt update

/usr/bin/docker: /etc/apt/sources.list.d/docker.list
	sudo apt-get install --yes docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
	sudo adduser ${USER} docker

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
	sudo apt remove --yes i3lock

/usr/bin/hsetroot:
	sudo apt install --yes hsetroot

/usr/bin/xss-lock:
	sudo apt install --yes xss-lock

/usr/bin/rofi:
	sudo apt install --yes rofi

/usr/bin/kitty:
	sudo apt install --yes kitty
	sudo update-alternatives --set x-terminal-emulator $@

/usr/bin/autorandr:
	sudo apt install --yes autorandr

/usr/share/fonts/truetype/firacode/FiraCode-Regular.ttf:
	sudo apt install --yes fonts-firacode

/usr/share/fonts/truetype/noto/NotoSansSymbols2-Regular.ttf:
	sudo apt install --yes fonts-noto-core

/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf:
	sudo apt install --yes fonts-noto-color-emoji

/usr/local/src/i3-grid/i3-grid.py:
	sudo mkdir -p "$(@D)"
	sudo chown root:chall "$(@D)"
	sudo chmod g+w "$(@D)"
	git clone https://github.com/lukeshimanuki/i3-grid.git "$(@D)"

/usr/bin/i3lock: /usr/local/src/i3lock-color/README.md
	sudo apt install --yes autoconf gcc make pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev
	cd "$(<D)"; ./install-i3lock-color.sh

/usr/local/src/i3lock-color/README.md:
	sudo mkdir -p "$(@D)"
	sudo chown root:chall "$(@D)"
	sudo chmod g+w "$(@D)"
	git clone --sparse --no-checkout https://github.com/Raymo111/i3lock-color.git "$(@D)"
	cd "$(@D)"; git checkout 46aa0b37196994433addddd60bb735dd4a388e6b

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
	sudo dpkg -i ${srcdir}/gitconf/git-delta_0.16.5_amd64.deb

/usr/bin/redshift:
	sudo apt install --yes redshift

${HOME}/.ssh/authorized_keys: /usr/bin/pkcs11-tool
	ssh-keygen -D /usr/lib/${PLATFORM}-linux-gnu/opensc-pkcs11.so >> $@

/usr/lib/${PLATFORM}-linux-gnu/security/libpam-p11.so:
	sudo apt install --yes libpam-p11

/usr/bin/pkcs11-tool:
	sudo apt install --yes opensc

/usr/bin/yubico-piv-tool:
	sudo atp install --yes ykcs11

/usr/bin/picom: ${DESTDIR}/.config/picom.conf
	sudo apt install --yes picom

/usr/bin/dunst: ${DESTDIR}/.config/dunst/dunstrc
	sudo apt install --yes dunst

yubikey-setup: /usr/bin/pkcs11-tool /usr/bin/yubico-piv-tool
# Create Authentication Key
	pkcs11-tool --module /usr/lib/x86_64-linux-gnu/libykcs11.so -k --key-type rsa:2048 --usage-sign --usage-decrypt --login --id 01 --login-type so --so-pin 010203040506070801020304050607080102030405060708 --label defaultkey
# Create Key Management Key
	pkcs11-tool --module /usr/lib/x86_64-linux-gnu/libykcs11.so -k --key-type EC:prime256v1 --usage-sign --usage-decrypt --login --id 03 --login-type so --so-pin 010203040506070801020304050607080102030405060708 --label defaultkey

yubikey-reset: /usr/bin/yubico-piv-tool
	yubico-piv-tool --action reset
	$(MAKE) yubikey-setup
	rm ${HOME}/.ssh/authorized_keys
	$(MAKE) ${HOME}/.ssh/authorized_keys

pam: ${HOME}/.ssh/authorized_keys /usr/share/pam-configs/yubikey /usr/bin/pkcs11-tool /usr/bin/yubico-piv-tool
	sudo pam-auth-update --enable yubikey

# TODO: Unistall for emacs
emacs: /usr/bin/emacs

mise: /usr/bin/mise ${DESTDIR}/.config/mise/config.toml ${HOME}/.local/share/bash-completion/completions/mise

${HOME}/.local/share/bash-completion/completions/mise:
	mkdir -p $(@D)
	mise use -g usage
	mise completion bash --include-bash-completion-lib > ~/.local/share/bash-completion/completions/mise

/etc/apt/keyrings/mise-archive-keyring.gpg:
	wget -qO - "https://mise.jdx.dev/gpg-key.pub" | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg 1> /dev/null

/etc/apt/sources.list.d/mise.list:
	echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=amd64] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list
	sudo apt update

/usr/bin/mise: /etc/apt/keyrings/mise-archive-keyring.gpg /etc/apt/sources.list.d/mise.list
	sudo apt install --yes mise

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
	sudo apt install emacs-lucid

/usr/bin/xclip:
	sudo apt install --yes xclip

${HOME}/.cargo/bin/rustup:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
