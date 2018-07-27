;;; curtains --- Configure Emacs' general appearance
;;; Commentary:
;;; Code:

;; disable menu bar
(menu-bar-mode 0)

(add-to-list 'custom-theme-load-path (concat package-user-dir "base16-theme-20151019.711"))
(load-theme `base16-brewer-dark t)

(global-font-lock-mode t)

;; Disable the welcome message
(setq inhibit-startup-message t)

;; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; Display time
(display-time)

;; Always end a file with a newline
(setq require-final-newline t)

;; Stop emacs from arbitrarily adding lines to the end of a file when the
;; cursor is moved past the end of it
(setq next-line-add-newlines nil)

;; Flash instead of that annoying bell
(setq visible-bell t)

;; Use y or n instead of yes or no
(fset 'yes-or-no-p 'y-or-n-p)

;; Line numbers
(setq scroll-step 1)
(line-number-mode 1)
(column-number-mode 1)

;; Slightly better line numbering
(unless window-system
  (add-hook 'linum-before-numbering-hook
            (lambda ()
              (setq-local linum-format-fmt
                          (let ((w (length (number-to-string
                                            (count-lines (point-min) (point-max))))))
                            (concat "%" (number-to-string w) "d"))))))

(defun linum-format-func (line)
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'background-color))) ;; this looks a little weird when highlighting a line

(unless window-system
  (setq linum-format 'linum-format-func))

;; Add path to file in mode line
(defun add-mode-line-dirtrack ()
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

(global-linum-mode 1)

;; Don't write backup files
(setq make-backup-files nil)

;; Don't autosave
(setq auto-save-default nil)

;; scrolling
;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq-default truncate-lines nil)

(provide 'curtains)
;;; curtains.el ends here
