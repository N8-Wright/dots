(set-language-environment 'utf-8)
(pcase system-type
  ('windows-nt
   (message "Using Windows configuration")
   (set-frame-font "Cascadia Code 12" nil t)
   (prefer-coding-system 'utf-8-with-signature-dos)
   (set-default-coding-systems 'utf-8-with-signature-dos)
   (set-selection-coding-system 'utf-8-with-signature-dos)

   ;; I fully expect that git is installed on a dev system so
   ;; we are going to take advantage of the unix tools that
   ;; come along with it!
   (setq exec-path (append exec-path
                           '("C:\\Program Files\\Git\\usr\\bin"))
         find-program "C:\\Program Files\\Git\\usr\\bin\\find.exe"
         grep-program "C:\\Program Files\\Git\\usr\\bin\\grep.exe"))
  (_
   (message "Using unix configuration")
   (set-frame-font "SF Mono 12" nil t)
   (prefer-coding-system 'utf-8-with-signature-unix)
   (set-default-coding-systems 'utf-8-with-signature-unix)
   (set-selection-coding-system 'utf-8-with-signature-unix)))
