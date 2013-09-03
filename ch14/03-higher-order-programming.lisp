(defparameter *my-list* '(4 7 2 3))

*my-list*

;; Code Composition with Imperative Code
(loop for n below (length *my-list*)
     do (setf (nth n *my-list*) (+ (nth n *my-list*) 2)))

*my-list*

;; Using the Functional Style
(defun add-two (list)
  (when list
    (cons (+ 2 (car list)) (add-two (cdr list)))))

(add-two '(4 7 2 3))

;; to be continued

