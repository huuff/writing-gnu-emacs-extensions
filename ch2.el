(defun other-window-backward (&optional n)
  "Select Nth previous window"
  (interactive "P")
  (other-window (- (prefix-numeric-value n)))
 )

(global-set-key "\C-x\C-p" 'other-window-backward)

(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

;; XXX: This only works if evil-mode is disabled
(defun scroll-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default)."
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n))
 )

(defun scroll-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default)"
  (interactive "P")
  (scroll-behind (prefix-numeric-value n))
 )

(global-set-key "\C-q" 'scroll-n-lines-behind)
(global-set-key "\C-z" 'scroll-n-lines-ahead)

;; C-q was bound to quoted-insert, so I rebind it
(global-set-key "\C-x\C-q" 'quoted-insert)
