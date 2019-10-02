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

;; Fix https://debbugs.gnu.org/34341
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(defvar config-dir (expand-directory-name "config" user-emacs-directory)
  "Directory containing user configuration files."
  )
(add-to-list 'load-path config-dir)

(require 'switches)

;; Tell custom to write to custom.el instead of this file
(setq custom-file (expand-file-name "customize-settings.el" config-dir))

(require 'customize-settings) ; loads custom-set stuff
(require 'whoami)
(require 'init-package)
(require 'behavior)           ; configure general behavior
(require 'appearance)         ; configure general appearance
(require 'tmux-keybinds)      ; fix keybinds in tmux
(require 'init-neotree)

(require 'init-midnight)      ; setup midnight to clean unused buffers

(use-package evil-nerd-commenter)

(require 'init-git)
(require 'init-ac)
(require 'init-yasnippet)
(require 'init-company)
(require 'init-flycheck)
(require 'init-ivy)
(require 'init-avy)
(require 'init-modes)

(require 'general-keybinds) ; Add additional general keybindings

(provide 'init)
;;; init.el ends here
