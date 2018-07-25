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
 )

;; TODO: docs
(setq resize-minibuffer-mode t)

;; Use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

(setq tab-width 2)

;; Don't autosave
(auto-save-mode -1)

;; scrolling
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(electric-pair-mode t)
(delete-selection-mode t)
(show-paren-mode t)

(add-hook 'before-save-hook 'whitespace-cleanup)

;; Remap find-file/switch-to-buffer keymaps to IDO counterparts
(ido-mode t)

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

;; Don't clutter up directories with files
(let
    ((backup-directory (concat user-emacs-directory "backups")))

  (make-directory backup-directory t)

  (setq backup-directory-alist `(("." . ,backup-directory))
        make-backup-files nil
        version-control nil
        backup-by-copying-when-linked nil
        delete-old-versions nil
        delete-by-moving-to-trash nil)
  )

(defun custom-goto-match-beginning ()
  "Use with isearch hook to end search at first char of match."
  (when isearch-forward (goto-char isearch-other-end)))

(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)

(cond
 ((string-equal system-type "darwin")    (require 'mac-behavior))
 ((string-equal system-type "gnu/linux") (require 'linux-behavior))
 )

(provide 'behavior)
;;; behavior.el ends here
