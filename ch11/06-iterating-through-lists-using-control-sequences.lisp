;; given in the previous section
(defun random-animal ()
  (nth (random 5) '("dog" "tick" "tiger" "walrus" "kangaroo")))

(defparameter *animals* (loop repeat 10 collect (random-animal)))

*animals*

(format t "~{I see a ~a! ~}" *animals*)

(format t "~{I see a ~a... or was it ~a?~%~}" *animals*)

