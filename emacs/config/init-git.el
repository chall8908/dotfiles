;;; init-git.el --- Initializes and configures git-based packages -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (use-package git-gutter+
;;   :ensure t
;;   :bind (:map git-gutter+-mode-map
;;               ("C-x n" . 'git-gutter+-next-hunk)
;;               ("C-x p" . 'git-gutter+-previous-hunk)
;;               ("C-x v =" . 'git-gutter+-show-hunk)
;;               ("C-x r" . 'git-gutter+-revert-hunks)
;;               ("C-x t" . 'git-gutter+-stage-hunks)
;;               ("C-x c" . 'git-gutter+-commit)
;;               ("C-x C" . 'git-gutter+-stage-and-commit)
;;               ("C-x C-y" . 'git-gutter+-stage-and-commit-whole-buffer)
;;               ("C-x U" . 'git-gutter+-unstage-whole-buffer))
;;   :diminish (git-gutter+-mode . "gg")
;;   :config (global-git-gutter+-mode))

(use-package git-gutter
  :config (global-git-gutter-mode t)
  :custom (git-gutter:update-interval 1 "Update gutter every second"))

(use-package magit
  :if (executable-find "git")
  :bind
  (("C-x g" . magit-status)
   (:map magit-status-mode-map
         ("M-RET" . magit-diff-visit-file-other-window)))
  :config
  (defun magit-log-follow-current-file ()
    "A wrapper around `magit-log-buffer-file' with `--follow' argument."
    (interactive)
    (magit-log-buffer-file t)))

(provide 'init-git)

;;; init-git.el ends here
