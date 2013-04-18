;; Working with Arrays
(make-array 3)
(defparameter x (make-array 3))
(aref x 1)
(aref x 5)
;; out of range
(setf (aref x 1) 'foo)
x

;; Using a Generic Generator
(setf foo '(a b c))
foo
(second foo)
(setf (second foo) 'z)
foo
(setf foo (make-array 4))
(setf (aref foo 2) '(x y z))
foo
(setf (car (aref foo 2)) (make-hash-table))
(setf (gethash 'zoink (car (aref foo 2))) 5)
foo

;; Arrays vs. Lists
