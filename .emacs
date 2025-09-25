(setq custom-file "~/.emacs-custom.el")
(add-to-list 'load-path "~/.emacs.nw")
(load "nw-package.el")
(nw/require-packages
 'ivy
 'multiple-cursors
 'which-key
 'clang-format
 'company
 'yasnippet
 'yaml-mode
 'projectile
 'markdown-mode
 'powershell
 'highlight-indent-guides
 'protobuf-mode
 )

(load "protobuf-mode.el")
(require 'protobuf-mode)

(load "nw-cpp.el")
(load "nw-java.el")
(load "nw-edit.el")
(load "nw-util.el")
(load "nw-snippets.el")
(load "nw-git.el")
(load "nw-dired.el")
(load "nw-project.el")
(load "nw-prog.el")

(ivy-mode)
(which-key-mode)
(editorconfig-mode)

(unbind-key (kbd "C-z"))
(unbind-key (kbd "C-]"))
(keymap-global-set "C-." 'mc/mark-next-like-this)
(keymap-global-set "C-," 'mc/mark-previous-like-this)
(keymap-global-set "C-;" 'mc/mark-all-like-this)
(keymap-global-set "C-]" 'nw/duplicate-line)
(keymap-global-set "C-z u" 'nw/insert-random-uuid)
(keymap-global-set "C-z c" 'flyspell-auto-correct-previous-word)
(keymap-global-set "C-c p" 'projectile-command-map)
(keymap-global-set "C-q" 'company-yasnippet)
(keymap-global-set "C-z g" 'vc-git-grep)

(load custom-file)

(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
