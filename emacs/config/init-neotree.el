;;; init-neotree --- Setup neotree
;;; Commentary:
;;; Code:

;; slated for eventual use once I hack neotree together, maybe
;; doesn't work with URxvt.  Maybe switch to a more feature rich terminal?
;; (use-package all-the-icons
;;   :config
;;   (let* ((font-check-file (expand-file-name "fonts-installed" user-emacs-directory))
;;          (fonts-installed (file-exists-p font-check-file))
;;          )
;;     (when (not fonts-installed)
;;       (all-the-icons-install-fonts)
;;       (write-region "" nil font-check-file)
;;       )
;;     )
;;   )

(use-package neotree
  ;; :after (all-the-icons)
  :pin melpa
  :init
  (add-hook 'neo-after-create-hook (lambda (&rest _) (display-line-numbers-mode -1)))
  (setq neo-autorefresh t
        neo-show-hidden-files t
        neo-force-change-root t
        neo-create-file-auto-open t
        neo-toggle-window-keep-p t
        neo-hide-cursor t
        neo-theme 'nerd)
  )

(provide 'init-neotree)
;;; init-neotree.el ends here
