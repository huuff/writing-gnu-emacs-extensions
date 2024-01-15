(defvar unscroll-point nil
  "Text position for the next call to 'unscroll'.")

(defvar unscroll-window-start nil
  "Window start for next call to 'unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")

;; TODO: Use modern advices instead

(defun unscroll ()
  "Jump to location specified by 'unscroll-point'."
  (interactive)
  (if (not unscroll-point)
    (error "Cannot unscroll yet")
    (progn
	(goto-char unscroll-point)
	(set-window-start nil unscroll-window-start)
	(set-window-hscroll nil unscroll-hscroll))))


(defun unscroll-maybe-remember ()
  (setq this-command 'unscrollable)
  (if (not (eq last-command 'unscrollable))
  (setq unscroll-point (point)
	unscroll-window-start (window-start)
	unscroll-hscrolll (window-hscroll))))

(defadvice scroll-up (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-down (before remember-for-unscroll
			       activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-left (before remember-for-unscroll
			     activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

(defadvice scroll-right (before remember-for-unscroll
				activate compile)
  "Remember where we started from, for 'unscroll'."
  (unscroll-maybe-remember))

;; APPENDING SOME TEXT TO TEST IT
asdasd

sadsa
dasdas
dsad

sdasdasdad
sdasdasdasdsa


asdasdasdasdasd
asdasdsa
ass
dsadasdasdasdasd
adasdasdsad


sdadasdasdadasdas
s
asdasdasd
asdasdasdsdad


asdasdasdasdsadsd

asdasdasdasdadasda
asdsa
asdads
dd
asdas
dsa
das
das
dasdsad
asdasd
asd
asd
asdasda
dasdas
da
