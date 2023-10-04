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
