(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives)
(push '("melpa" . "http://melpa.org/packages/")
      package-archives)

(package-initialize)

(require 'cask "~/.cask/cask.el")
(cask-initialize)

(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load "~/.emacs.d/lisp/custom.el")

(setq 
  inhibit-startup-message t
  linum-format "%d "
  shell-file-name "/bin/bash"
  evil-want-C-u-scroll t
  default-directory (getenv "HOME")
  default-major-mode 'text-mode
  require-final-newline t
  show-trailing-whitespace t)

(blink-cursor-mode 0)
(global-linum-mode t)
(global-flycheck-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Buffer settings
(setq-default indent-tabs-mode nil)

;; Tema
(load-theme 'wombat t)

(require 'use-package)

;; ;; Custom mode-line
(use-package powerline
  :init
  (use-package diminish
    :config
    (progn
      (eval-after-load "undo-tree" '(diminish 'undo-tree-mode))
      (eval-after-load "simple" '(diminish 'auto-fill-function))
      (eval-after-load "eldoc" '(diminish 'eldoc-mode))
      (eval-after-load "guide-key" '(diminish 'guide-key-mode))
      (eval-after-load "highlight-parentheses" '(diminish 'highlight-parentheses-mode))
      (eval-after-load "elisp-slime-nav" '(diminish 'elisp-slime-nav-mode " sln"))
      (eval-after-load "projectile" '(diminish 'projectile-mode " prj"))
      (eval-after-load "paredit" '(diminish 'paredit-mode " par"))
      (eval-after-load "company" '(diminish 'company-mode " cmp"))
      (eval-after-load "cider" '(diminish 'cider-mode " cid"))
      (eval-after-load "typed-clojure-mode" '(diminish 'typed-clojure-mode " typ"))
      (eval-after-load "org-indent" '(diminish 'org-indent-mode))
      (eval-after-load "evil-org" '(diminish 'evil-org-mode))
      (eval-after-load "evil-cleverparens" '(diminish 'evil-cleverparens-mode))
      (eval-after-load "autorevert" '(diminish 'auto-revert-mode))))
  :config
  (progn
     (powerline-vim-theme)))

(use-package helm
  :init (global-set-key (kbd "M-x") 'helm-M-x))

(use-package yasnippet
  :init
  (progn
    (yas-global-mode 1)
    (use-package clojure-snippets))
  :config
  (progn
    (evil-leader/set-key "ys" 'yas-insert-snippet)))

(use-package company
  :init (add-hook 'after-init-hook 'global-company-mode)
  :config
  (progn
    (defun indent-or-complete ()
      (interactive)
      (if (looking-at "\\_>")
          (company-complete-common)
        (indent-according-to-mode)))
    (global-set-key "\t" 'indent-or-complete)))

(use-package clojure-cheatsheet)

(use-package better-defaults)

(use-package projectile
  :init (projectile-global-mode)
  :config
  (progn
    (setq projectile-completion-system 'helm)
    (helm-projectile-on)
    (evil-leader/set-key "pf" 'projectile-find-file)
    (evil-leader/set-key "pg" 'projectile-grep)
    (evil-leader/set-key "pk" 'projectile-kill-buffers)
    (evil-leader/set-key "pt" 'projectile-regenerate-tags)))

;; Ativa evil-mode
(use-package evil
  :init
  (progn
    (evil-mode 1)
    (evil-leader/set-key "es" 'toggle-eshell-buffer)

    (use-package evil-org
      :init (add-hook 'org-mode-hook 'evil-org-mode))
    (use-package evil-leader
      :init (add-hook 'after-init-hook 'global-evil-leader-mode)
      :config
      (progn
        (evil-leader/set-leader "\\")))
    (use-package evil-magit
      :config
      (progn
        (evil-leader/set-key "gs" 'magit-status)))
    (use-package evil-cleverparens
      :init (add-hook 'paredit-mode-hook 'evil-cleverparens-mode))
    (use-package evil-surround
      :init (add-hook 'after-init-hook 'global-evil-surround-mode))
    (use-package evil-commentary
      :init
      (evil-leader/set-key "cc" 'evilnc-comment-or-uncomment-lines))))

(use-package org)

(use-package markdown-mode
  :mode (("\\.markdown$" . markdown-mode)
         ("\\.md$" . markdown-mode)))

(use-package ido
  :config
  (progn
    (evil-leader/set-key "bs" 'ido-switch-buffer)
    (evil-leader/set-key "bk" 'ido-kill-buffer)
    (evil-leader/set-key "ff" 'ido-find-file)))

(use-package ido-vertical-mode
  :init (ido-vertical-mode 1))

(use-package fancy-narrow
  :config
  (evil-leader/set-key
    "nr" 'fancy-narrow-to-region
    "np" 'fancy-narrow-to-page
    "nf" 'fancy-narrow-to-defun
    "nw" 'fancy-widen))

(use-package paredit
  :init
  (progn
    (add-hook 'emacs-lisp-mode-hook 'paredit-mode)
    (add-hook 'clojure-mode-hook 'paredit-mode)
    (add-hook 'clojurescript-mode-hook 'paredit-mode)
    (add-hook 'clojurec-mode-hook 'paredit-mode)))

(use-package clojure-mode
  :mode (("\\.edn$" . clojure-mode))
  :config
  (progn
    (defun toggle-nrepl-buffer ()
      "Toggle the nREPL REPL on and off"
      (interactive)
      (if (string-match "cider-repl" (buffer-name (current-buffer)))
          (delete-window)
        (cider-switch-to-repl-buffer)))

    (defun cider-save-and-refresh ()
      (interactive)
      (save-buffer)
      (call-interactively 'cider-refresh))

    (evil-leader/set-key "eb" 'cider-eval-buffer)
    (evil-leader/set-key "ee" 'cider-eval-last-sexp)
    (evil-leader/set-key "er" 'cider-eval-region)
    (evil-leader/set-key "ef" 'cider-eval-defun-at-point)

    (evil-leader/set-key "cd" 'cider-doc)
    (evil-leader/set-key "cf" 'cider-find-dwim)
    (evil-leader/set-key "cC" 'cider-connect)
    (evil-leader/set-key "cj" 'cider-jack-in)
    (evil-leader/set-key "cJ" 'cider-jack-in-clojurescript)
    (evil-leader/set-key "ci" 'cider-interrupt)
    (evil-leader/set-key "ct" 'cider-test-run-ns-tests)
    (evil-leader/set-key "cT" 'cider-test-run-project-tests)
    (evil-leader/set-key "ca" 'cider-macroexpand-all)
    (evil-leader/set-key "cm" 'cider-macroexpand-1)
    (evil-leader/set-key "cn" 'cider-repl-set-ns)
    (evil-leader/set-key "cr" 'toggle-nrepl-buffer)
    (evil-leader/set-key "cs" 'cider-save-and-refresh)))

(use-package cider
  :init
  (progn
    (add-hook 'cider-repl-mode-hook 'subword-mode))
  :config
  (progn
    (setq nrepl-hide-special-buffers t)
    (setq cider-popup-stacktraces-in-repl t)
    (setq cider-repl-history-file "~/.emacs.d/nrepl-history")
    (setq cider-repl-pop-to-buffer-on-connect nil)
    (setq cider-repl-use-clojure-font-lock nil)
    (setq cider-auto-select-error-buffer nil)
    (setq cider-prompt-save-file-on-load nil)
    (setq cider-repl-display-help-banner nil)))

(use-package typed-clojure-mode
  :init
  (add-hook 'clojure-mode-hook 'typed-clojure-mode)
  :config
  (progn
    (evil-leader/set-key "tc" 'typed-clojure-check-ns)))

(use-package clj-refactor
  :init
  (add-hook 'clojure-mode-hook (lambda () (clj-refactor-mode 1)))
  :config
  (progn
    (evil-leader/set-key "rai" 'cljr-add-import-to-ns)
    (evil-leader/set-key "rar" 'cljr-add-require-to-ns)
    (evil-leader/set-key "rau" 'cljr-add-use-to-ns)
    (evil-leader/set-key "rrr" 'cljr-remove-unused-requires)
    (evil-leader/set-key "rsn" 'cljr-sort-ns)
    (evil-leader/set-key "rtf" 'cljr-thread-first-all)
    (evil-leader/set-key "rtl" 'cljr-thread-last-all)
    (evil-leader/set-key "rcc" 'cljr-cycle-coll)
    (evil-leader/set-key "rcp" 'cljr-cycle-privacy)
    (evil-leader/set-key "rcs" 'clojure-toggle-keyword-string)
    (evil-leader/set-key "rfe" 'cljr-create-fn-from-example)))

(use-package spotify
  :config
  (progn
    (evil-leader/set-key "sp" 'spotify-previous)
    (evil-leader/set-key "sn" 'spotify-next)
    (evil-leader/set-key "ss" 'spotify-playpause)
    (evil-leader/set-key "sc" 'spotify-current)))

(use-package elpy
  :init
  (elpy-enable)
  :config
  (progn
    (evil-leader/set-key "yd" 'elpy-doc)
    (evil-leader/set-key "yr" 'elpy-shell-switch-to-shell)
    (evil-leader/set-key "yf" 'elpy-goto-definition)
    (evil-leader/set-key "ye" 'elpy-shell-send-region-or-buffer)))

(provide 'init)
;;; init.el ends here

