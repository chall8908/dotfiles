# Dotfiles

This repo is designed for automated setup via `make`.  Simply clone this repo,
run `make`, and you should have everything set up the way the various sub-components
expect.

In all cases, the various files are symlinked to their final locations, so any
changes should reflect as soon as is possible.

TODO:
* System detection for automatic install of prerequisits (e.g. emacs, rvm)
* Add Makefile target for rvm after_cd_nvm hack
