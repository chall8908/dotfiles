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

;; TODO: docs
(setq resize-minibuffer-mode t)

;; Use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

(setq-default tab-width 2)
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

(add-hook 'before-save-hook 'delete-trailing-whitespace)

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
