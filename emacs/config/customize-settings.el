;;; customize-settings --- Configure custom
;;; Commentary:
;;; Code:

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package))
 '(safe-local-variable-values
   '((major-mode . sh)
     (major-mode . shell-script)
     (major-mode . sh-mode)
     (eval let
           ((project-directory
             (car
              (dir-locals-find-file default-directory))))
           (setq lsp-clients-typescript-server-args
                 `("--tsserver-path" ,(concat project-directory ".yarn/sdks/typescript/bin/tsserver")
                   "--stdio")))))
 '(whitespace-style
   '(face trailing tabs spaces lines newline missing-newline-at-eof empty indentation space-after-tab space-before-tab)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'customize-settings)
;;; customize-settings.el ends here
