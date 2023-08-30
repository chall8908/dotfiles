# Dotfiles

This repo is designed for automated setup via `make`.  Because some pieces require
your user to have specific groups after certain things are installed, a `user` target
is provided to make this simpler.  In short:

1. `make user`
2. log out and back in
3. `make install` or `make install-desktop`

In all cases, the various files are symlinked to their final locations, so any
changes should reflect as soon as is possible.
