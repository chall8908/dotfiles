;;; init-helm.el --- Configure helm -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package helm
  :diminish
  :bind ("M-x" . 'helm-M-x)
  :config
  (helm-mode 1)
  )

(use-package swiper-helm
  :after helm
  )

;; (use-package ac-helm
;;   :after (auto-complete helm)
;;   )

(provide 'init-helm)

;;; init-helm.el ends here
