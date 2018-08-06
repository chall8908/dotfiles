;;; linux-behavior.el --- Linux specific behaviors -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; use xclip from GNU's ELPA to ensure that copy-paste works correctly in xterm
(use-package xclip
  :pin gnu
  :config
  (xclip-mode 1)
  )

(provide 'linux-behavior)

;;; linux-behavior.el ends here
