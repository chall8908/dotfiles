;;; init-avy.el --- Configure avy-*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package avy
  :diminish
  )

(use-package avy-flycheck
  :pin melpa
  :after avy
  )

(provide 'init-avy)

;;; init-avy.el ends here
