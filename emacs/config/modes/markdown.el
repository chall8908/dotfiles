;;; markdown.el --- Configure markdown-mode -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :config
  (add-hook 'markdown-mode-hook 'visual-line-mode)
  )

(use-package markdown-preview-mode
  :after (markdown-mode)
  )

(use-package markdown-toc
  :after (markdown-mode)
  )

(provide 'markdown)

;;; markdown.el ends here
