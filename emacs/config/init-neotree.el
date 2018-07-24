;;; init-neotree --- Setup neotree
;;; Commentary:
;;; Code:

(use-package neotree
  :config
  (setq neo-smart-open nil
        neo-autorefresh t
        neo-force-change-root t)
  (neo-global--open) ;; automatically open neotree on startup
  )

(provide 'init-neotree)
;;; init-neotree.el ends here
