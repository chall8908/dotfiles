#!/bin/bash -l

# ensure this isn't run before the system has been configured
if [ -z "$CONFIG_DIR" ] && [! -r "$HOME/.bash_profile"]; then
    echo 'Please perform initial setup with `make` first'
    exit 1
else
    # Source profile, we probably got called during initial setup
    source "$HOME/.bash_profile"
fi

# Install system packages
sudo apt build-dep emacs # So we can install emacs 26.1 which isn't in the Ubuntu repos
# Download the "latest", as of this writing, emacs
\curl -o "$PERSONAL_DIR/emacs-26.1.tar.xz" https://mirror.clarkson.edu/gnu/emacs/emacs-26.1.tar.xz

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
