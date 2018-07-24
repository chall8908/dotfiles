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

(provide 'init-ivy)
;;; init-ivy.el ends here
