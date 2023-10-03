(setq inhibit-startup-message t
      use-dialog-box nil
      global-auto-revert-non-file-buffers t
      make-backup-files nil)

(setq-default indent-tabs-mode nil)

(menu-bar-mode -1)
(tool-bar-mode -1)
(load-theme 'modus-operandi t)
(blink-cursor-mode -1)
(global-hl-line-mode 1)
(global-auto-revert-mode 1)
(fido-mode)

(set-language-environment 'utf-8)
(pcase system-type
  ('windows-nt
   (message "Using Windows configuration")
   (prefer-coding-system 'utf-8-with-signature-dos)
   (set-default-coding-systems 'utf-8-with-signature-dos)
   (set-selection-coding-system 'utf-8-with-signature-dos)
   (setq exec-path (append exec-path
                           '("C:\\Program Files\\Git\\usr\\bin"))
         find-program "C:\\Program Files\\Git\\usr\\bin\\find.exe"
         grep-program "C:\\Program Files\\Git\\usr\\bin\\grep.exe"))
  (_
   (message "Using unix configuration")
   (prefer-coding-system 'utf-8-with-signature-unix)
   (set-default-coding-systems 'utf-8-with-signature-unix)
   (set-selection-coding-system 'utf-8-with-signature-unix)))

(defvar *skeleton-markers* nil
  "Markers for locations saved in skeleton-positions")

(add-hook 'skeleton-end-hook 'skeleton-make-markers)

(defun skeleton-make-markers ()
  (while *skeleton-markers*
    (set-marker (pop *skeleton-markers*) nil))
  (setq *skeleton-markers*
	(mapcar 'copy-marker (reverse skeleton-positions))))

(defun skeleton-next-position (&optional reverse)
  "Jump to next position in skeleton.
         REVERSE - Jump to previous position in skeleton"
  (interactive "P")
  (let* ((positions (mapcar 'marker-position *skeleton-markers*))
	 (positions (if reverse (reverse positions) positions))
	 (comp (if reverse '> '<))
	 pos)
    (when positions
      (if (catch 'break
	    (while (setq pos (pop positions))
	      (when (funcall comp (point) pos)
		(throw 'break t))))
	  (goto-char pos)
	(goto-char (marker-position
		    (car *skeleton-markers*)))))))

(define-skeleton csharp-foreach-loop
  "Insert a foreach loop"
  ""
  > "foreach (var "(skeleton-read "Var Name: ") " in " (skeleton-read "List Name: ") ")"  \n
  -4 "{" \n
  _ \n
  -4 "}")

(define-skeleton c-if-statement
  "Insert an if statement"
  > "if (" _ ")" \n
  -4 "{" \n
  @ _ \n
    -4 "}")

(define-skeleton c-switch-statement
  "Insert a switch statement"
  > "switch (" _ ")" \n
  -4 "{" \n
  @ _ \n
    "default:" \n
    "break;" \n
    -8 "}")


(defvar ctl-c-a-map (make-keymap)
  "Keymap for local bindings and functions, prefixed by (^L)")
(define-key global-map (kbd "C-c a") 'Control-ca-prefix)
(fset 'Control-ca-prefix ctl-c-a-map)
(define-key ctl-c-a-map (kbd "s s") 'c-switch-statement)
(define-key ctl-c-a-map (kbd "s i") 'c-if-statement)
(define-key ctl-c-a-map (kbd "s f e") 'csharp-foreach-loop)
(define-key ctl-c-a-map (kbd "s n") 'skeleton-next-position)







