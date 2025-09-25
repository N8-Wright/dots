(require 'projectile)
(setq
 ;; This makes projectile indexing work well on Windows
 projectile-indexing-method 'alien

 ;; This is the only way that I've found to get projectile grepping
 ;; working in Windows
 projectile-use-git-grep t
)
