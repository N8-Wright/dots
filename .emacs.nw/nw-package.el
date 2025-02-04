(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

(defvar nw/package-contents-refreshed
  nil
  "Indicates wether the package archives have been refreshed this session")
(defun nw/package-contents-refresh-once ()
  (when (not nw/package-contents-refreshed)
	(package-initialize)
    (setq nw/package-contents-refreshed t)
    (package-refresh-contents)))

(defun nw/require-package (package)
  "Installs a package after ensuring that the package contents archive is up-to-date"
  (when (not (package-installed-p package))
    (nw/package-contents-refresh-once)
    (package-install package)))

(defun nw/require-packages (&rest packages)
  (dolist (package packages)
    (nw/require-package package)))
