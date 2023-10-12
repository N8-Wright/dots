(require 'treesit)

(defun treesitter-lib-exists (lang)
  (let ((exists  nil)
        (dir (expand-file-name "tree-sitter" user-emacs-directory)))
    (when (file-exists-p dir)
        (dolist (tlib (directory-files dir))
          (if (string-match-p lang tlib) (setq exists t)))
      exists)))

(defun setup-treesitter ()
    (setq treesit-language-source-alist
            '((bash "https://github.com/tree-sitter/tree-sitter-bash")
              (tsx "https://github.com/tree-sitter/tree-sitter-typescript" "master" "tsx/src")
              (typescript "https://github.com/tree-sitter/tree-sitter-typescript" "master" "typescript/src")
              (javascript "https://github.com/tree-sitter/tree-sitter-javascript")))

    (mapc (lambda (lang)
            (let ((lang-str (prin1-to-string lang)))
              (message (concat "Trying to load lang: " lang-str))
              (if (not (treesitter-lib-exists lang-str))
                  (treesit-install-language-grammar lang)
                  (message (concat lang-str " is already compiled...")))))
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
