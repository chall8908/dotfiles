;;; init-git.el --- Initializes and configures git-based packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package git-gutter
  :diminish
  :config (global-git-gutter-mode t)
  :custom (git-gutter:update-interval 1 "Update gutter every second"))

(use-package log-edit)
(require 'vc-git)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . vc-git-log-edit-mode))

(provide 'init-git)

;;; init-git.el ends here
