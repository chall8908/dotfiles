;;; init-autocomplete.el --- Configure autocomplete -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

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

(use-package tabnine
  :commands (tabnine-start-process)
  :hook (prog-mode . tabnine-mode)
  :straight t
  :diminish "⌬"
  :custom
  (tabnine-wait 1)
  (tabnine-minimum-prefix-length 0)
  :hook (kill-emacs . tabnine-kill-process)
  :config
  (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
  (tabnine-start-process)
  (require 'tabnine-chat-curl) ; Ensure tabnine chat curl is loaded
  :bind
  (:map  tabnine-completion-map
	 ("<tab>" . tabnine-accept-completion)
	 ("TAB" . tabnine-accept-completion)
	 ("M-f" . tabnine-accept-completion-by-word)
	 ("M-<return>" . tabnine-accept-completion-by-line)
	 ("M-RET" . tabnine-accept-completion-by-line)
	 ("C-g" . tabnine-clear-overlay)
	 ("M-[" . tabnine-previous-completion)
	 ("M-]" . tabnine-next-completion)))

(provide 'init-autocomplete)

;;; init-autocomplete.el ends here
