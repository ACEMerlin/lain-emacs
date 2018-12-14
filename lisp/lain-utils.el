;; lain-utils.el -*- lexical-binding: t; -*-

(use-package expand-region
  :config
  (defun evil-visual-char-or-expand-region ()
    (interactive)
    (if (region-active-p)
	(call-interactively 'er/expand-region)
      (evil-visual-char)))
  :general
  (normal "v" 'evil-visual-char-or-expand-region)
  (visual "v" 'evil-visual-char-or-expand-region)
  (visual [escape] 'evil-visual-char))

(use-package ranger
  :commands (ranger deer ranger-override-dired-mode)
  :general
  (normal "-" 'deer)
  (lain-leader-map
   "ar" 'ranger)
  :config
  (lain/dv-keys nil 'ranger-mode-map
    "j" "k" "l")
  (ranger-override-dired-mode t))

(use-package magit
  :general
  (lain-leader-map
   "gs" 'magit-status
   "gi" 'magit-init)
  :init
  (setq
   magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1
   magit-completing-read-function #'ivy-completing-read)
  :config
  (magit-change-popup-key 'magit-dispatch-popup :actions ?t ?j))

(provide 'lain-utils)
