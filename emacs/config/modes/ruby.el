;;;; ruby --- Ruby mode configuration
;;; Commentary:
;;; Code:

;; Ruby setup

(use-package rvm)

(use-package enh-ruby-mode
  ;; use on most ruby based files
  :mode "\\(?:\\.rb\\|ru\\|rake\\|thor\\|jbuilder\\|gemspec\\|podspec\\|/\\(?:Gem\\|Rake\\|Cap\\|Thor\\|Vagrant\\|Guard\\|Pod\\)file\\)\\'"
  :interpreter "ruby"
  ;; might need this if it fucks with base16
  :config
  (remove-hook 'enh-ruby-mode-hook 'erm-define-faces)
  )

(use-package ruby-electric
  :diminish
  :hook (enh-ruby-mode . ruby-electric-mode)
  )

;; (use-package rubocop
;;   :hook enh-ruby-mode
;;   )

;; (use-package ruby-tools
;;   :diminish
;;   :hook enh-ruby-mode
;;   )

(use-package rspec-mode
  :config
  (setq rspec-use-rvm t)
  (rspec-install-snippets)
  )

;; robe is a bit overkill for me...

;; (use-package inf-ruby
;;   :after rvm
;;   )

;; (use-package robe
;;   :after (enh-ruby-mode company)
;;   :diminish
;;   :hook enh-ruby-mode
;;   :config
;;   (push 'company-robe company-backends)
;;   (defadvice inf-ruby-console-auto
;;       (before activate-rvm-for-robe activate)
;;     (rvm-activate-corresponding-ruby)
;;     )
;;   (add-hook 'robe-mode-hook 'robe-start)
;;   )

(provide 'ruby)
;;; ruby.el ends here
