(defvar unscroll-to nil
  "Text position for the next call to 'unscroll'.")

(defvar unscroll-window-start nil
  "Window start for next call to 'unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")

(defadvice scroll-up (before remember-for-unscrioll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (if (not (eq last-command 'scroll-up))
      (progn
	(setq unscroll-to (point))
	(setq unscroll-window-start (window-start))
	(setq unscroll-hscroll (window-hscroll)))))

(defun unscroll ()
  "Jump to location specified by 'unscroll-to'."
  (interactive)
  (if not unscroll-point
    (error "Cannot unscroll yet")
    (progn
	(goto-char unscroll-to)
	(set-window-start nil unscroll-window-start)
	(set-window-hscroll nil unscroll-hscroll))))
