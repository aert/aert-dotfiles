#!/usr/bin/env bash

emacsclient --eval "(progn (setq kill-emacs-hook 'nil) (kill-emacs))"
