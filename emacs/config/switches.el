;;; switches.el --- Adds additional startup switches to Emacs

;; Author: Chris Hall
;; Maintainer: Chris Hall

;;; Code:

(defvar config-switch-disable-persp-mode nil)
(add-to-list 'command-switch-alist
             (cons "no-persp"
                   #'(lambda (&rest _)
                       (setq config-switch-disable-persp-mode t))))

(defvar config-switch-disable-tabnine nil)
(add-to-list 'command-switch-alist
             (cons "no-tabnine"
                   #'(lambda(&rest _)
                       (setq config-switch-disable-tabnine t))))

(defvar config-switch-disable-neotree nil)
(add-to-list 'command-switch-alist
             (cons "no-neotree"
                   #'(lambda (&rest _)
                       (setq config-switch-disable-neotree t))))

(provide 'switches)

;;; switches.el ends here
