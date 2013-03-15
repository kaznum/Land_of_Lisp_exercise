(defun guess-my-number ()
  (ash (+ *small* *big*) -1))

(ash 11 1)
(ash 11 -1)
(guess-my-number)

(defun return-five ()
  (+ 2 3))
(return-five)

(defun smaller ()
  (setf *big* (1- (guess-my-number)))
  (guess-my-number))

(defun bigger ()
  (setf *small* (1+ (guess-my-number)))
  (guess-my-number))

(defun start-over ()
  (defparameter *small* 1)
  (defparameter *big* 100)
  (guess-my-number))

;; TEST  (83)
(start-over)
(bigger)
(bigger)
(smaller)
(bigger)
(smaller)
(bigger)




