;;; xterm --- Translate xterm escape sequences into emacs keybindings
;;; Commentary:
;;; Code:

(let ((x 2) (tkey ""))
  (while (<= x 8)
    ;; shift
    (if (= x 2)
        (setq tkey "S-"))
    ;; alt
    (if (= x 3)
        (setq tkey "M-"))
    ;; alt + shift
    (if (= x 4)
        (setq tkey "M-S-"))
    ;; ctrl
    (if (= x 5)
        (setq tkey "C-"))
    ;; ctrl + shift
    (if (= x 6)
        (setq tkey "C-S-"))
    ;; ctrl + alt
    (if (= x 7)
        (setq tkey "C-M-"))
    ;; ctrl + alt + shift
    (if (= x 8)
        (setq tkey "C-M-S-"))

    ;; Arrows
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d A" x)) (kbd (format "%s<up>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d B" x)) (kbd (format "%s<down>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d C" x)) (kbd (format "%s<right>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d D" x)) (kbd (format "%s<left>" tkey)))

    (define-key input-decode-map (kbd (format "M-[ 1 ; %d H" x)) (kbd (format "%s<home>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d F" x)) (kbd (format "%s<end>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 5 ; %d ~" x)) (kbd (format "%s<prior>" tkey))) ; page up
    (define-key input-decode-map (kbd (format "M-[ 6 ; %d ~" x)) (kbd (format "%s<next>" tkey))) ; page down
    (define-key input-decode-map (kbd (format "M-[ 2 ; %d ~" x)) (kbd (format "%s<insert>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 3 ; %d ~" x)) (kbd (format "%s<delete>" tkey)))

    ;; Function Keys
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d P" x)) (kbd (format "%s<f1>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d Q" x)) (kbd (format "%s<f2>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d R" x)) (kbd (format "%s<f3>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 1 ; %d S" x)) (kbd (format "%s<f4>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 15 ; %d ~" x)) (kbd (format "%s<f5>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 17 ; %d ~" x)) (kbd (format "%s<f6>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 18 ; %d ~" x)) (kbd (format "%s<f7>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 19 ; %d ~" x)) (kbd (format "%s<f8>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 20 ; %d ~" x)) (kbd (format "%s<f9>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 21 ; %d ~" x)) (kbd (format "%s<f10>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 23 ; %d ~" x)) (kbd (format "%s<f11>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 24 ; %d ~" x)) (kbd (format "%s<f12>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 25 ; %d ~" x)) (kbd (format "%s<f13>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 26 ; %d ~" x)) (kbd (format "%s<f14>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 28 ; %d ~" x)) (kbd (format "%s<f15>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 29 ; %d ~" x)) (kbd (format "%s<f16>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 31 ; %d ~" x)) (kbd (format "%s<f17>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 32 ; %d ~" x)) (kbd (format "%s<f18>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 33 ; %d ~" x)) (kbd (format "%s<f19>" tkey)))
    (define-key input-decode-map (kbd (format "M-[ 34 ; %d ~" x)) (kbd (format "%s<f20>" tkey)))

    (setq x (+ x 1))
    ))

(provide 'xterm)
