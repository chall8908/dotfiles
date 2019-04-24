;;; typescript.el --- Typescript setup -*- lexical-binding: t -*-

;; Author: Chris Hall
;; Maintainer: Chris Hall

;;; Code:


(use-package typescript-mode
  :mode "\\.tsx?$"
  :config
  (setq typescript-indent-level 2
        typescript-expr-indent-offset 2)
  )

(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-formatter-before-save))
  )

(provide 'typescript)

;;; typescript.el ends here
