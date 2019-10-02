;;;;;; switches.el --- Adds additional startup switches to Emacs -*- lexical-binding: t -*-

;; Author: Chris Hall
;; Maintainer: Chris Hall

;;; Code:

(add-to-list 'command-switch-alist
             (cons "persp"
                   #'(lambda (persp-name)
                       (if persp-name
                           (persp-switch persp-name)
                         ((persp-switch "default"))))))

(add-to-list 'command-switch-alist
             (cons "no-persp"
                   #'(lambda (p)
                       (setq persp-auto-resume-time -1
                             persp-auto-save-opt 0))))

(add-to-list 'command-switch-alist
             (cons "no-tabnine"
                   #'(lambda (p)
                       (setq company-tabnine--disable 1)
                       (add-hook `company-tabnine--hooks-alist `company-tabnine-kill-process))))

(provide 'switches)

;;; switches.el ends here
