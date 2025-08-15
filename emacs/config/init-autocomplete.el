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

(use-package company
  :diminish
  :config
  (global-company-mode 1)

  (setq company-echo-delay 0
        company-idle-delay 0
        company-show-numbers t
        company-minimum-prefix-length 1
        company-tooltip-align-annotations t
        company-tooltip-limit 10
        company-tooltip-flip-when-above t
        company-dabbrev-ignore-case nil
        company-dabbrev-downcase nil
        company-require-match nil
        company-begin-commands '(self-insert-command)
        )
  )

(use-package company-shell
  :after company
  )

(use-package pos-tip)

(use-package company-tabnine
  :demand
  :after company
  ;; :hook (kill-emacs . 'company-tabnine-kill-process)
  :config
  (add-to-list 'company-backends #'company-tabnine)
  )

;; (use-package tabnine
;;   :commands (tabnine-start-process)
;;   :hook (prog-mode . tabnine-mode)
;;   :straight t
;;   :diminish "⌬"
;;   :custom
;;   (tabnine-wait 1)
;;   (tabnine-minimum-prefix-length 0)
;;   :hook (kill-emacs . tabnine-kill-process)
;;   :config
;;   (add-to-list 'completion-at-point-functions #'tabnine-completion-at-point)
;;   (tabnine-start-process)
;;   :bind
;;   (:map  tabnine-completion-map
;; 	 ("<tab>" . tabnine-accept-completion)
;; 	 ("TAB" . tabnine-accept-completion)
;; 	 ("M-f" . tabnine-accept-completion-by-word)
;; 	 ("M-<return>" . tabnine-accept-completion-by-line)
;; 	 ("C-g" . tabnine-clear-overlay)
;; 	 ("M-[" . tabnine-previous-completion)
;; 	 ("M-]" . tabnine-next-completion)))

(provide 'init-autocomplete)

;;; init-autocomplete.el ends here
