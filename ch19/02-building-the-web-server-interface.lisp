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
;;; no code

;; Initializing a New Game

(defun web-initialize ()
  (setf *from-tile* nil)
  (setf *cur-game-tree* (game-tree (gen-board) 0 0 t)))

;; Announcing a Winner

(defun web-announce-winner (board)
  (fresh-line)
  (let ((w (winners board)))
    (if (> (length w) 1)
	(format t "The game is a tie between ~a" (mapcar #'player-letter w))
	(format t "The winner is ~a" (player-letter (car w)))))
  (tag a (href "game.html")
    (princ " play again")))

;; to be continued
