;;; init --- User initialization file
;;; Commentary:
;;; Code:

; FFS package, I'm configuring you elsewhere
;(package-initialize)

(defvar config-dir (concat user-emacs-directory "config"))

;; Add config director to the load path
(add-to-list 'load-path config-dir)

;; emacs may tell you this file isn't there; it lies
(require 'package-setup)
(require 'tmux-keybinds) ; fix keybinds in tmux
(require 'whoami)        ; load user information
(require 'curtains)      ; configure general appearance
(require 'neotree-setup)

;; setup midnight to clean unused buffers
(require 'midnight)
(midnight-delay-set 'midnight-delay "1:00am")

;; disable vc-git
(setq vc-handled-backends ())

;; log edit mode for Commits and whatnot
(require 'log-edit)
(require 'vc-git)
(add-to-list 'auto-mode-alist '("COMMIT_EDITMSG\\'" . vc-git-log-edit-mode))

;; No tool bar in windowd mode
;(tool-bar-mode -1)

;; IDO mode
(ido-mode t)

;; .tpl to html
(setq auto-mode-alist
      (append '(("\.tpl$"  . web-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.erb$"  . web-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.hbs$"  . html-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.tt$"  . web-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.scss$"  . sass-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.yaml$"  . yaml-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.todo$"  . org-mode))
              auto-mode-alist))

(setq auto-mode-alist
      (append '(("\.py$"    . python-mode))
              auto-mode-alist))

;; Sql Mode
(eval-after-load "sql"
  '(load-library "sql-indent"))
(add-hook 'sql-mode-hook 'sql-highlight-postgres-keywords)

;; Yasnippet
(require 'yasnippet)
(yas-global-mode 1)

;;; auto complete mod
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>") ; why two?

(add-hook 'js2-mode-hook 'ac-js2-mode)
(setq ac-js2-evaluate-calls t)

;; Emmet Coding
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'html-mode-hook 'emmet-mode)
(add-hook 'web-mode-hook' 'emmet-mode)
(add-hook 'css-mode-hook  'emmet-mode)
(setq emmet-expand-jsx-className? t) ;; default nil
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(add-hook 'markdown-mode-hook 'visual-line-mode)

;; Indent levels
(setq js-indent-level 2)
(setq js2-indent-level 2)
(setq groovy-indent-offset 2)

;; All the js setup
(add-to-list 'auto-mode-alist '("\\.js[x]?\\'" . web-mode))       ;; JS + JSX
(setq js2-highlight-level 3)
(setq js2-basic-offset 2)
(setq js2-indent-switch-body t)

;; Ruby setup
(require 'rinari)
(require 'ruby-tools)
(require 'rspec-mode)
(add-hook 'ruby-mode-hook #'ruby-extra-highlight-mode)

(eval-after-load 'rspec-mode
  '(rspec-install-snippets))

;; When Rinari mode is loaded, add extra bindings to its key map enabling the
;; use of M-R and M-r as its prefixes. The easier to type M-r is used for the
;; frequently used `find' functions and M-R is used for the more infrequently
;; used rake/script/web-server commands. M-r is normally bound to
;; `move-to-window-line-top-bottom', which I can do without, and M-R is
;; normally unbound. Examples of the changes below; it should be obvious how to
;; pick your own prefixes if you don't like mine.
;;
;; Function                  Default Binding    New Binding
;; ========                  ===============    ===========
;; rinari-find-controller    C-c ; f c          M-r c
;; rinari-web-server         C-c ; w            M-R w
(add-hook 'rinari-minor-mode-hook '
          (lambda ()
	          (define-prefix-command 'pd-rinari-map1)
	          (define-prefix-command 'pd-rinari-map2)
	          (local-set-key (kbd "M-R") 'pd-rinari-map1)
	          (local-set-key (kbd "M-r") 'pd-rinari-map2)

	          (define-key pd-rinari-map1 "'" 'rinari-find-by-context)
	          (define-key pd-rinari-map1 ";" 'rinari-find-by-context)
	          (define-key pd-rinari-map1 "c" 'rinari-console)
	          (define-key pd-rinari-map1 "d" 'rinari-cap)
	          (define-key pd-rinari-map1 "e" 'rinari-insert-erb-skeleton)
	          (define-key pd-rinari-map1 "g" 'rinari-rgrep)
	          (define-key pd-rinari-map1 "p" 'rinari-goto-partial)
	          (define-key pd-rinari-map1 "q" 'rinari-sql)
	          (define-key pd-rinari-map1 "r" 'rinari-rake)
	          (define-key pd-rinari-map1 "s" 'rinari-script)
	          (define-key pd-rinari-map1 "t" 'rinari-test)
	          (define-key pd-rinari-map1 "w" 'rinari-web-server)
	          (define-key pd-rinari-map1 "x" 'rinari-extract-partial)

	          (define-key pd-rinari-map2 ";" 'rinari-find-by-context)
	          (define-key pd-rinari-map2 "C" 'rinari-find-cells)
	          (define-key pd-rinari-map2 "F" 'rinari-find-features)
	          (define-key pd-rinari-map2 "M" 'rinari-find-mailer)
	          (define-key pd-rinari-map2 "S" 'rinari-find-steps)
	          (define-key pd-rinari-map2 "Y" 'rinari-find-sass)
	          (define-key pd-rinari-map2 "a" 'rinari-find-application)
	          (define-key pd-rinari-map2 "c" 'rinari-find-controller)
	          (define-key pd-rinari-map2 "e" 'rinari-find-environment)
	          (define-key pd-rinari-map2 "f" 'rinari-find-file-in-project)
	          (define-key pd-rinari-map2 "h" 'rinari-find-helper)
	          (define-key pd-rinari-map2 "i" 'rinari-find-migration)
	          (define-key pd-rinari-map2 "j" 'rinari-find-javascript)
	          (define-key pd-rinari-map2 "l" 'rinari-find-lib)
	          (define-key pd-rinari-map2 "m" 'rinari-find-model)
	          (define-key pd-rinari-map2 "n" 'rinari-find-configuration)
	          (define-key pd-rinari-map2 "o" 'rinari-find-log)
	          (define-key pd-rinari-map2 "p" 'rinari-find-public)
	          (define-key pd-rinari-map2 "r" 'rinari-find-rspec)
	          (define-key pd-rinari-map2 "s" 'rinari-find-script)
	          (define-key pd-rinari-map2 "t" 'rinari-find-test)
	          (define-key pd-rinari-map2 "u" 'rinari-find-plugin)
	          (define-key pd-rinari-map2 "v" 'rinari-find-view)
	          (define-key pd-rinari-map2 "w" 'rinari-find-worker)
	          (define-key pd-rinari-map2 "x" 'rinari-find-fixture)
	          (define-key pd-rinari-map2 "y" 'rinari-find-stylesheet)
	          (define-key pd-rinari-map2 "z" 'rinari-find-rspec-fixture)
	          ))

;; for better jsx syntax-highlighting in web-mode
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))

;; set web-mode-content-type to jsx for js and jsx files
(setq web-mode-content-types-alist
      '(("jsx" . "\\.js[x]?\\'")))

(defadvice yas-expand-from-trigger-key (before web-mode-before-yas-expand activate)
  "Not actually sure what this does."
  (run-hooks 'web-mode-cur-language-mode-hook))

;; Add embedded elixir to web-mode
(add-to-list `auto-mode-alist `("\\.eex\\'" . web-mode))

;; Use proper snippets depending on where my cursor is
(add-hook 'web-mode-cur-language-mode-hook
          '(lambda ()
             (ignore-errors
               (let ((web-mode-cur-language
                      (web-mode-language-at-pos)))
                 (if (string= web-mode-cur-language "php")
                     (yas-activate-extra-mode 'php-mode)
                   (yas-deactivate-extra-mode 'php-mode))
                 (if (string= web-mode-cur-language "html")
                     (yas-activate-extra-mode 'html-mode)
                   (yas-deactivate-extra-mode 'html-mode))
                 (if (string= web-mode-cur-language "jsx")
                     (yas-activate-extra-mode 'js2-mode)
                   (yas-deactivate-extra-mode 'js2-mode))
                 (if (string= web-mode-cur-language "elixir")
                     (yas-activate-extra-mode 'elixir-mode)
                   (yas-deactivate-extra-mode 'elixir-mode))
                 ))))

(add-hook `js-mode-hook `editorconfig-mode)
(add-hook `js-mode-hook
          (lambda ()
            ;; Scan the file for nested code blocks
            (imenu-add-menubar-index)
            ;; Activate the folding mode
            (hs-minor-mode t)))

(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'web-mode)
(setq-default flycheck-temp-prefix ".flycheck")
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))
;; Https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; adjust indents for web-mode to 2 spaces
(defun adjust-web-mode ()
  "Hooks for Web mode.  Adjust indent."
    ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-js-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t))
(add-hook 'web-mode-hook  'adjust-web-mode)

(add-hook 'local-write-file-hooks
          (lambda ()
            (delete-trailing-whitespace)
            nil))

;; paren hilite
;; http://www.emacsblog.org/2007/08/07/quick-tip-show-paren-mode/
(show-paren-mode t)
;; (setq show-paren-style 'expression)

;; http://infolab.stanford.edu/~manku/dotemacs.html
(transient-mark-mode t) ; highlight marked region

(setq-default delete-old-versions 't)

;; Tab 2
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-width 2) ; or any other preferred value

(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)

(defun custom-goto-match-beginning ()
  "Use with isearch hook to end search at first char of match."
  (when isearch-forward (goto-char isearch-other-end)))
;; ----------------------------------------

(setq resize-minibuffer-mode t)

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
  ;; setup clipboard copy/paste here
  (progn)
  )
 );

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(ansi-term-color-vector
   [unspecified "#181818" "#ab4642" "#a1b56c" "#f7ca88" "#7cafc2" "#ba8baf" "#7cafc2" "#d8d8d8"])
 '(css-indent-offset 2)
 '(custom-safe-themes
   (quote
    ("f245c9f24b609b00441a6a336bcc556fe38a6b24bfc0ca4aedd4fe23d858ba31" "cbef37d6304f12fb789f5d80c2b75ea01465e41073c30341dc84c6c0d1eb611d" "a0fdc9976885513b03b000b57ddde04621d94c3a08f3042d1f6e2dbc336d25c7" "c56d90af9285708041991bbc780a073182cbe91721de17c6e7a8aac1380336b3" "2a86b339554590eb681ecf866b64ce4814d58e6d093966b1bf5a184acf78874d" "8f1cedf54f137f71382e3367e1843d10e173add99abe3a5f7d3285f5cc18f1a9" "7b7ef508f9241c01edaaff3e0d6f03588a6f4fddb1407a995a7a333b29e327b5" "e3c90203acbde2cf8016c6ba3f9c5300c97ddc63fcb78d84ca0a144d402eedc6" "f15a7ce08b9e13553c1f230678e9ceb5b372f8da26c9fb815eb20df3492253b7" "8022cea21aa4daca569aee5c1b875fbb3f3248a5debc6fc8cf5833f2936fbb22" "9bac44c2b4dfbb723906b8c491ec06801feb57aa60448d047dbfdbd1a8650897" "1affe85e8ae2667fb571fc8331e1e12840746dae5c46112d5abb0c3a973f5f5a" "ae8d0f1f36460f3705b583970188e4fbb145805b7accce0adb41031d99bd2580" "405fda54905200f202dd2e6ccbf94c1b7cc1312671894bc8eca7e6ec9e8a41a2" "41b6698b5f9ab241ad6c30aea8c9f53d539e23ad4e3963abff4b57c0f8bf6730" "978ff9496928cc94639cb1084004bf64235c5c7fb0cfbcc38a3871eb95fa88f6" "f41fd682a3cd1e16796068a2ca96e82cfd274e58b978156da0acce4d56f2b0d5" "de2c46ed1752b0d0423cde9b6401062b67a6a1300c068d5d7f67725adc6c3afb" "e53cc4144192bb4e4ed10a3fa3e7442cae4c3d231df8822f6c02f1220a0d259a" "51bea7765ddaee2aac2983fac8099ec7d62dff47b708aa3595ad29899e9e9e44" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "3d6b08cd1b1def3cc0bc6a3909f67475e5612dba9fa98f8b842433d827af5d30" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" default)))
 '(fci-rule-color "#393939")
 '(package-selected-packages
   (quote
    (use-package django-mode rinari rubocop ac-inf-ruby rspec-mode ruby-additional ruby-end ruby-extra-highlight ruby-tools yard-mode robe s groovy-mode markdown-mode markdown-preview-mode markdown-toc neotree yaml-mode web-mode scss-mode react-snippets python-mode php-mode names multiple-cursors less-css-mode json-mode flycheck-mix flycheck-elixir find-file-in-project feature-mode exec-path-from-shell evil-nerd-commenter elixir-yasnippets dockerfile-mode color-theme coffee-mode base16-theme apples-mode ac-js2 ac-ispell ac-html-bootstrap ac-html ac-helm ac-emmet)))
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#f2777a")
     (40 . "#f99157")
     (60 . "#ffcc66")
     (80 . "#99cc99")
     (100 . "#66cccc")
     (120 . "#6699cc")
     (140 . "#cc99cc")
     (160 . "#f2777a")
     (180 . "#f99157")
     (200 . "#ffcc66")
     (220 . "#99cc99")
     (240 . "#66cccc")
     (260 . "#6699cc")
     (280 . "#cc99cc")
     (300 . "#f2777a")
     (320 . "#f99157")
     (340 . "#ffcc66")
     (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil)
 '(when (not (facep (aref ansi-term-color-vector 0)))))

;; web mode
(defun web-mode-keybindings()
  (define-key web-mode-map (kbd "C-c r") 'web-mode-reload))
(add-hook 'web-mode-hook  'web-mode-keybindings)

(require 'general-keybinds)

;; Org mode
;; (require 'org-install)
;; (require 'org-mobile)
;; (setq org-directory "~/Dropbox (Personal)/org")
;; (setq org-agenda-files (list "~/Dropbox (Personal)/org"))
;; (setq org-mobile-inbox-for-pull "~/Dropbox (Personal)/org/inbox.org")
;; (setq org-mobile-directory "~/Dropbox (Personal)/Apps/MobileOrg")
;; (setq org-mobile-files '("~/Dropbox (Personal)/org"))

;; (Setq org-log-done 'time)

;; (define-key global-map "\C-cl" 'org-store-link)
;; (define-key global-map "\C-ca" 'org-agenda)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-call ((t (:inherit default)))))

(provide 'init)
;;; init.el ends here
