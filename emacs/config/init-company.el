;;; init-company.el --- Configure company mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package corfu
  :init
  (global-corfu-mode))

(use-package corfu-terminal
  :after corfu
  :straight '(corfu-terminal
              :type git
              :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
  :unless (display-graphic-p)
  :init
  (corfu-terminal-mode +1))

(use-package company
  :diminish
  :config
  (global-company-mode 1)

  (setq company-echo-delay 0
        company-idle-delay 0
        company-show-numbers t
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-require-match nil
        company-begin-commands '(self-insert-command)
        )
  )

(use-package company-shell
  :after company
  )

(use-package pos-tip)

(use-package company-tabnine
  :demand
  :after company
  :hook (kill-emacs . 'company-tabnine-kill-process)
  :config
  (add-to-list 'company-backends #'company-tabnine)
  )

(provide 'init-company)

;;; init-company.el ends here
