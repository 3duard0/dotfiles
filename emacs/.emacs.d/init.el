(require 'package)
(push '("marmalade" . "http://marmalade-repo.org/packages/")
      package-archives )
(push '("melpa" . "http://melpa.milkbox.net/packages/")
      package-archives)
(package-initialize)


(defvar my-packages '(clojure-mode
		      cider
		      ace-jump-mode
		      mustard-theme
		      magit
		      hackernews))

(dolist (p my-packages)
  (unless (package-installed-p p)
    (package-install p)))


(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

(require 'mustard-theme)
