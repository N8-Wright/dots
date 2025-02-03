(setq custom-file "~/.emacs-custom.el")
(add-to-list 'load-path "~/.emacs.nw")
(load "nw-package.el")
(nw/require-packages
 'ivy
 'multiple-cursors
 'which-key
 'magit
 'clang-format
 'dap-mode
 'company
 'org-roam)

(load "nw-cpp.el")
(load "nw-java.el")
(load "nw-edit.el")
(load "nw-util.el")

(ivy-mode)
(which-key-mode)

(unbind-key (kbd "C-z"))
(unbind-key (kbd "C-]"))
(keymap-global-set "C-." 'mc/mark-next-like-this)
(keymap-global-set "C-," 'mc/mark-previous-like-this)
(keymap-global-set "C-;" 'mc/mark-all-like-this)
(keymap-global-set "C-]" 'nw/duplicate-line)
(keymap-global-set "C-z u" 'nw/insert-random-uuid)
(keymap-global-set "C-z c" 'flyspell-auto-correct-previous-word)

(load custom-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
