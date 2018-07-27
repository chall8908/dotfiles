;;; emmet.el --- Configure emmet mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package emmet-mode
  :hook (html-mode
         web-mode
         css-mode)

  :config (setq emmet-expand-jsx-className? t)
  )

(provide 'emmet)
;;; emmet.el ends here
