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
(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook
  (c++-mode .lsp)
  (c-mode . lsp)
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
