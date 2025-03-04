# This script will symlink all important emacs configuration files to
# the default location that emacs expects in Windows
# (C:\Users\<UserName>\AppData\Roaming)
New-Item -path ~\AppData\Roaming\.emacs -itemType SymbolicLink -target .emacs
New-Item -path ~\AppData\Roaming\.emacs.nw -itemType SymbolicLink -target .emacs.nw
New-Item -path ~\AppData\Roaming\.emacs-custom.el -itemType SymbolicLink -target .emacs-custom.el
