;;; neotree-setup --- Setup neotree
;;; Commentary:
;;; Code:

(require 'neotree)
(setq neo-smart-open nil)
(setq neo-autorefresh t)
(setq neo-force-change-root t)

(neo-global--open) ;; automatically open neotree on startup

(provide 'neotree-setup)
;;; neotree-setup.el ends here
