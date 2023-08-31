;;;; ruby --- Ruby mode configuration
;;; Commentary:
;;; Code:

;; Ruby setup

(use-package rvm)

(use-package enh-ruby-mode
  :interpreter "ruby"
  ;; might need this if it fucks with base16
  :init
  ;; grab and re-use built-in ruby-mode's auto mode
  (add-to-list 'auto-mode-alist (cons (car (rassoc 'ruby-mode auto-mode-alist)) 'enh-ruby-mode))
  :config
  (remove-hook 'enh-ruby-mode-hook 'erm-define-faces)
  )

(use-package ruby-electric
  :diminish
  :hook (enh-ruby-mode . ruby-electric-mode)
  )

(use-package rspec-mode
  :config
  (setq rspec-use-rvm t)
  )

(use-package rbs-mode)

(provide 'ruby)
;;; ruby.el ends here
