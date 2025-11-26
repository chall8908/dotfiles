;;; init-git.el --- Initializes and configures git-based packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package git-gutter
  :config (global-git-gutter-mode t)
  :custom (git-gutter:update-interval 1 "Update gutter every second"))

(provide 'init-git)

;;; init-git.el ends here
