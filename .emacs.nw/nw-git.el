(require 'magit)

;; Only automatically refresh the current Magit buffer, but not the
;; status buffer. If you do that, then the status buffer is only
;; refreshed automatically if it is the current buffer.
(setq magit-refresh-status-buffer nil)

;; Increase diff performance by turning some features off.
(setq magit-diff-highlight-indentation nil
	  magit-diff-highlight-trailing nil
	  magit-diff-paint-whitespace nil
	  magit-diff-highlight-hunk-body nil
	  magit-diff-refine-hunk nil)

(setq magit-revision-insert-related-refs nil)
