;;; behavior -- Configure general emacs behavior
;;; Commentary:
;;; Code:

(setq-default
 ;; Disable the welcome message
 inhibit-startup-message t
 ;; Always end a file with a newline
 require-final-newline t
 ;; Stop at EoF
 next-line-add-newlines nil
 ;; Flash instead of that annoying bell
 visible-bell t
 ;; highlight marked region
 transient-mark-mode t
 ;; don't insert tabs unless absolutely necessary (e.g. Makefiles)
 indent-tabs-mode nil
 ;; display continuation lines
 truncate-lines nil
 ;; don't autosave
 auto-save-default nil
 ;; don't backup
 make-backup-files nil
 ;; don't generate lockfiles
 create-lockfiles nil)

(defvar better-gc-cons-threshold 134217728 ; 128mb
  "The default value to use for `gc-cons-threshold'.")

;; Setup better GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold better-gc-cons-threshold)
            (setq file-name-handler-alist file-name-handler-alist-original)
            (makunbound 'file-name-handler-alist-original)))

;; twiddle GC options when emacs loses focus and when entering/exiting the minibuffer
(add-hook 'emacs-startup-hook
          (lambda ()
            (if (boundp 'after-focus-change-function)
                (add-function :after after-focus-change-function
                              (lambda ()
                                (unless (frame-focus-state)
                                  (garbage-collect))))
              (add-hook 'after-focus-change-function 'garbage-collect))
            (defun gc-minibuffer-setup-hook ()
              (setq gc-cons-threshold (* better-gc-cons-threshold 2)))

            (defun gc-minibuffer-exit-hook ()
              (garbage-collect)
              (setq gc-cons-threshold better-gc-cons-threshold))

            (add-hook 'minibuffer-setup-hook #'gc-minibuffer-setup-hook)
            (add-hook 'minibuffer-exit-hook #'gc-minibuffer-exit-hook)))

;; Increase read process buffer size for LSP servers
(setq read-process-output-max (* 1024 1024)) ;; 1mb

;; TODO: docs
(setq resize-minibuffer-mode t)

;; Use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default tab-width 2
              js-indent-level 2)
(setq tab-stop-list (number-sequence tab-width 120 tab-width))

;; scrolling
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(electric-pair-mode t)
(delete-selection-mode t)
(show-paren-mode t)

(defun safe-delete-trailing-whitespace ()
  "Delete trailing whitespace but not in buffers where trailing whitespace is
   required"
  (when (not (eq major-mode 'diff-mode))
    delete-trailing-whitespace)
  )

(add-hook 'before-save-hook 'safe-delete-trailing-whitespace)

;; Everything in UTF-8
(     prefer-coding-system          'utf-8)
(     set-language-environment      "utf-8")
(     set-default-coding-systems    'utf-8)
(setq file-name-coding-system       'utf-8)
(setq buffer-file-coding-system     'utf-8)
(setq coding-system-for-write       'utf-8)
(     set-keyboard-coding-system    'utf-8)
(     set-terminal-coding-system    'utf-8)
(     set-clipboard-coding-system   'utf-8)
(     set-selection-coding-system   'utf-8)
(setq default-process-coding-system '(utf-8 . utf-8))

(add-to-list 'auto-coding-alist '("." . utf-8))

(defun custom-goto-match-beginning ()
  "Use with isearch hook to end search at first char of match."
  (when isearch-forward (goto-char isearch-other-end)))

(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)

(cond
 (IS-MAC     (require 'mac-behavior))
 (IS-WINDOWS (require 'windows-behavior))
 (IS-WSL     (require 'wsl-behavior))
 (IS-LINUX   (require 'linux-behavior))
 )

(provide 'behavior)
;;; behavior.el ends here
