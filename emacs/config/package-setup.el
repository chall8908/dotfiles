;;; package-setup --- Setup package management
;;; Commentary:
;;; Code:

;; configure elpa directory
(setq package-user-dir (concat user-emacs-directory "elpa"))

;; Require package
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))

(package-initialize)

(eval-when-compile
  (require 'use-package))

(setq use-package-always-pin "melpa-stable")
(setq use-package-always-ensure t)

(provide 'package-setup)
;;; package-setup.el ends here
