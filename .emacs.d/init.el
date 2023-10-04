;; Load the configuration
(dolist (dir (list "lisp" "config" user-login-name))
  (let ((config-dir (expand-file-name dir user-emacs-directory)))
    (when (file-exists-p config-dir)
      (add-to-list 'load-path config-dir)
      (mapc 'load (directory-files config-dir nil "^[^#].*el$")))))

;; Don't save stuff into init.el
(setq custom-file (expand-file-name "emacs-custom.el" user-emacs-directory))
(when (file-exists-p custom-file) (load custom-file))
