;;; mac-behavior.el --- Configure Mac specific behaviors -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; Copy-paste via the clipboard
(defun paste-from-macos ()
  "Yank from the MacOS clipboard."
  (shell-command-to-string "pbpaste"))

(defun copy-to-macos (text &optional push)
  "Copy TEXT into the MacOS clipboard.
PUSH exists for compatability reasons."
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'copy-to-macos)
(setq interprogram-paste-function 'paste-from-macos)

;; Https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize)
  )

(provide 'mac-behavior)

;;; mac-behavior.el ends here
