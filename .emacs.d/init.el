;; Load the configuration
(let ((user-config-file (expand-file-name (concat user-login-name ".el") user-emacs-directory)))
  (dolist (dir (list "lisp" "config" user-login-name))
    (let ((config-dir (expand-file-name dir user-emacs-directory)))
      (when (file-exists-p config-dir)
        (add-to-list 'load-path config-dir)
        (mapc 'load (directory-files config-dir nil "^[^#].*el$")))))
  (when (file-exists-p user-config-file)
    (message (concat "Loading " user-config-file))
    (load user-config-file)))

(setq inhibit-startup-message t
      use-dialog-box nil
      global-auto-revert-non-file-buffers t
      make-backup-files nil)

(setq-default indent-tabs-mode nil)
(dolist (mode '(tool-bar-mode scroll-bar-mode menu-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(load-theme 'modus-operandi t)
(blink-cursor-mode -1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(fido-mode)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(set-language-environment 'utf-8)
(pcase system-type
  ('windows-nt
   (message "Using Windows configuration")
   (set-frame-font "Cascadia Code 12" nil t)
   (prefer-coding-system 'utf-8-with-signature-dos)
   (set-default-coding-systems 'utf-8-with-signature-dos)
   (set-selection-coding-system 'utf-8-with-signature-dos)

   ;; I fully expect that git is installed on a dev system so
   ;; we are going to take advantage of the unix tools that
   ;; come along with it!
   (setq exec-path (append exec-path
                           '("C:\\Program Files\\Git\\usr\\bin"))
         find-program "C:\\Program Files\\Git\\usr\\bin\\find.exe"
         grep-program "C:\\Program Files\\Git\\usr\\bin\\grep.exe"))
  (_
   (message "Using unix configuration")
   (set-frame-font "SF Mono 12" nil t)
   (prefer-coding-system 'utf-8-with-signature-unix)
   (set-default-coding-systems 'utf-8-with-signature-unix)
   (set-selection-coding-system 'utf-8-with-signature-unix)))


(global-unset-key "\C-l")
(defvar ctl-l-map (make-keymap)
     "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map "\C-l" 'Control-L-prefix)
(fset 'Control-L-prefix ctl-l-map)

(define-key ctl-l-map (kbd "s s") 'c-switch-statement)
(define-key ctl-l-map (kbd "s i") 'c-if-statement)
(define-key ctl-l-map (kbd "s f e") 'csharp-foreach-loop)
(define-key ctl-l-map (kbd "s n") 'skeleton-next-position)

(defun njw/c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-cont-nonempty ' 2)
  ;; other customizations can go here

  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  (setq tab-width 4))

(add-hook 'c-mode-common-hook #'njw/c-mode-common-hook)
