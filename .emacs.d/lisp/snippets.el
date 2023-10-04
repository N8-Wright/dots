(define-skeleton csharp-foreach-loop
  "Insert a foreach loop"
  ""
  > "foreach (var "
  (skeleton-read "Var Name: ")
  " in "
  (skeleton-read "List Name: ") ")"  \n
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
