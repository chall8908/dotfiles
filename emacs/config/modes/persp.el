;;;;;; persp.el --- Initialize Perspective Mode -*- lexical-binding: t -*-

;; Author: Chris Hall
;; Maintainer: Chris Hall

;;; Code:

(use-package persp-mode
  :init
  (persp-mode)
  :config
  (setq persp-autokill-buffer-on-remove 'kill-weak)
  ;; perspective mode keybindings
  (global-unset-key (kbd "C-x k"))
  (global-set-key (kbd "C-x k") 'persp-kill-buffer)

  (global-unset-key (kbd "C-x b"))
  (global-set-key (kbd "C-x b") 'persp-switch-to-buffer))

(provide 'persp)

;;; persp.el ends here
