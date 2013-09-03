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

;; to be continued

