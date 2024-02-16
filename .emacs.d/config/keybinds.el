(global-unset-key "\C-l")
(defvar ctl-l-map (make-keymap)
     "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map "\C-l" 'Control-L-prefix)
(fset 'Control-L-prefix ctl-l-map)

(define-key ctl-l-map (kbd "s s") 'c-switch-statement)
(define-key ctl-l-map (kbd "s i") 'c-if-statement)
(define-key ctl-l-map (kbd "s f e") 'csharp-foreach-loop)
(define-key ctl-l-map (kbd "s n") 'skeleton-next-position)
(define-key ctl-l-map (kbd "u a") 'n/arrayify)
(define-key ctl-l-map (kbd "u g") 'n/generate-guid)

(global-set-key (kbd "C-`") 'n/push-mark-no-activate)
