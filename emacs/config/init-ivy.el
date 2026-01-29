;;; init-ivy --- Configure ivy
;;; Commentary:
;;; Code:

(use-package projectile
  :demand t
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  ;; (projectile-mode +1)
  )

(use-package ivy
  :diminish
  :demand t
  :bind (:map ivy-minibuffer-map
              ("RET" . ivy-alt-done)
              ("M-RET" . ivy-immediate-done))

  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        enable-recursive-minibuffers t
        ivy-count-format "%d/%d "
        ivy-display-style 'fancy)
  )

(use-package counsel
  :demand t
  :after (ivy)
  :diminish
  :bind (:map counsel-find-file-map
              ("RET" . ivy-alt-done)
              ("M-RET" . ivy-immediate-done))

  :config
  (counsel-mode 1)
  )

(use-package counsel-projectile
  :demand t
  :after (counsel projectile)
  :diminish
  :config
  (counsel-projectile-mode 1)
  )

(use-package swiper
  :bind ("C-s" . swiper)
  :after (ivy)
  )

(provide 'init-ivy)
;;; init-ivy.el ends here
