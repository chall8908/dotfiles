;;; elixir.el --- elixir mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package elixir-mode
  :mode "\.exs$"
  )

(use-package flycheck-elixir
  :after (flycheck)
  :pin melpa
  )

(provide 'elixir)

;;; elixir.el ends here
