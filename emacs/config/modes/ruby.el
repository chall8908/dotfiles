;;;; ruby --- Ruby mode configuration
;;; Commentary:
;;; Code:

;; Ruby setup

(use-package rvm)

(use-package ruby-mode
  :config
  (setq ruby-block-indent nil))

(use-package ruby-electric
  :diminish
  :hook (ruby-mode . ruby-electric-mode)
  )

(use-package rspec-mode
  :config
  (setq rspec-use-rvm t)
  )

(use-package rbs-mode)

(provide 'ruby)
;;; ruby.el ends here
