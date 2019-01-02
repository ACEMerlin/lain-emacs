;; lain-emacs-lisp.el -*- lexical-binding: t; -*-


;; From Doom Emacs, to defer loading elisp-mode
(delq 'elisp-mode features)
(advice-add #'emacs-lisp-mode :before #'defer-elisp-mode)
(defun defer-elisp-mode (&rest _)
  (when (and emacs-lisp-mode-hook
	     (not delay-mode-hooks))
    (provide 'elisp-mode)
    (advice-remove #'emacs-lisp-mode #'defer-elisp-mode)))


;; Main config
(use-feature elisp-mode
  :lain-major-mode emacs-lisp-mode
  :gfhook
  ('emacs-lisp-mode-hook 'turn-on-smartparens-strict-mode)
  ('emacs-lisp-mode-hook 'evil-cleverparens-mode)
  :general
  (lain-emacs-lisp-mode-map
   "c" 'emacs-lisp-byte-compile
   "e" 'lain/eval-current-form-sp
   "s" 'lain/eval-current-symbol-sp
   "f" 'lain/eval-current-form
   "F" 'eval-defun
   "b" 'eval-buffer)
  :config
  ;; Borrowed from Spacemacs
  (defun lain/eval-current-form ()
    "Find and evaluate the current def* or set* command.
Unlike `eval-defun', this does not go to topmost function."
    (interactive)
    (save-excursion
      (search-backward-regexp "(def\\|(set")
      (forward-list)
      (call-interactively 'eval-last-sexp)))
  (defun lain/eval-current-form-sp (&optional arg)
    "Call `eval-last-sexp' after moving out of `arg' levels of parentheses"
    (interactive "p")
    (let ((evil-move-beyond-eol t))
      (save-excursion
	(sp-up-sexp arg)
	(call-interactively 'eval-last-sexp))))
  (defun lain/eval-current-symbol-sp ()
    "Call `eval-last-sexp' on the symbol around point. "
    (interactive)
    (let ((evil-move-beyond-eol t))
      (save-excursion
	(sp-forward-symbol)
	(call-interactively 'eval-last-sexp)))))

(use-feature ielm
  :gfhook 'turn-on-smartparens-strict-mode
  :general
  (lain-emacs-lisp-mode-map
   "'" 'ielm))

(use-package macrostep
  :gfhook 'evil-normalize-keymaps
  :general
  (normal
   macrostep-keymap
   "q"   'macrostep-collapse-all
   "e"   'macrostep-expand
   "u"   'macrostep-collapse
   "C-t" 'macrostep-next-macro
   "C-n" 'macrostep-prev-macro)
  (lain-emacs-lisp-mode-map
   "m" 'macrostep-expand))

(use-feature edebug
  :gfhook 'evil-normalize-keymaps
  :general
  (lain-emacs-lisp-mode-map
   "d" 'lain/edebug-defun
   "D" 'edebug-defun)
  (edebug-mode-map
   "t"   'evil-next-line
   "T"   'edebug-trace-mode
   "C-t" 'edebug-Trace-fast-mode
   "h"   'evil-backward-char
   "H"   'edebug-goto-here
   "n"   'evil-previous-line
   "N"   'edebug-next-mode)
  :config
  (evil-set-initial-state edebug-mode 'normal)
  (defun lain/edebug-defun ()
    "Find and edebug the current def* command.
Unlike `edebug-defun', this does not go to topmost function."
    (interactive)
    (save-excursion
      (search-backward-regexp "(def")
      (mark-sexp)
      (narrow-to-region (point) (mark))
      (deactivate-mark)
      (edebug-defun)
      (message "Edebug enabled")
      (widen))))

(use-package indent-guide
  :diminish
  :ghook 'emacs-lisp-mode-hook)

(use-package aggressive-indent
  :diminish
  :ghook 'emacs-lisp-mode-hook)

(use-package elisp-def
  :diminish
  :ghook 'emacs-lisp-mode-hook
  :general
  ((normal insert)
   elisp-def-mode-map
   "M-." 'elisp-def))

(provide 'lain-emacs-lisp)
