;;; copy-paste -- Configure copy/paste behavior
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

(cond
 ((string-equal system-type "darwin")
  (progn
    (setq interprogram-cut-function 'copy-to-macos)
    (setq interprogram-paste-function 'paste-from-macos))
  )
 ((string-equal system-type "gnu/linux")
  (setq select-enable-clipboard t)
  (progn)
  )
 )

(provide 'copy-paste)
;;; copy-paste.el ends here
