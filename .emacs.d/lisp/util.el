(defun n/arrayify (start end quote)
  "Turn strings on newlines into a QUOTEd, comma-separated one-liner."
  (interactive "r\nMQuote: ")
  (let ((insertion
         (mapconcat
          (lambda (x) (format "%s%s%s" quote x quote))
          (split-string (buffer-substring start end)) ", ")))
    (delete-region start end)
    (insert insertion)))


(defun n/generate-guid ()
  "Use some system native method of generating a guid"
  (interactive)
  (pcase system-type
    ('windows-nt
     (shell-command "powershell.exe -Command [guid]::NewGuid().toString()" t))
    (_
     (shell-command "uuidgen" t))))

;; https://www.masteringemacs.org/article/fixing-mark-commands-transient-mark-mode
(defun n/push-mark-no-activate ()
  "Pushes `point' to `mark-ring' and does not activate the region
   Equivalent to \\[set-mark-command] when \\[transient-mark-mode] is disabled"
  (interactive)
  (push-mark (point) t nil)
  (message "Pushed mark to ring"))
