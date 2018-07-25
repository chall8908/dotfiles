;;; emmet.el --- Configure emmet mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package emmet-mode
  :hook (html-mode
         web-mode
         css-mode)

  :config (setq emmet-expand-jsx-className? t)
  )

(use-package ac-emmet
  :after (auto-complete)
  :pin melpa
  )

(provide 'emmet)
;;; emmet.el ends here
