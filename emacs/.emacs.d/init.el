(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(package-initialize)

;; Plugins para instalar
(defvar my-packages '(
		      ;;clojure
		      clojure-mode
		      cider
		      ;;acejump
		      ace-jump-mode
		      ;;temas
		      mustard-theme
		      ;;git
		      magit
		      ;;Mostra os atalhos de comandos
		      helm
		      ;;hackernews
		      hackernews))
;; Instala o que não tiver sido instalado
(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))

;; Ativa ace-jump
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c C-SPC") 'ace-jump-mode)

;; Ativar o tema
(require 'mustard-theme)

(require 'helm)

(custom-set-variables
 ;; Desativa toolbar
 '(tool-bar-mode nil nil (tool-bar)))

(custom-set-faces)

(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
