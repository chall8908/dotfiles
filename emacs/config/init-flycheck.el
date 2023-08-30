;;; init-flycheck.el --- Configure flycheck -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package flycheck
  ;; :hook (after-init global-flycheck-mode)
  :config
  (setq-default flycheck-disabled-checkers (append flycheck-disabled-checkers '(javascript-jshint json-jsonlist))
                flycheck-temp-prefix ".flycheck")

  (flycheck-add-mode 'javascript-standard 'js2-mode)
  (flycheck-add-mode 'javascript-standard 'web-mode)
  (flycheck-add-mode 'typescript-tslint 'typescript-mode)
  (flycheck-add-mode 'ruby-standard 'ruby-mode)
  )

(use-package flyspell-correct-ivy
  :after ivy)

(provide 'init-flycheck)
;;; init-flycheck.el ends here
