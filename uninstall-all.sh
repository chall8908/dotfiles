#!/bin/bash -l

# ensure this isn't run before the system has been configured
if [ -z "$CONFIG_DIR" ]; then
    echo 'System not configured.  Run this before running `make:clean`'
    exit 1
fi

# install RVM
if rvm &> /dev/null; then
    rm -rf "$RVM_ROOT"
else
    echo 'RVM not installed'
fi

# install NVM
if nvm &> /dev/null; then
    rm -rf "$NVM_DIR"
else
    echo 'NVM not installed'
fi

# Install PyEnv
if pyenv --help &> /dev/null; then
    rm -rf "$PYENV_ROOT"
else
    echo 'PyEnv not installed'
fi
