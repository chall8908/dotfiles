;;; js2.el --- Configure js2-mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package js2-mode
  :config
  (setq js-indent-level 2
        js2-indent-level 2
        js2-highlight-level 3
        js2-basic-offset 2
        js2-indent-switch-body t)

  (add-hook `js-mode-hook `editorconfig-mode)
  (add-hook `js-mode-hook
            (lambda ()
              ;; Scan the file for nested code blocks
              (imenu-add-menubar-index)
              ;; Activate the folding mode
              (hs-minor-mode t)))
  )

(use-package tern
  :diminish
  :config
  (add-hook 'js2-mode-hook 'tern-mode)
  (setq tern-command (append tern-command '("--no-port-file")))
)

(use-package company-tern
  :init
  (add-to-list 'company-backends '(company-tern company-web-html :with company-yasnippet))

  :config
  (setq company-tern-property-marker nil)
)

(provide 'js2)
;;; js2.el ends here
