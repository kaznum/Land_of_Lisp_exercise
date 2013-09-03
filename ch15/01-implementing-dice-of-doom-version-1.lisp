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

;; to be continued

