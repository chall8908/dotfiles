# Dotfiles

This repo is designed for automated setup via `make`.  Because some pieces require
your user to have specific groups after certain things are installed, a `user` target
is provided to make this simpler.  In short:

1. `make user`
2. log out and back in
3. `make install` or `make install-desktop`

In all cases, the various files are symlinked to their final locations, so any
changes should reflect as soon as is possible.

## Yubikey Setup

These steps are only needed to perform first-time setup.  After that, the Makefile
should handle the rest.

```
# The following must be installed
sudo apt install opensc ykcs11

# Create Authentication Key
pkcs11-tool --module /usr/lib/x86_64-linux-gnu/libykcs11.so -k --key-type rsa:2048 --usage-sign --usage-decrypt --login --id 01 --login-type so --so-pin 010203040506070801020304050607080102030405060708 --label defaultkey

# Create Key Management Key
pkcs11-tool --module /usr/lib/x86_64-linux-gnu/libykcs11.so -k --key-type EC:prime256v1 --usage-sign --usage-decrypt --login --id 03 --login-type so --so-pin 010203040506070801020304050607080102030405060708 --label defaultkey
```

## See Also

* Nerd Fonts: https://www.nerdfonts.com/
