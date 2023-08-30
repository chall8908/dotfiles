;;; appearance --- Configure Emacs' general appearance
;;; Commentary:
;;; Code:

(use-package base16-theme
  :config
  (setq base16-theme-256-color-source "colors")
  (setq base16-distinct-fringe-background nil)
  (load-theme 'base16-brewer t)
  (set-face-foreground 'italic "#bbb")
  )

(global-font-lock-mode t)

;; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; disable menu bar
(menu-bar-mode 0)

;; Display time
(display-time)

;; Display Line Numbers
(global-display-line-numbers-mode t)

;; Display line and column numbers in the modeline
(line-number-mode 1)
(column-number-mode 1)

(defun add-mode-line-dirtrack ()
  "Add path to file in mode line."
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

(provide 'appearance)
;;; appearance.el ends here
