(defvar unscroll-point nil
  "Text position for the next call to 'unscroll'.")

(defvar unscroll-window-start nil
  "Window start for next call to 'unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")

;; TODO: Use modern advices instead
(defadvice scroll-up (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (if (not (or (eq last-command 'scroll-up)
	       (eq last-command 'scroll-down)
	       (eq last-command 'scroll-left)
	       (eq last-command 'scroll-right)))
      (progn
	(setq unscroll-point (point))
	(setq unscroll-window-start (window-start))
	(setq unscroll-hscroll (window-hscroll)))))

(defadvice scroll-down (before remember-for-unscroll
			       activate compile)
  "Remember where we started from, for 'unscroll'."
  (if (not (or (eq last-command 'scroll-down)
	       (eq last-command 'scroll-up)
	       (eq last-command 'scroll-left)
	       (eq last-command 'scroll-right)))
	   (setq unscroll-point (point)
		 unscroll-window-start (window-start)
		 unscroll-hscroll (window-hscroll))))

(defadvice scroll-left (before remember-for-unscroll
			       activate compile)
  "Remember where we started from, for 'unscroll'"
  (if (not (or (eq last-command 'scroll-up)
	       (eq last-command 'scroll-down)
	       (eq last-command 'scroll-left)
	       (eq last-command 'scroll-right)
	       (setq unscroll-point (point)
		     unscroll-windowstart (window-start)
		     unscroll-hscroll (window-hscroll))))))

(defadvice scroll-right (before remember-for-unscroll
				activate compile)
  "Remember where we started from, for 'unscroll'"
  (if (not (or (eq last-command 'scroll-up)
	       (eq last-command 'scroll-down)
	       (eq last-command 'scroll-left)
	       (eq last-command 'scroll-right)))))

(defun unscroll ()
  "Jump to location specified by 'unscroll-point'."
  (interactive)
  (if not unscroll-point
    (error "Cannot unscroll yet")
    (progn
	(goto-char unscroll-point)
	(set-window-start nil unscroll-window-start)
	(set-window-hscroll nil unscroll-hscroll))))

;; just eval this if I want a clean slate (TODO: Does it work? check it)
(progn
  (advice-remove 'scroll-up 'remember-for-unscroll)
  (advice-remove 'scroll-down 'remember-for-unscroll)
  (advice-remove 'scroll-left 'remember-for-unscroll)
  (advice-remove 'scroll-right 'remember-for-unscroll)) 
