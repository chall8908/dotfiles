;;; general-keybinds --- Provides Emeacs-wide keybindings
;;; Commentary:
;;; Code:

(use-package multiple-cursors)

;; Helpful key bindings
(global-set-key (kbd "M-g") 'goto-line)
(global-set-key (kbd "M-<right>") 'forward-word)
(global-set-key (kbd "M-<left>") 'backward-word)
(global-set-key (kbd "M-;") 'evilnc-comment-or-uncomment-lines)
(global-set-key (kbd "C-d") 'mc/mark-next-like-this)
(global-set-key (kbd "M-d") 'mc/mark-all-like-this)
(global-set-key (kbd "s-[") 'hs-hide-block)
(global-set-key (kbd "s-]") 'hs-show-block)
(global-set-key (kbd "C-j") 'emmet-expand-line)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-q") 'beginning-of-line)

;; window managment
(global-unset-key (kbd "C-x <right>"))
(global-unset-key (kbd "C-x <left>"))
(global-unset-key (kbd "C-x -"))

(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x |") 'split-window-right)
(global-set-key (kbd "C-x -") 'split-window-below)

;; buffer management
(global-unset-key (kbd "C-b"))
(global-set-key (kbd "C-x M-b") 'previous-buffer)
(global-set-key (kbd "C-x M-f") 'next-buffer)

;; neotree bindings
(global-unset-key (kbd "C-x f"))
(global-set-key (kbd "C-x f") 'neotree-toggle)

(defun open-init ()
  "Open the init.el file in a buffer."
  (interactive)
  (find-file user-init-file)
  )
(global-set-key (kbd "C-b i") 'open-init)

(provide 'general-keybinds)
;;; general-keybinds.el ends here
