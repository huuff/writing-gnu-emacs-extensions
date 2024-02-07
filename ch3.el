(defvar unscroll-point (make-marker)
  "Text position for the next call to 'unscroll'.")

(defvar unscroll-window-start (make-marker)
  "Window start for next call to 'unscroll'.")

(defvar unscroll-hscroll nil
  "Hscroll for next call to 'unscroll'.")


(put 'scroll-up 'unscrollable t)
(put 'scroll-down 'unscrollable t)
(put 'scroll-left 'unscrollable t)
(put 'scroll-right 'unscrollable t)

(defun unscroll (args)
  "Jump to location specified by 'unscroll-point'."
  (interactive)
  (if (not unscroll-point)
    (error "Cannot unscroll yet")
    (progn
	(goto-char unscroll-point)
	(set-window-start nil unscroll-window-start)
	(set-window-hscroll nil unscroll-hscroll))))


(defun unscroll-maybe-remember (args)
  (if (not (get last-command 'unscrollable))
      (progn
	(set-marker unscroll-point (point))
	(set-marker unscroll-window-start (window-start))
	(setq unscroll-hscroll (window-hscroll)))))

(advice-add 'scroll-up :before 'unscroll-maybe-remember)
(advice-add 'scroll-down :before 'unscroll-maybe-remember)
(advice-add 'scroll-left :before 'unscroll-maybe-remember)
(advice-add 'scroll-right :before 'unscroll-maybe-remember)

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
