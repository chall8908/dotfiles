;;; init-ivy --- Configure ivy
;;; Commentary:
;;; Code:

(use-package projectile
  :demand t
  :diminish
  ;; :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (define-key projectile-mode-map (kbd "C-c C-p") 'projectile-command-map)
  ;; (projectile-mode +1)
  )

(use-package ivy
  ;; :pin melpa
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
        ivy-display-style 'fancy
        ivy-sort-functions-alist (append ivy-sort-functions-alist
                                         '((persp-kill-buffer   . nil)
                                           (persp-remove-buffer . nil)
                                           (persp-add-buffer    . nil)
                                           (persp-switch        . nil)
                                           (persp-window-switch . nil)
                                           (persp-frame-switch  . nil))))

  (add-hook 'ivy-ignore-buffers
            #'(lambda (b)
                (when persp-mode
                  (let (persp (get-current-persp))
                    (if persp
                        (not (persp-contain-buffer-p b persp))
                      nil)))))
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
