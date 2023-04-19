;; ------------------------------------------------------------------------- ;;
;;			     Basic Setup                                     ;;
;; ------------------------------------------------------------------------- ;;

;; Change the place where custom-variables is set so it doesn't pollute
;; the bottom of this file.
(setq custom-file "~/.emacs.d/custom_set_variables.el")
(setq epa-pinentry-mode 'loopback)

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





