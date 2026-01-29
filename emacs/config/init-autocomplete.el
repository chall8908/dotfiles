;;; init-autocomplete.el --- Configure autocomplete -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package transient)

(use-package aidermacs
  :after transient
  :bind (("C-c a"  . aidermacs-transient-menu))
  :config
  (setq aidermacs-exit-kills-buffer t)
  :custom
  (aidermacs-default-chat-mode 'architect))

(use-package corfu
  :init
  (global-corfu-mode))

(use-package corfu-terminal
  :after corfu
  :straight '(corfu-terminal
              :type git
              :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
  :unless (display-graphic-p)
  :init
  (corfu-terminal-mode +1))

(use-package pos-tip)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("M-<return>" . 'copilot-accept-completion-by-line)
              ("M-RET" . 'copilot-accept-completion-by-line)
              ("C-g" . 'copilot-clear-overlay)
              ("M-[" . 'copilot-previous-completion)
              ("M-]" . 'copilot-next-completion))
  :hook (prog-mode . copilot-mode)
  :ensure t)

(provide 'init-autocomplete)

;;; init-autocomplete.el ends here
