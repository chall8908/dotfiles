;;;; ruby --- Ruby mode configuration
;;; Commentary:
;;; Code:

;; Ruby setup

(use-package rvm)

;; (use-package enh-ruby-mode
;;   ;; use on most ruby based files
;;   :mode "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'"
;;   :interpreter "ruby"
;;   ;; might need this if it fucks with base16
;;   :config
;;   (remove-hook 'enh-ruby-mode-hook 'erm-define-faces)
;;   )

(add-to-list 'auto-mode-alist
             '("\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|plan\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'" . ruby-mode))

(use-package ruby-electric
  :diminish
  :hook (ruby-mode . ruby-electric-mode)
  )

(use-package rspec-mode
  :config
  (setq rspec-use-rvm t)
  (rspec-install-snippets)
  )

(provide 'ruby)
;;; ruby.el ends here
