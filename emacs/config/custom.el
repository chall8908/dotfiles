;;; custom --- Configure custom
;;; Commentary:
;;; Code:

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
    (ivy use-package django-mode rinari rubocop ac-inf-ruby rspec-mode ruby-additional ruby-end ruby-extra-highlight ruby-tools yard-mode robe s groovy-mode markdown-mode markdown-preview-mode markdown-toc neotree yaml-mode web-mode scss-mode react-snippets python-mode php-mode names multiple-cursors less-css-mode json-mode flycheck-mix flycheck-elixir find-file-in-project feature-mode exec-path-from-shell evil-nerd-commenter elixir-yasnippets dockerfile-mode color-theme coffee-mode base16-theme apples-mode ac-js2 ac-ispell ac-html-bootstrap ac-html ac-helm ac-emmet)))
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

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(js2-function-call ((t (:inherit default)))))

(provide 'custom)
;;; custom.el ends here
