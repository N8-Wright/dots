;; ------------------------------------------------------------------------- ;;
;;			     Basic Setup                                     ;;
;; ------------------------------------------------------------------------- ;;

;; Change the place where custom-variables is set so it doesn't pollute
;; the bottom of this file.
(setq custom-file "~/.emacs.d/custom_set_variables.el")
(setq epa-pinentry-mode 'loopback)
(add-hook 'before-save-hook #'delete-trailing-whitespace)
;; Don't litter backup files everywhere
(setq backup-directory-alist `(("." . "~/.saves")))
(setq gc-cons-threshold 24000000)
(setq read-process-output-max (* 1024 1024)) ;; Increase to 1mb for lsp

;; ------------------------------------------------------------------------- ;;
;;		          Package Initialization                             ;;
;; ------------------------------------------------------------------------- ;;
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Set up use package to automatically install packages that are requested
;; later in this document
(require 'use-package)
(require 'use-package-ensure)
(setq use-package-always-ensure t)

;; Auto update packages and delete older versions
(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; ------------------------------------------------------------------------- ;;
;;			         Style                                       ;;
;; ------------------------------------------------------------------------- ;;
(set-frame-font "Cascadia Code 12")
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(use-package doom-themes
  :config
  (load-theme 'doom-xcode t))

;; ------------------------------------------------------------------------- ;;
;;			    Source Control                                   ;;
;; ------------------------------------------------------------------------- ;;
(use-package magit)

;; ------------------------------------------------------------------------- ;;
;;			       Utility                                       ;;
;; ------------------------------------------------------------------------- ;;
(use-package which-key
  :config
  (which-key-mode))

(defmacro with-system (type &rest body)
  "Evaluate BODY if `system-type' equals TYPE."
  (declare (indent defun))
  `(when (eq system-type ',type)
     ,@body))

;; ------------------------------------------------------------------------- ;;
;;			     Programming                                     ;;
;; ------------------------------------------------------------------------- ;;
(use-package csharp-mode) ;; TODO: remove in emacs 29
(use-package editorconfig
  :config
  (editorconfig-mode +1))
(use-package projectile
  :config
  (projectile-mode +1))
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (c++-mode .lsp)
  (c-mode . lsp)
  (csharp-mode . lsp)
  (lsp-mode .lsp-enable-which-key-integration)
  :commands
  lsp)

;; lsp-mode will detect and auto configure the use of these packages
(use-package lsp-ui
  :commands
  (lsp-ui-mode))
(use-package company)

;; ------------------------------------------------------------------------- ;;
;;				C/C++                                        ;;
;; ------------------------------------------------------------------------- ;;
(defun nathan/c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  ;; other customizations can go here

  (setq c++-tab-always-indent t)
  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  (setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))
  (setq tab-width 4)
  (setq indent-tabs-mode t)  ; use spaces only if nil
  )

(add-hook 'c-mode-common-hook #'nathan/c-mode-common-hook)

;; ------------------------------------------------------------------------- ;;
;;				 Code                                        ;;
;; ------------------------------------------------------------------------- ;;
(use-package s)
(defun n/to-snake-case (start end)
  "Change selected text to snake_case format"
  (interactive "r")
  (if (use-region-p)
      (let ((camel-case-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-snake-case camel-case-str)))
    (message "No region selected")))

(defun n/to-camel-case (start end)
  "Change selected text to camelCase format"
  (interactive "r")
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-lower-camel-case selected-str)))
    (message "No region selected")))

(defun n/to-private-variable (start end)
  (interactive "r")
  (n/to-camel-case start end)
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert "_")
        (insert selected-str)))
    (message "No region selected"))

(defun n/to-pascal-case (start end)
  "Change selected text to PascalCase format"
  (interactive "r")
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-upper-camel-case selected-str)))
    (message "No region selected")))


;; ------------------------------------------------------------------------- ;;
;;			       Homepath                                      ;;
;; ------------------------------------------------------------------------- ;;
(with-system windows-nt
	     (setq nathan/homepath
		   (file-name-as-directory (file-truename (getenv "HOMEPATH")))))

(with-system gnu/linux
	     (setq nathan/homepath (file-truename "~/")))

(with-system darwin
	     (setq mac-option-modifier 'meta)
	     (setq nathan/homepath (file-truename "~/")))

;; ------------------------------------------------------------------------- ;;
;;			      Minibuffer                                     ;;
;; ------------------------------------------------------------------------- ;;
(use-package counsel)
(use-package ivy
  :bind
  (("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("C-h f" . counsel-describe-function)
   ("\C-s" . swiper))
  :config
  (ivy-mode))

;; ------------------------------------------------------------------------- ;;
;;				Editor                                       ;;
;; ------------------------------------------------------------------------- ;;
(use-package expand-region)
(use-package multiple-cursors)

;; ------------------------------------------------------------------------- ;;
;;			     Keybindings                                     ;;
;; ------------------------------------------------------------------------- ;;
(unbind-key "C-z")
(bind-key (kbd "C-z f s") #'n/to-snake-case)
(bind-key (kbd "C-z f c") #'n/to-camel-case)
(bind-key (kbd "C-z f p") #'n/to-pascal-case)
(bind-key (kbd "C-z f _") #'n/to-private-variable)
(bind-key (kbd "C-z i g") #'n/generate-guid)

(bind-key (kbd "C-=") #'er/expand-region)
(bind-key (kbd "C--") #'er/contract-region)

(bind-key (kbd "C->") #'mc/mark-next-like-this)
(bind-key (kbd "C-<") #'mc/mark-previous-like-this)
(bind-key (kbd "C-c C-<") #'mc/mark-all-like-this)

(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
