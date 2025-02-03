(require 'yasnippet)
(setq yas-snippet-dirs
      '("~/.emacs.nw/snippets"
        ))
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

