;;; init-autocomplete.el --- Configure autocomplete -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package transient)

(use-package acp)
(use-package agent-shell
  :after acp
  :ensure t
  :bind (("C-c a" . agent-shell)
         (:map agent-shell-mode-map
               ("RET" . agent-shell-newline)
               ("M-RET" . agent-shell-submit)))

  :ensure-system-package
  ((claude . "curl -fsSL https://claude.ai/install.sh | bash")
   (claude-agent-acp . "npm install -g @agentclientprotocol/claude-agent-acp"))

  :config
  (setq agent-shell-preferred-agent-config (agent-shell-anthropic-make-claude-code-config)
        agent-shell-session-strategy 'new
        agent-shell-prefer-viewport-interaction t
        agent-shell-mcp-servers
        `(((name . "context7")
           (type . "http")
           (headers . (((name . "Authorization")
                        (value . ,(concat "Bearer " (or (getenv "CONTEXT7_API_KEY") ""))))))
           (url . "https://mcp.context7.com/mcp"))
          ((name . "atlassian")
           (type . "http")
           (headers . [])
           (url . "https://mcp.atlassian.com/v1/mcp"))
          ((name . "aws-knowledge")
           (type . "http")
           (headers . [])
           (url . "https://knowledge-mcp.global.api.aws"))
          ((name . "aws-iac-knowledge")
           (command . "uvx")
           (args . ["awslabs.aws-iac-mcp-server@latest"]))
          ((name . "datadog")
           (type . "http")
           (headers . (((name . "Authorization")
                        (value . ,(concat "Bearer " (or (getenv "DD_PAT") ""))))))
           (url . "https://mcp.us5.datadoghq.com/v1/mcp?toolsets=core,ddsql,error-tracking,kubernetes,onboarding,rum,security,software-delivery"))
          ((name . "github")
           (type . "http")
           (headers . (((name . "Authorization")
                        (value . ,(concat "Bearer " (or (getenv "GH_TOKEN") ""))))))
           (url . "https://api.githubcopilot.com/mcp/"))
          ;; ((name . "firefox-devtools")
          ;;  (command . "npx")
          ;;  (args . ["-y", "firefox-devtools-mcp@latest", "--headless", "--viewport", "1280x720"]))
          ;; ((name . "rubocop")
          ;;  (command . "bundle")
          ;;  (args . ["exec", "rubocop", "--mcp"]))
          )))

(use-package agent-review
  :straight '(agent-review
              :type git
              :host github
              :repo "nineluj/agent-review")
  :config
)

(use-package corfu
  :init
  (global-corfu-mode))

(use-package corfu-terminal
  :after corfu
  :straight '(corfu-terminal
              :type git
              :repo "https://codeberg.org/akib/emacs-corfu-terminal.git")
  :unless (display-graphic-p)
  :init
  (corfu-terminal-mode +1))

(use-package pos-tip)

(use-package copilot
  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("M-<return>" . 'copilot-accept-completion-by-line)
              ("M-RET" . 'copilot-accept-completion-by-line)
              ("C-g" . 'copilot-clear-overlay)
              ("M-[" . 'copilot-previous-completion)
              ("M-]" . 'copilot-next-completion))
  :hook (prog-mode . copilot-mode)
  :ensure t)

(provide 'init-autocomplete)

;;; init-autocomplete.el ends here
