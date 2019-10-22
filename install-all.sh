#!/bin/bash -l

set -euo pipefail

# ensure this isn't run before the system has been configured
if [ -z "$CONFIG_DIR" ] && [! -r "$HOME/.bash_profile"]; then
    echo 'Please perform initial setup with `make` first'
    exit 1
else
    # Source profile, we probably got called during initial setup
    source "$HOME/.bash_profile"
fi

# Install system packages
if ! which emacs &> /dev/null; then
    # Download the "latest", as of this writing, emacs
    echo 'Installing Emacs 26.3..'
    sudo apt build-dep -y emacs
    \curl -L https://mirror.clarkson.edu/gnu/emacs/emacs-26.3.tar.xz | tar -C $PERSONAL_DIR -xa
    pushd "$PERSONAL_DIR/emacs-26.3"
    ./configure
    make
    sudo make install
    popd
else
    echo 'Found Emacs'
fi

if ! which spotifyd &> /dev/null; then
    # See https://github.com/Spotifyd/spotifyd#configuration-file for how to set
    # up credentials in secret-tools (installed below)
    echo 'Installing spotifyd...'
    sudo apt install libasound2-dev libssl-dev libpulse-dev libdbus-1-dev
    \curl -L https://github.com/Spotifyd/spotifyd/archive/v0.2.19.tar.gz | tar -C $PERSONAL_DIR -xa
    pushd "$PERSONAL_DIR/spotifyd-0.2.19"
    echo 'Compiling.  This will take awhile...'
    cargo build --release --features pulseaudio_backend,dbus_keyring,dbus_mpris
    cp "$PERSONAL_DIR/spotifyd-0.2.19/target/release/spotifyd" ~/bin/
    mkdir -p ~/.config/systemd/user/
    sed -e "s|/usr/bin/spotifyd|$HOME/bin/spotifyd" "$PERSONAL_DIR/spotifyd-0.2.19/contrib/spotifyd.service" > ~/.config/systemd/user/
    systemctl --user enable spotifyd.service
    systemctl --user start spotifyd.service
    popd
else
    echo 'Found spotifyd'
fi

if ! which spt &&> /dev/null; then
    echo 'Installing spotify-tui...'
    \curl -L https://github.com/Rigellute/spotify-tui/releases/download/v0.7.5/spotify-tui-linux.tar.gz | tar -C ~/bin/ -xa
else
    echo 'Found spotify-tui'
fi

sudo apt install -y libsecret-tools

# install RVM
if rvm &> /dev/null; then
    echo 'RVM already installed'
else
    echo 'Installing RVM...'
    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
    \curl -sSL https://get.rvm.io | bash -s stable -- --ignore-dotfiles # We're already configured for RVM, so we don't need it to add anything
    ln -s "$RVM_ROOT/hooks/after_cd_nvm" "$CONFIG_DIR/rvm_hacks/after_cd_nvm"
    source "$CONFIG_DIR/rvm"
    rvm install ruby # Install the most recent ruby
fi

# install NVM
if nvm &> /dev/null; then
    echo 'NVM already installed'
else
    echo 'Installing NVM...'
    mkdir "$HOME/.nvm"
    \curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
    source "$CONFIG_DIR/nvm"
    nvm install --lts # install the latest Long Term Stable
fi

# Install PyEnv
if pyenv --help &> /dev/null; then
    echo 'PyEnv already installed'
else
    echo 'Installing PyEnv...'
    rm -rf "$PYENV_ROOT" 2 > /dev/null # The install script doesn't seem to want to work if this directory is here already
    \curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
    source "$CONFIG_DIR/pyenv"
    # Determine latest version of cpython and install it
    pyenv install "$(pyenv install -l | grep -v '[[:alpha:]]' | tail -1 | tr -d ' ')"
fi
