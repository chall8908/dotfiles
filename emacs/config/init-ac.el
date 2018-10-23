;;; init-ac.el --- Provides configuration for autocomplete -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package auto-complete
  :diminish
  :config
  (ac-set-trigger-key "TAB")
  (setq ac-auto-start nil))

(use-package ac-capf
  :after auto-complete
  :diminish)

(provide 'init-ac)

;;; init-ac.el ends here
