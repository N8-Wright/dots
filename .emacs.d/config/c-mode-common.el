(defun njw/c-mode-common-hook ()
  ;; my customizations for all of c-mode, c++-mode, objc-mode, java-mode
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'arglist-cont-nonempty ' 2)
  ;; other customizations can go here

  (setq c-basic-offset 4)                  ;; Default is 2
  (setq c-indent-level 4)                  ;; Default is 2

  (setq tab-width 4))

(add-hook 'c-mode-common-hook #'njw/c-mode-common-hook)
