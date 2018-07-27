;;; appearance --- Configure Emacs' general appearance
;;; Commentary:
;;; Code:

(use-package base16-theme
  :config
  (setq base16-theme-256-color-source "colors")
  (load-theme 'base16-brewer t)
  )

(global-font-lock-mode t)

;; Format the title-bar to always include the buffer name
(setq frame-title-format "emacs - %b")

;; disable menu bar
(menu-bar-mode 0)

;; Display time
(display-time)

;; Line numbers
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
  "Add a bit of extra space after the line numbers.
LINE number of the given line"
  (concat
   (propertize (format linum-format-fmt line) 'face 'linum)
   (propertize " " 'face 'background-color))) ;; this looks a little weird when highlighting a line

(unless window-system
  (setq linum-format 'linum-format-func))

(defun add-mode-line-dirtrack ()
  "Add path to file in mode line."
  (add-to-list 'mode-line-buffer-identification
               '(:propertize (" " default-directory " ") face dired-directory)))
(add-hook 'shell-mode-hook 'add-mode-line-dirtrack)

(global-linum-mode 1)

(provide 'appearance)
;;; appearance.el ends here
