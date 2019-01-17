;;; init-company.el --- Configure company mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package company
  :diminish
  :config
  (global-company-mode 1)

  (defvar company-mode/enable-yas t
    "Enable yasnippet for all backends.")

  (defun company-mode/backend-with-yas (backend)
    (if (or (not company-mode/enable-yas) (and (listp backend) (member 'company-yasnippet backend)))
        backend
      (append (if (consp backend) backend (list backend))
              '(:with company-yasnippet))))

  (setq company-echo-delay 0
        company-idle-delay 0.2
        company-show-numbers t
        company-minimum-prefix-length 2
        company-tooltip-align-annotations t
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-require-match nil
        company-begin-commands '(self-insert-command)
        company-backends (mapcar #'company-mode/backend-with-yas company-backends)
        ;; company-frontends '(company-pseudo-tooltip-frontend
        ;;                     company-echo-metadata-frontend)
        )

  (add-to-list 'company-backends 'company-keywords)
  (add-to-list 'company-backends 'company-capf)
  (add-to-list 'company-backends 'company-files)
  )

(use-package company-shell
  :after company
  )

(use-package pos-tip)

(use-package company-tabnine
  :pin melpa
  :after company
  :init
  (add-to-list 'company-backends #'company-tabnine))

(provide 'init-company)

;;; init-company.el ends here
