(require 'treesit)

(defun setup-treesitter ()
    (setq treesit-language-source-alist
            '((bash "https://github.com/tree-sitter/tree-sitter-bash")
              (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
              (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
              (javascript "https://github.com/tree-sitter/tree-sitter-javascript")))

    (mapc (lambda (lang)
            ;; (dolist (tlib (directory-files (expand-file-name "tree-sitter" user-emacs-directory)))
            ;;   (if (string-match-p (prin1-to-string 'lang) tlib)
            ;;       (message tlib)))
            (treesit-install-language-grammar lang))
          (mapcar #'car treesit-language-source-alist))


    ;; Add modes that don't have an equivalent in the default set
    (add-to-list 'auto-mode-alist
                 '("\\.ts\\'" . (lambda ()
                                  (typescript-ts-mode)))
                 '("\\.tsx\\'" . (lambda ()
                                   (typescript-ts-mode))))

    ;; Replace modes that already exist
    (add-to-list 'major-mode-remap-alist
                 '(javascript-mode . js-ts-mode)))

(if (treesit-available-p)
    (setup-treesitter)
  (message "Treesitter is not available"))
