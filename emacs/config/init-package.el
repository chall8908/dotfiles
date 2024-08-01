;;; init-package --- Setup package management
;;; Commentary:
;;; Code:

(setq byte-compile-warnings nil     ; don't show compile warnings
      )

;; straight.el bootstrap code
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

(eval-when-compile
  (require 'use-package))

(use-package diminish)

(provide 'init-package)
;;; init-package.el ends here
