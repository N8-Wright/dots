(use-package editorconfig
  :init
  (editorconfig-mode))

(use-package ws-butler
  :hook
  (prog-mode . #'ws-butler-mode))
