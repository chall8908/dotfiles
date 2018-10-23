;;; init-flycheck.el --- Configure flycheck -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package flycheck
  ;; :hook (after-init global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(javascript-jshint json-jsonlist))
                flycheck-temp-prefix ".flycheck")

  (flycheck-add-mode 'javascript-eslint 'js2-mode)
  (flycheck-add-mode 'javascript-eslint 'web-mode)
  )

(use-package flyspell-correct-ivy
  :after ivy)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
