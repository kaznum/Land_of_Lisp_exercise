(defparameter *my-list* '(4 7 2 3))

*my-list*

;; Code Composition with Imperative Code
(loop for n below (length *my-list*)
     do (setf (nth n *my-list*) (+ (nth n *my-list*) 2)))

*my-list*

;; Using the Functional Style

;; to be continued

