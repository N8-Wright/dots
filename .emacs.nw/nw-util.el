;; From https://manueluberti.eu/posts/2025-09-21-date-at-point/
(defun nw/date-at-point (date)
  "Insert current DATE at point via `completing-read'."
  (interactive
   (let* ((formats '("%Y%m%d" "%F" "%Y%m%d%H%M" "%Y-%m-%dT%T"))
          (vals (mapcar #'format-time-string formats))
          (opts
           (lambda (string pred action)
             (if (eq action 'metadata)
                 '(metadata (display-sort-function . identity))
               (complete-with-action action vals string pred)))))
     (list (completing-read "Insert date: " opts nil t))))
  (insert date))

;; From http://xahlee.info/emacs/emacs/elisp_generate_uuid.html
(defun nw/insert-random-uuid ()
  (interactive)
  (cond
   ((eq system-type 'windows-nt)
    (shell-command "pwsh.exe -Command [guid]::NewGuid().toString()" t))
   ((eq system-type 'darwin) ; Mac
    (shell-command "uuidgen" t))
   ((eq system-type 'gnu/linux)
    (shell-command "uuidgen" t))
   (t
    ;; code here by Christopher Wellons, 2011-11-18.
    ;; and editted Hideki Saito further to generate all valid variants for "N" in xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx format.
    (let ((xstr (md5 (format "%s%s%s%s%s%s%s%s%s%s"
                              (user-uid)
                              (emacs-pid)
                              (system-name)
                              (user-full-name)
                              (current-time)
                              (emacs-uptime)
                              (garbage-collect)
                              (buffer-string)
                              (random)
                              (recent-keys)))))
      (insert (format "%s-%s-4%s-%s%s-%s"
                      (substring xstr 0 8)
                      (substring xstr 8 12)
                      (substring xstr 13 16)
                      (format "%x" (+ 8 (random 4)))
                      (substring xstr 17 20)
                      (substring xstr 20 32)))))))
