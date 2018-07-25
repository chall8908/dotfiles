;;; init --- User initialization file
;;; Commentary:
;;; Code:

;; This has to be here - commented out, since it's called elsewhere - or package bitches and adds it back
;; (package-initialize)

(defun expand-directory-name (name &optional root)
  "Expand direcory NAME to an absolute system path.
ROOT is the path to start in if NAME is relative."
  (file-name-as-directory (expand-file-name name root))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Actual configuration starts here ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar config-dir (expand-directory-name "config" user-emacs-directory)
  "Directory containing user configuration files."
  )
(add-to-list 'load-path config-dir)

;; Tell custom to write to custom.el instead of this file
(setq custom-file (expand-file-name "custom.el" config-dir))

(require 'custom)        ; loads custom-set stuff
(require 'whoami)
(require 'init-package)
(require 'behavior)      ; configure general behavior
(require 'tmux-keybinds) ; fix keybinds in tmux
(require 'init-neotree)

;; setup midnight to clean unused buffers
(use-package midnight
  :config
  (midnight-delay-set 'midnight-delay "1:00am")
  )

(use-package evil-nerd-commenter)

(require 'init-yasnippet)
(require 'init-flycheck)
(require 'init-modes)

(require 'general-keybinds) ; Add additional general keybindings
(require 'appearance)       ; configure general appearance

(provide 'init)
;;; init.el ends here
