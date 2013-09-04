;;;;; From previsou sections ;;;;;

;; Defining Some Global Variables
(defparameter *num-players* 2)
(defparameter *max-dice* 3)
(defparameter *board-size* 3)
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

;; functional
(defun player-letter (n)
  (code-char (+ 97 n)))

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

;; Attacking
;; functional
(defun board-attack (board player src dst dice)
  (board-array (loop for pos
		    for hex across board
		    collect (cond ((eq pos src) (list player 1))
				  ((eq pos dst) (list player (1- dice)))
				  (t hex)))))

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

;;; Turning Minimax into Actual Code
;;;; functional
(defun rate-position (tree player)
  (let ((moves (caddr tree)))
    (if moves
	(apply (if (eq (car tree) player)
		   #'max
		   #'min)
	       (get-ratings tree player))
	(let ((w (winners (cadr tree))))
	  (if (member player w)
	      (/ 1 (length w))
	      0)))))

;;;; functional
(defun get-ratings (tree player)
  (mapcar (lambda (move)
	    (rate-position (cadr move) player))
	  (caddr tree)))

;;; Creatting a Game Loop with an AI Player
;;;; functional
(defun handle-computer (tree)
  (let ((ratings (get-ratings tree (car tree))))
    (cadr (nth (position (apply #'max ratings) ratings) (caddr tree)))))

;;;; Imperative
(defun play-vs-computer (tree)
  (print-info tree)
  (cond ((null (caddr tree)) (announce-winner (cadr tree)))
	((zerop (car tree)) (play-vs-computer (handle-human tree)))
	(t (play-vs-computer (handle-computer tree)))))

;;;;;; This section ;;;;;;

;; Closures
(defparameter *foo* (lambda () 5))
(funcall *foo*)
;;; 5
(defparameter *foo* (let ((x 5)) (lambda () x)))
(funcall *foo*)
;;; 5

(let ((line-number 0))
  (defun my-print (x)
    (print line-number)
    (print x)
    (incf line-number)
    nil))

(my-print "this")
(my-print "is")
(my-print "a")
(my-print "test")

;; Memoization
;;; Memoizing the neighbors Function
(neighbors 0)

(let ((old-neighbors (symbol-function 'neighbors))
      (previous (make-hash-table)))
  (defun neighbors (pos)
    (or (gethash pos previous)
	(setf (gethash pos previous) (funcall old-neighbors pos)))))

;; Memoizing the Game Tree


;; to be continued

