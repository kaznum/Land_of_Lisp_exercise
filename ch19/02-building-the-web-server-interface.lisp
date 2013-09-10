(load "01-drawing-the-game-board-using-the-svg-format")

;; Writing Our Web Request Handler
(defparameter *cur-game-tree* nil)
(defparameter *from-tile* nil)

(defun dod-request-handler (path header params)
  (if (equal path "game.html")
      (progn (princ "<!doctype html>")
	     (tag center ()
	       (princ "Welcome to DICE OF DOOM!")
	       (tag br ())
	       (let ((chosen (assoc 'chosen params)))
		 (when (or (not *cur-game-tree*) (not chosen))
		   (setf chosen nil)
		   (web-initialize))
		 (cond ((lazy-null (caddr *cur-game-tree*))
			(web-announce-winner (cadr *cur-game-tree*)))
		       ((zerop (car *cur-game-tree*))
			(web-handle-human
			 (when chosen
			   (read-from-string (cdr chosen)))))
		       (t (web-handle-computer))))
	       (tag br ())
	       (draw-dod-page *cur-game-tree* *from-tile*)))
      (princ "Sorry... I don't know that page.")))

;; Limitations of Our Game Web Server

;; to be continued
