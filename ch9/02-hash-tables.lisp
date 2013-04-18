;; Working with Hash Tables
(make-hash-table)

(defparameter x (make-hash-table))
(gethash 'yup x)

(defparameter x (make-hash-table))
(setf (gethash 'yup x) '25)
(gethash 'yup x)

(defparameter *drink-order* (make-hash-table))
(setf (gethash 'bill *drink-order*) 'double-espresso)
(setf (gethash 'lisa *drink-order*) 'small-drip-coffee)
(setf (gethash 'john *drink-order*) 'medium-latte)

(gethash 'lisa *drink-order*)

;; Returning Multiple Values
(round 2.4)
(round 2.51)

(defun foo ()
  (values 3 7))
(foo)

(+ (foo) 5)

(multiple-value-bind (a b) (foo)
  (* a b))

;; Hash Tables Performance


