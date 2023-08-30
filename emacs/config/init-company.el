;;; init-company.el --- Configure company mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package company
  :diminish
  :config
  (global-company-mode 1)

  (setq company-echo-delay 0
        company-idle-delay 0
        company-show-numbers t
        company-minimum-prefix-length 2
        company-tooltip-align-annotations t
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-require-match nil
        company-begin-commands '(self-insert-command)
        ;; company-frontends '(company-pseudo-tooltip-frontend
        ;;                     company-echo-metadata-frontend)
        )

  (add-to-list 'company-backends 'company-ispell)
  )

(use-package company-shell
  :after company
  )

(use-package pos-tip)

(use-package company-tabnine
  :pin melpa
  :after company
  :init
  (setq company-tabnine-no-continue t)
  (add-to-list 'company-backends #'company-tabnine))

(provide 'init-company)

;;; init-company.el ends here
