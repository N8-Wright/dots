(defmacro with-system (type &rest body)
  "Evaluate BODY if `system-type' equals TYPE."
  (declare (indent defun))
  `(when (eq system-type ',type)
     ,@body))

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
		vterm-mode-hook
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

(with-system darwin
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

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1))

(use-package swiper)
(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :demand
  :config
  (ivy-mode 1))

;; This requires that you have libtool installed and are able to compile
;; C code with cmake.
;; See: https://github.com/akermu/emacs-libvterm
(use-package vterm)

(use-package projectile
  :config (projectile-mode)
  :bind-keymap
  ("C-c p" . projectile-command-map))

(defun njw/c-mode-common-hook ()
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

(add-hook 'c-mode-common-hook #'njw/c-mode-common-hook)

(use-package s)
(defun njw/to-snake-case (start end)
  "Change selected text to snake_case format"
  (interactive "r")
  (if (use-region-p)
      (let ((camel-case-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-snake-case camel-case-str)))
    (message "No region selected")))

(defun njw/to-camel-case (start end)
  "Change selected text to camelCase format"
  (interactive "r")
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-lower-camel-case selected-str)))
    (message "No region selected")))

(defun njw/to-private-variable (start end)
  (interactive "r")
  (njw/to-camel-case start end)
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert "_")
        (insert selected-str)))
    (message "No region selected"))

(defun njw/to-pascal-case (start end)
  "Change selected text to PascalCase format"
  (interactive "r")
  (if (use-region-p)
      (let ((selected-str (buffer-substring start end)))
        (delete-region start end)
        (insert (s-upper-camel-case selected-str)))
    (message "No region selected")))

(with-system windows-nt
  (defun njw/generate-guid ()
    (interactive)
    (shell-command "powershell.exe -Command [guid]::NewGuid().toString()" t)))

(with-system darwin
  (defun njw/generate-guid ()
    (interactive)
    (shell-command "uuidgen" t)))

(with-system gnu/linux
  (defun njw/generate-guid ()
    (interactive)
    (shell-command "uuidgen" t)))

(defun arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda (x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)) ", ")))
    (delete-region start end)
    (insert insertion)))

(unbind-key "C-z")
(bind-key (kbd "C-z f s") #'njw/to-snake-case)
(bind-key (kbd "C-z f c") #'njw/to-camel-case)
(bind-key (kbd "C-z f p") #'njw/to-pascal-case)
(bind-key (kbd "C-z f _") #'njw/to-private-variable)
(bind-key (kbd "C-z i g") #'njw/generate-guid)

