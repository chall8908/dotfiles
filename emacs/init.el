;;; init --- User initialization file
;;; Commentary:
;;; Code:

;; This has to be here - commented out, since it's called elsewhere - or package bitches and adds it back
;; (package-initialize)

;; Add config directory to the load path
(add-to-list 'load-path (concat user-emacs-directory "config"))

(require 'custom)        ; loads custom-set stuff
(require 'whoami)        ; load user information
(require 'init-package)
(require 'behavior)      ; configure general behavior
(require 'tmux-keybinds) ; fix keybinds in tmux
(require 'init-ivy)
(require 'init-neotree)

;; setup midnight to clean unused buffers
(use-package midnight
  :config
  (midnight-delay-set 'midnight-delay "1:00am")
  )

(use-package evil-nerd-commenter)

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
(use-package yasnippet
  :config
  (yas-global-mode 1)
  :init
  ;;; auto complete mod
  ;;; should be loaded after yasnippet so that they can work together
  (require 'auto-complete-config)

  (add-hook 'js2-mode-hook #'ac-js2-mode)
  (setq ac-js2-evaluate-calls t)

  (add-to-list 'ac-dictionary-directories (concat user-emacs-directory "ac-dict"))
  (ac-config-default)
  ;;; set the trigger key so that it can work together with yasnippet on tab key,
  ;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
  ;;; activate, otherwise, auto-complete will
  (ac-set-trigger-key "TAB")
  (ac-set-trigger-key "<tab>") ; why two?
  )

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

(add-hook 'isearch-mode-end-hook 'custom-goto-match-beginning)

(defun custom-goto-match-beginning ()
  "Use with isearch hook to end search at first char of match."
  (when isearch-forward (goto-char isearch-other-end)))
;; ----------------------------------------

(setq resize-minibuffer-mode t)

;; web mode
(defun web-mode-keybindings()
  (define-key web-mode-map (kbd "C-c r") 'web-mode-reload))
(add-hook 'web-mode-hook  'web-mode-keybindings)

(require 'general-keybinds)

(require 'appearance) ; configure general appearance

(provide 'init)
;;; init.el ends here
