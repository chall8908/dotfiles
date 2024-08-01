;;; web -- Configuration for web-mode
;;; Commentary:
;;; Code:

(use-package web-mode
  ;; :after (yasnippet flycheck)
  :after (yasnippet)
  :mode ("\.erb$"     ; embedded Ruby
         "\.[jt]sx?$" ; JS + JSX, TS + TSX
         "\.eex$"     ; embedded Elixir
         "\.html$"
         )

  :config
  ;; for better jsx syntax-highlighting in web-mode
  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (or (equal web-mode-content-type "jsx") (equal web-mode-content-type "tsx"))
        (let ((web-mode-enable-part-face nil))
          ad-do-it)
      ad-do-it))

  ;; set web-mode-content-type to jsx for js/jsx files
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.jsx?\\'")
          ("tsx" . "\\.tsx?\\'")))

  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-js-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t)
  )

(use-package company-web
  :after company
  )

(provide 'web)
;;; web.el ends here
