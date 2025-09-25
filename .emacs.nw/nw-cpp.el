(require 'clang-format)
(defun nw/clang-format ()
  "Call clang-format if there is an existing .clang-format file in the project"
  (when (locate-dominating-file "." ".clang-format")
	(clang-format-buffer)))

(defun nw/find-parent-directory (dir should-contain)
  "Find the directory that contains a particular file or directory name"
  (if (string= dir "/")
	  nil
	(progn
	  (message (concat "Searching " dir))
	  (if (member should-contain (directory-files dir))
		  dir
		(nw/find-parent-directory (file-name-directory (directory-file-name dir)) should-contain)))))

(defun nw/find-root-git ()
  "From the current default-directory, find the project's root
directory that has a .git folder"
  (interactive)
  (message (concat "Searching for .git root starting at " default-directory))
  (nw/find-parent-directory default-directory ".git"))

(defun nw/has-compile-commands ()
  (let ((root (nw/find-root-git)))
	(when root
	  (directory-files-recursively (nw/find-root-git) "compile_commands.json"))))

(define-minor-mode nw/c-mode
  "Buffer-local mode to enable/disable automated clang format on save"
  :lighter " NW/C-Mode"
  (if nw/c-mode
	  (progn
		(add-hook 'before-save-hook 'nw/clang-format nil t)
		(if (nw/has-compile-commands)
			(progn
			  (message "Starting eglot server...")
			  (eglot-ensure))
		  (message "No compile_commands.json found. Eglot server not started for C++ project")))
	(remove-hook 'before-save-hook 'nw/clang-format t)))

;; Create a globalized minor mode to
;;   - Auto enable the above mode only for C/C++
;;   - Be able to turn it off globally if needed
(define-globalized-minor-mode nw/c-mode-auto-enable nw/c-mode
  (lambda()(nw/c-mode t))
  :predicate '(c-mode c++-mode c-or-c++-mode))

(nw/c-mode-auto-enable)
(defun nw/c-common-hook ()
  (c-set-offset 'substatement-open 0)
  (c-set-offset 'case-label 0)
  (c-set-offset 'statement-case-open 0)
  (c-set-offset 'arglist-cont-nonempty '+)
  (setq c++-tab-always-indent t
	   c-basic-offset 4
	   c-indent-level 4
	   tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60)
	   tab-width 4
	   indent-tabs-mode nil))
(add-hook 'c-mode-common-hook 'nw/c-common-hook)
