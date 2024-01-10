(defvar unscroll-to nil
  "Text position for the next call to 'unscroll'.")

(defadvice scroll-up (before remember-for-unscrioll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (if (not (eq last-command 'scroll-up))
      (setq unscroll-to (point))))

(defun unscroll ()
  "Jump to location specified by 'unscroll-to'."
  (interactive)
  (goto-char unscroll-to))
