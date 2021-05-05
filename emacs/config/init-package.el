;;; init-package --- Setup package management
;;; Commentary:
;;; Code:

;; configure elpa directory
(setq package-user-dir (expand-directory-name "elpa" user-emacs-directory))

;; ensure package directory exists
(make-directory package-user-dir t)

;; TODO: Switch to straight.el
;; see https://github.com/raxod502/straight.el#bootstrapping-straightel
(setq package-archives '()      ; unset package archives
      byte-compile-warnings nil ; don't show compile warnings
      )

;; Require package
(require 'package)
(add-to-list 'package-archives (cons "melpa"        "https://melpa.org/packages/") t)
(add-to-list 'package-archives (cons "melpa-stable" "https://stable.melpa.org/packages/") t)
(add-to-list 'package-archives (cons "gnu"          "https://elpa.gnu.org/packages/") t)

;; Shamelessly stolen from doom-emacs.
;; From https://github.com/hlissner/doom-emacs/blob/develop/core/core.el as of
;; 2021-04-29
(setq gnutls-verify-error (not (getenv-internal "INSECURE"))
      gnutls-algorithm-priority
      (when (boundp 'libgnutls-version)
        (concat "SECURE128:+SECURE192:-VERS-ALL"
                (if (and (not IS-WINDOWS)
                         (not (version< emacs-version "26.3"))
                         (>= libgnutls-version 30605))
                    ":+VERS-TLS1.3")
                ":+VERS-TLS1.2"))
      ;; `gnutls-min-prime-bits' is set based on recommendations from
      ;; https://www.keylength.com/en/4/
      gnutls-min-prime-bits 3072
      tls-checktrust gnutls-verify-error
      ;; Emacs is built with `gnutls' by default, so `tls-program' would not be
      ;; used in that case. Otherwise, people have reasons to not go with
      ;; `gnutls', we use `openssl' instead. For more details, see
      ;; https://redd.it/8sykl1
      tls-program '("openssl s_client -connect %h:%p -CAfile %t -nbio -no_ssl3 -no_tls1 -no_tls1_1 -ign_eof"
                    "gnutls-cli -p %p --dh-bits=3072 --ocsp --x509cafile=%t \
--strict-tofu --priority='SECURE192:+SECURE128:-VERS-ALL:+VERS-TLS1.2:+VERS-TLS1.3' %h"
                    ;; compatibility fallbacks
                    "gnutls-cli -p %p %h"))

(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package)
  )

(eval-when-compile
  (require 'use-package))

;; IMPORTANT: Packages only on melpa need to be manually `:pin'd to `melpa'
(setq use-package-always-pin "melpa-stable")
; tell use-package to install all packages automatically
(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t
        auto-package-update-hide-results t)
  ;; Check for updates at noon daily
  (auto-package-update-at-time "12:00")
  (auto-package-update-maybe)
  )

(use-package diminish)

(provide 'init-package)
;;; init-package.el ends here
