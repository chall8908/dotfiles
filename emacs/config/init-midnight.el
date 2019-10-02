;; ;;; init-midnight.el --- Initialize Midnight mode -*- lexical-binding: t -*-

;; Author: Chris Hall
;; Maintainer: Chris Hall

;;; Code:

(defvar persp-kill-foreign-buffer-behaviour-was nil)

(defun silence-persp-mode-kill-message ()
  "Disable persp-mode 'ask on kill' behavior while midnight is cleaning up"
  (interactive)
  (setq persp-kill-foreign-buffer-behaviour-was persp-kill-foreign-buffer-behaviour
        persp-kill-foreign-buffer-behaviour 'kill))

(defun reset-persp-mode-kill-message ()
  "Rest persp-mode 'ask on kill' behavior after midnight finishes"
  (interactive)
  (setq persp-kill-foreign-buffer-behaviour persp-kill-foreign-buffer-behaviour-was))

(use-package midnight
  :config
  (midnight-delay-set 'midnight-delay "1:00am")

  ;; Silence persp mode while midnight is cleaning buffers
  (setq midnight-hook '(silence-persp-mode-kill-message
                        clean-buffer-list
                        reset-persp-mode-kill-message))
  )


(provide 'init-midnight)

;;; midnight.el ends here
