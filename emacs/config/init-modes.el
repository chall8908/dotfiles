;;; init-modes.el --- Initialize all modes used -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(add-to-list 'load-path (expand-directory-name "modes" config-dir))

(use-package string-inflection)

(use-package tree-sitter
  :demand t
  :config
  (global-tree-sitter-mode)
  )

(use-package tree-sitter-langs
  :after (tree-sitter)
  )

(use-package python-mode
  :mode "\\.py$")

(use-package yaml-mode
  :mode "\\.yaml$")

(use-package groovy-mode
  :mode "\\.groovy$"
  :config
  (setq groovy-indent-offset 2))

(use-package css-mode
  :mode "\\.css$"
  :config
  (setq css-indent-offset tab-width))

(use-package scss-mode
  :after (css-mode)
  :mode "\\.s[ca]ss$")

(use-package tuareg-mode
  :ensure tuareg
  :mode "\\.ml[ilyp]?$")

(use-package mustache-mode
  :mode "\\.mustache$")

;; Sql Mode
(use-package sql-indent
  :after (sql-mode)
  )
(add-hook 'sql-mode-hook 'sql-highlight-postgres-keywords)

(use-package puppet-mode
  :mode "\\.e?pp$"
  :bind (("C-c a" . puppet-align-block))
  )

(use-package csv-mode
  :mode "\\.csv")

(use-package dockerfile-mode)

(use-package powershell)

(use-package nginx-mode)

(use-package caddyfile-mode
  :ensure t
  :mode (("Caddyfile\\'" . caddyfile-mode)
         ("caddy\\.conf\\'" . caddyfile-mode))
  :init
  (defun caddyfile-tab-override ()
    (setq-local tab-width 2
                indent-tabs-mode nil))
  :hook (caddyfile-mode . caddyfile-tab-override))

(use-package auctex)

(require 'persp)
(require 'elixir)
(require 'git)
(require 'markdown)
(require 'ruby)
(require 'web)
(require 'emmet)
(require 'r)
;; (require 'lsp)

;; Change default indentation in shell scripts to 2
(setq sh-basic-offset 2)

(provide 'init-modes)

;;; init-modes.el ends here
