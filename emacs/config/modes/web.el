;;; web -- Configuration for web-mode
;;; Commentary:
;;; Code:

(use-package web-mode
  ;; :after (yasnippet flycheck)
  :after (yasnippet)
  :mode ("\.erb$"       ; embedded Ruby
         "\.js[x]?$" ; JS + JSX
         "\.eex$"    ; embedded Elixir
         "\.html$"
         )

  :bind ("C-c r" . web-mode-reload)

  :config
  ;; for better jsx syntax-highlighting in web-mode
  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
        (let ((web-mode-enable-part-face nil))
          ad-do-it)
      ad-do-it))

  ;; set web-mode-content-type to jsx for js and jsx files
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'")))

  (setq web-mode-markup-indent-offset 2
        web-mode-css-indent-offset 2
        web-mode-js-indent-offset 2
        web-mode-code-indent-offset 2
        web-mode-enable-current-element-highlight t
        web-mode-enable-current-column-highlight t)

  (defadvice yas-expand-from-trigger-key (before web-mode-before-yas-expand activate)
    "Ensures the correct snippets are used for the current web-mode language."
    (run-hooks 'web-mode-cur-language-mode-hook))

  ;; Use proper snippets depending on where my cursor is
  (add-hook 'web-mode-cur-language-mode-hook
            '(lambda ()
               (ignore-errors
                 (let ((web-mode-cur-language
                        (web-mode-language-at-pos)))
                   (if (string= web-mode-cur-language "php")
                       (yas-activate-extra-mode 'php-mode)
                     (yas-deactivate-extra-mode 'php-mode))
                   (if (string= web-mode-cur-language "html")
                       (yas-activate-extra-mode 'html-mode)
                     (yas-deactivate-extra-mode 'html-mode))
                   (if (string= web-mode-cur-language "jsx")
                       (yas-activate-extra-mode 'js2-mode)
                     (yas-deactivate-extra-mode 'js2-mode))
                   (if (string= web-mode-cur-language "elixir")
                       (yas-activate-extra-mode 'elixir-mode)
                     (yas-deactivate-extra-mode 'elixir-mode))
                   ))))
  )

(use-package company-web
  :after company
  )

(provide 'web)
;;; web.el ends here
