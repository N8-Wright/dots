(defun nw/duplicate-line ()
  "Duplicate the current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
				(line (let ((s (thing-at-point 'line t)))
						(if s (string-remove-suffix "\n" s) ""))))
		(move-end-of-line 1)
		(newline)
		(insert line)
		(move-beginning-of-line 1)
		(forward-char column)))

(add-hook 'org-mode-hook 'flyspell-mode)
