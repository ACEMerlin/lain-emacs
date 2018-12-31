;; lain-evil.el -*- lexical-binding: t; -*-

;; Dvorak: "hjkl" => "htns"
(use-package evil
  :gfhook ('evil-insert-state-exit-hook #'lain/save-file)
  :defer .1  ;; we want evil but we also want SPEED...
  :init
  (setq
   evil-disable-insert-state-bindings t
   evil-want-C-i-jump nil
   evil-want-C-u-scroll t
   evil-respect-visual-line-mode t)
  :general
  (lain-leader-map
   "SPC" 'evil-avy-goto-char-timer
   "wH"  'evil-window-move-far-left
   "wh"  'evil-window-left
   "wT"  'evil-window-move-very-bottom
   "wt"  'evil-window-down
   "wN"  'evil-window-move-very-top
   "wn"  'evil-window-up
   "wS"  'evil-window-move-far-right
   "ws"  'evil-window-right)
  :config
  (lain/dv-keys nil 'motion
    "j" "J" "k" "l")
  (lain/dv-keys nil 'normal
    "l" "J")
  (diminish 'undo-tree-mode)  ;; please remove undo-tree from evil...
  (evil-mode 1))

(use-package evil-surround
  :demand t
  :after evil
  :config
  (global-evil-surround-mode +1))

(use-package evil-commentary
  :demand t
  :diminish
  :after evil
  :config
  (evil-commentary-mode +1))

(use-package evil-lion
  :demand t
  :after evil
  :config
  (evil-lion-mode +1))

(use-package evil-goggles
  :demand t
  :diminish
  :after evil
  :init
  (setq
   evil-goggles-pulse nil
   evil-goggles-async-duration 0.1
   evil-goggles-blocking-duration 0.05)
  :config
  (evil-goggles-mode +1))

(use-package evil-escape
  :diminish
  :demand t
  :after evil
  :init
  (setq
   evil-escape-excluded-states '(normal visual emacs motion multiedit)
   evil-escape-key-sequence "tn"
   evil-escape-delay 0.2)
  :config
  (evil-escape-mode +1))

(use-package evil-cleverparens
  :diminish
  :config
  (lain/dv-keys 'normal 'evil-cleverparens-mode-map
    "l" "M-j" "M-k")
  (evil-cleverparens-mode +1))

(use-package evil-multiedit
  :general
  ("C->" 'evil-multiedit-match-and-next
   "C-<" 'evil-multiedit-match-and-prev)
  (lain-leader-map
   "mm" 'evil-multiedit-match-all
   "mr" 'evil-multiedit-restore
   "ma" 'evil-multiedit-toggle-marker-here)
  (evil-multiedit-insert-state-map
   "C-t" 'evil-multiedit-next
   "C-n" 'evil-multiedit-prev)
  (evil-multiedit-state-map
   "RET" 'evil-multiedit-toggle-or-restrict-region
   "C-t" 'evil-multiedit-next
   "C-n" 'evil-multiedit-prev))

(provide 'lain-evil)
