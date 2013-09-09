(load "dice_of_doom_v1.lisp")
(load "lazy.lisp")
(load "02-dice-of-doom-version-2")

;; Trimming the Game Tree
(defun limit-tree-depth (tree depth)
  (list (car tree)
	(cadr tree)
	(if (zerop depth)
	    (lazy-nil)
	    (lazy-mapcar (lambda (move)
			   (list (car move)
				 (limit-tree-depth (cadr move) (1- depth))))
			 (caddr tree)))))


(defparameter *ai-level* 4)

(defun handle-computer (tree)
  (let ((ratings (get-ratings (limit-tree-depth tree *ai-level*)
			      (car tree))))
    (cadr (lazy-nth (position (apply #'max ratings) ratings)
		    (caddr tree)))))

(defun play-vs-computer (tree)
  (print-info tree)
  (cond ((lazy-null (caddr tree)) (announce-winner (cadr tree)))
	((zerop (car tree)) (play-vs-computer (handle-human tree)))
	(t (play-vs-computer (handle-computer tree)))))

;; Applying Heuristics
;;; no code

;; Winning by a Lots vs. Winning by a Little
(defun score-board (board player)
  (loop for hex across board
       for pos from 0
       sum (if (eq (car hex) player)
	       (if (threatened pos board)
		   1
		   2)
	       -1)))

(defun threatened (pos board)
  (let* ((hex (aref board pos))
	 (player (car hex))
	 (dice (cadr hex)))
    (loop for n in (neighbors pos)
	 do (let* ((nhex (aref board n))
		   (nplayer (car nhex))
		   (ndice (cadr nhex)))
	      (when (and (not (eq player nplayer)) (> ndice dice))
		(return t))))))

(defun get-ratings (tree player)
  (take-all (lazy-mapcar (lambda (move)
			   (rate-position (cadr move) player))
			 (caddr tree))))

(defun rate-position (tree player)
  (let ((moves (caddr tree)))
    (if (not (lazy-null moves))
	(apply (if (eq (car tree) player)
		   #'max
		   #'min)
	       (get-ratings tree player))
	(score-board (cadr tree) player))))

;; Alpha Beta Pruning

;; to be continued
