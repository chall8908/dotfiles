;;; init --- User initialization file
;;; Commentary:
;;; Code:

;; These are useful for a few things.  Primarily differences between systems.
(defconst IS-MAC     (eq system-type 'darwin))
(defconst IS-LINUX   (eq system-type 'gnu/linux))
(defconst IS-WINDOWS (memq system-type '(cygwin windows-nt ms-dos)))
(defconst IS-WSL     (string-match "-[Mm]icrosoft" operating-system-release))

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
(setq custom-file (expand-file-name "customize-settings.el" config-dir))

(require 'switches)

(require 'whoami)
(require 'init-package)
(require 'customize-settings) ; loads custom-set stuff
(require 'behavior)           ; configure general behavior
(require 'appearance)         ; configure general appearance
(require 'tmux-keybinds)      ; fix keybinds in tmux
(require 'init-neotree)

(require 'init-midnight)      ; setup midnight to clean unused buffers

(use-package evil-nerd-commenter)

(require 'init-git)
(require 'init-company)
(require 'init-flycheck)
(require 'init-ivy)
(require 'init-avy)
(require 'init-modes)

(require 'general-keybinds) ; Add additional general keybindings

(provide 'init)
;;; init.el ends here
