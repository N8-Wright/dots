;; Set the preferred font
(set-frame-font "SF Mono 16" nil t)

;; Turn off modes that are not needed
(setq inhibit-startup-message t)
(scroll-bar-mode -1)
(menu-bar-mode -1)
(tool-bar-mode -1)
(set-fringe-mode 20) ;; Set some margins

;; Stop creating ~ files
(setq make-backup-files nil)

;; Move customization variables to a separate file and load it
(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)

;; Revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; Revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)

;; Disable line numbers for some modes
(dolist (mode '(org-mode-hook
                term-mode-hook
                eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; Package initialization
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 40))

(use-package doom-themes)
(load-theme 'doom-plain t nil)

(use-package magit)

(when (eq system-type 'darwin)
  ;; On macos we can hook into the native dark/light mode system settings
  ;; Found: https://www.reddit.com/r/emacs/comments/ym9jw3/autodarkemacs_an_automatic_theme_changer_for/
  ;; Required: railwaycat's emacs -> https://github.com/railwaycat/homebrew-emacsmacport
  (defun njw/appearance-change-hook ()
    (let ((appearance (plist-get (mac-application-state) :appearance)))
      (cond ((equal appearance "NSAppearanceNameAqua")
             (load-theme 'doom-plain t nil))
            ((equal appearance "NSAppearanceNameDarkAqua")
             (load-theme 'doom-plain-dark t nil)))))
  
  (add-hook 'after-init-hook 'njw/appearance-change-hook)
  (add-hook 'mac-effective-appearance-change-hook 'njw/appearance-change-hook))

