(require 'markdown-mode)
(add-hook 'markdown-mode-hook
          (lambda ()
            (setq markdown-fontify-code-blocks-natively t
                  markdown-hide-urls t)))
