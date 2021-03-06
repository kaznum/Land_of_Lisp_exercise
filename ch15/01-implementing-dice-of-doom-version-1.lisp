;; Defining Some Global Variables

(defparameter *num-players* 2)
(defparameter *max-dice* 3)
(defparameter *board-size* 2)
(defparameter *board-hexnum* (* *board-size* *board-size*))

;; Representing the Game Board

;; functional
(defun board-array (lst)
  (make-array *board-hexnum* :initial-contents lst))

;; imperative
(defun gen-board ()
  (board-array (loop for n below *board-hexnum*
		    collect (list (random *num-players*)
				  (1+ (random *max-dice*))))))

(gen-board)

;; functional
(defun player-letter (n)
  (code-char (+ 97 n)))

(player-letter 0)
(player-letter 1)
(player-letter 3)


;; Imperative
(defun draw-board (board)
  (loop for y below *board-size*
       do (progn (fresh-line)
		 (loop repeat (- *board-size* y)
		      do (princ "   "))
		 (loop for x below *board-size*
		      for hex = (aref board (+ x (* *board-size* y)))
		      do (format t "~a-~a "
				 (player-letter (first hex))
				 (second hex))))))


(draw-board #((0 3) (0 3) (1 3) (1 1)))

;; Decoupling dice of Doom's rules from the Rest of the Game
;;;; no code

;; Generating a Game Tree

;; functional
(defun game-tree (board player spare-dice first-move)
  (list player
	board
	(add-passing-move board
			  player
			  spare-dice
			  first-move
			  (attacking-moves board player spare-dice))))

;; Calculating Passing Moves

;; Functional

(defun add-passing-move (board player spare-dice first-move moves)
  (if first-move
      moves
      (cons (list nil
		  (game-tree (add-new-dice board player (1- spare-dice))
			     (mod (1+ player) *num-players*)
			     0
			     t))
	    moves)))

;; Calculating Attacking Moves

;; Functional
(defun attacking-moves (board cur-player spare-dice)
  (labels ((player (pos)
	     (car (aref board pos)))
	   (dice (pos)
	     (cadr (aref board pos))))
    (mapcan (lambda (src)
	      (when (eq (player src) cur-player)
		(mapcan (lambda (dst)
			  (when (and (not (eq (player dst) cur-player))
				     (> (dice src) (dice dst)))
			    (list
			     (list (list src dst)
				   (game-tree (board-attack board cur-player src dst (dice src))
					      cur-player
					      (+ spare-dice (dice dst))
					      nil)))))
			(neighbors src))))
	    (loop for n below *board-hexnum*
		 collect n))))

;; Finding the Neighbors
(defun neighbors (pos)
  (let ((up (- pos *board-size*))
	(down (+ pos *board-size*)))
    (loop for p in (append (list up down)
			   (unless (zerop (mod pos *board-size*))
			     (list (1- up) (1- pos)))
			   (unless (zerop (mod (1+ pos) *board-size*))
			     (list (1+ pos) (1+ down))))
       when (and (>= p 0) (< p *board-hexnum*))
	 collect p)))


(neighbors 0)
(neighbors 1)
(neighbors 2)
(neighbors 3)

;; Attacking

;; functional
(defun board-attack (board player src dst dice)
  (board-array (loop for pos
		    for hex across board
		    collect (cond ((eq pos src) (list player 1))
				  ((eq pos dst) (list player (1- dice)))
				  (t hex)))))

(board-attack #((0 3) (0 3) (1 3) (1 1)) 0 1 3 3)

;; Reinforcements

;;; functional
(defun add-new-dice (board player spare-dice)
  (labels ((f (lst n)
	     (cond ((null lst) nil)
		   ((zerop n) lst)
		   (t (let ((cur-player (caar lst))
			    (cur-dice (cadar lst)))
			(if (and (eq cur-player player) (< cur-dice *max-dice*))
			    (cons (list cur-player (1+ cur-dice))
				  (f (cdr lst) (1- n)))
			    (cons (car lst) (f (cdr lst) n))))))))
    (board-array (f (coerce board 'list) spare-dice))))

(add-new-dice #((0 1) (1 3) (0 2) (1 1)) 0 2)
(add-new-dice #((0 3) (1 3) (0 2) (1 1)) 0 2)

;; Trying Out our New game-tree Function
(game-tree #((0 1) (1 1) (0 2) (1 1)) 0 0 t)


;; Playing Dice of Doom Against Another Human

;;; The main loop
;;;; imperative
(defun play-vs-human (tree)
  (print-info tree)
  (if (caddr tree)
      (play-vs-human (handle-human tree))
      (announce-winner (cadr tree))))

;;; Giving Information About the State of the Game
;;;; imperative
(defun print-info (tree)
  (fresh-line)
  (format t "current player = ~a" (player-letter (car tree)))
  (draw-board (cadr tree)))

;;; Handling Input from Human Players
;;;; imperative
(defun handle-human (tree)
  (fresh-line)
  (princ "choose your move:")
  (let ((moves (caddr tree)))
    (loop for move in moves
	 for n from 1
	 do (let ((action (car move)))
	      (fresh-line)
	      (format t "~a.  " n)
	      (if action
		  (format t "~a -> ~a" (car action) (cadr action))
		  (princ "end turn"))))
    (fresh-line)
    (cadr (nth (1- (read)) moves))))

;;; Determining the Winner
;;;; functional
(defun winners (board)
  (let* ((tally (loop for hex across board
		     collect (car hex)))
	 (totals (mapcar (lambda (player)
			   (cons player (count player tally)))  ;; player->count pair
			 (remove-duplicates tally)))  ;; players list
	 (best (apply #'max (mapcar #'cdr totals))))
    (mapcar #'car
	    (remove-if (lambda (x)
			 (not (eq (cdr x) best)))
		       totals))))

;;;; imperative
(defun announce-winner (board)
  (fresh-line)
  (let ((w (winners board)))
    (if (> (length w) 1)
	(format t "The game is a tie between ~a" (mapcar #'player-letter w))
	(format t "The winner is ~a" (player-letter (car w))))))

;;; Trying Out the Human vs. Human Version of Dice of Doom
(play-vs-human (game-tree (gen-board) 0 0 t))

