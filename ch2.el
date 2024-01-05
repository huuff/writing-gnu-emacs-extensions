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

(defun point-to-top ()
  "Put point on top line of window"
  (interactive)
  (move-to-window-line 0)
 )


(global-set-key "\M-," 'point-to-top)
(global-set-key "\C-x," 'tags-loop-continue)

(defun point-to-bottom ()
  "Put point at the beginning of last visible line"
  (interactive)
  (move-to-window-line -1)
)

(global-set-key "\M-." 'point-to-bottom)


(defun line-to-top ()
  "Move the current line to top of window."
  (interactive)
  (recenter 0)
 )

(global-set-key "\M-!" 'line-to-top)

;; symbolic link stuff
(defun read-only-if-symlink ()
  (if (file-symlink-p buffer-file-name)
      (progn
	(setq buffer-read-only t)
	(message "File is a symlink")
      )
  )
)

(add-hook 'find-file-hook 'read-only-if-symlink)

;; lambda version
(add-hook 'find-file-hooks
	  '(lambda ()
	     (if (file-symlink-p buffer-file-name)
		 (progn
		   (setq buffer-read-only t)
		   (message "File is a symlink")
		 )
	      )
	   )
)

(defun visit-target-instead ()
  "Replace this buffer with a buffer visiting the link target"
  (interactive)
  (if buffer-file-name
      (let
	  ((target (file-symlink-p buffer-file-name)))
	(if target
	    (find-alternate-file target)
	    (error "Not visiting a symlink")
	 )
       )
       (error "Not visiting a file")
   )
 )

(defun clobber-symlink ()
  "Replace symlink with a copy of the file."
  (interactive)
  (if buffer-file-name
      (let
	  ((target (file-symlink-p buffer-file-name)))
	(if target
	    (if (yes-or-no-p (format "Replace %s with %s" buffer-file-name target))
		(progn
		  (delete-file buffer-file-name)
		  (write-file buffer-file-name)
		)
	     )
	  (error "Not visiting a symlink")
	)
      )
      (error "Not visiting a file")
   )
)

;; Advised buffer switching 
;; TODO: Try to do this with a hook?
(defadvice switch-to-buffer (before existing-buffer activate compile)
  "When interactive, switch to existing buffers only"
  (interactive
    (list read-buffer "Switch to buffer: " (other-buffer) (null current-prefix-arg))
  )
)
