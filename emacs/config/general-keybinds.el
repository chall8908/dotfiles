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
(global-set-key (kbd "C-c e l") 'mc/edit-lines)

(global-set-key (kbd "s-[") 'hs-hide-block)
(global-set-key (kbd "s-]") 'hs-show-block)
(global-set-key (kbd "C-j") 'emmet-expand-line)

(global-unset-key (kbd "C-a"))
(global-set-key (kbd "C-q") 'beginning-of-line)

;; Line movement
(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))

(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))

(defun transpose-character-left ()
  "Move current character to the left."
  (interactive)
  (forward-char)
  (transpose-chars -1)
  (backward-char))

(defun transpose-character-right ()
  "Move current character to the left."
  (interactive)
  (forward-char)
  (transpose-chars 1)
  (backward-char))

(global-unset-key (kbd "C-t"))

(global-set-key (kbd "C-t C-<up>") 'move-line-up)
(global-set-key (kbd "C-t C-<down>") 'move-line-down)
(global-set-key (kbd "C-t C-<left>") 'transpose-character-left)
(global-set-key (kbd "C-t C-<right>") 'transpose-character-right)
(global-set-key (kbd "C-t C-t") 'transpose-chars)

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

(defun open-scratch ()
  "Open the scratch buffer"
  (interactive)
  (switch-to-buffer "*scratch*"))
(global-set-key (kbd "C-b s") 'open-scratch)

(provide 'general-keybinds)
;;; general-keybinds.el ends here
