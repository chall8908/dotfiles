;;; init-yasnippet -- Configuration for yasnippet
;;; Commentary:
;;; Code:

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  )

(use-package yasnippet-snippets
  :after (yasnippet))

(use-package react-snippets
  :after (yasnippet))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
