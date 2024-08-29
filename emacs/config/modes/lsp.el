;;; lsp -- Configuration for lsp-mode
;;; Commentary:
;;; Code:

(use-package iedit)

(use-package which-key
  :config
  (which-key-mode))

(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook ((web-mode . lsp-deferred)
         (ruby-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))

(use-package lsp-ui)

(use-package lsp-ivy
  :commands lsp-ivy-workspace-symbol)

(use-package lsp-treemacs
  :after (lsp-mode treemacs))

(provide 'lsp)
;;; lsp.el ends here

