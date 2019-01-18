;;; git -- Git related configuration
;;; Commentary:
;;; Code:

;; log edit mode for Commits and whatnot
(use-package log-edit)
(require 'vc-git)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . vc-git-log-edit-mode))

(provide 'git)
;;; git.el ends here
