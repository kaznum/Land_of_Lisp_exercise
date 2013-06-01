(defun random-animal ()
  (nth (random 5) '("dog" "tick" "tiger" "walrus" "kangaroo")))

(random-animal)

(loop repeat 10
   do (format t "~5t~a ~15t~a ~25t~a~%"
	      (random-animal)
	      (random-animal)
	      (random-animal)))

(loop repeat 10
   do (format t "~30<~a~;~a~;~a~>~%"
	      (random-animal)
	      (random-animal)
	      (random-animal)))

(loop repeat 10
   do (format t "~30:@<~a~>~%"
	      (random-animal)))

(loop repeat 10
   do (format t "~30:@<~a~;~a~;~a~>~%"
	      (random-animal)
	      (random-animal)
	      (random-animal)))

(loop repeat 10
   do (format t "~10:@<~a~>~10:@<~a~>~10:@<~a~>~%"
	      (random-animal)
	      (random-animal)
	      (random-animal)))

