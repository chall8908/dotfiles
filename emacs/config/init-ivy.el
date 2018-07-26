;;; init-ivy --- Configure ivy
;;; Commentary:
;;; Code:

(use-package ivy
  :diminish ivy-mode
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-count-format "%d/%d "
        ivy-display-style 'fancy))

(use-package counsel
  :after ivy
  :diminish
  :config
  (counsel-mode 1)
  )

(use-package swiper
  :bind ("C-s" . swiper)
  :after (ivy)
  )

(provide 'init-ivy)
;;; init-ivy.el ends here
