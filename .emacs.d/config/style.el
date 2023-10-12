(setq inhibit-startup-message t
      use-dialog-box nil
      global-auto-revert-non-file-buffers t
      make-backup-files nil)

(setq-default indent-tabs-mode nil)
(dolist (mode '(tool-bar-mode scroll-bar-mode menu-bar-mode))
  (when (fboundp mode) (funcall mode -1)))

(use-package doom-themes)
(load-theme 'doom-material-dark t)
(blink-cursor-mode -1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
