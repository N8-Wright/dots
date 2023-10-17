(use-package pinentry
  :config
  (pinentry-start)
  (setq epg-pinentry-mode 'loopback)
  (setq epa-pinentry-mode 'loopback)
  (fset 'epg-wait-for-status 'ignore))

(use-package org-roam
  :config
  (setq org-roam-directory (file-truename "~/Library/Mobile Documents/com~apple~CloudDocs/Documents/10-19 Writing/13 Notes"))
  (setq org-roam-node-display-template "${title} ${tags}"))
