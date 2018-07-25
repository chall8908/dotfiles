;;; init-yasnippet -- Configuration for yasnippet
;;; Commentary:
;;; Code:

(use-package yasnippet
  :diminish yas-minor-mode
  :config
  (yas-global-mode 1)
  )

(use-package auto-complete
  :after (yasnippet)
  :hook (js2-mode . ac-js2-mode)
  :config
  (setq ac-js2-evaluate-calls t)

  (add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
  (ac-config-default)
  ;;; set the trigger key so that it can work together with yasnippet on tab key,
  ;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
  ;;; activate, otherwise, auto-complete will
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>") ; why two?
  )

(use-package yasnippet-snippets
  :after (yasnippet))

(use-package react-snippets
  :after (yasnippet))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here
