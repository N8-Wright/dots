(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               `(csharp-mode . ("omnisharp" "-lsp"))))
