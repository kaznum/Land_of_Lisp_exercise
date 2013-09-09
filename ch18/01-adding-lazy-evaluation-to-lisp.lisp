;; Creating the lazy and force Commands

;;; The followings don't work right now
(lazy (+ 1 2))
;;; #<FUNCTION ...>
(force (lazy (+ 1 2)))
;;; 3

(defun add (a b)
  (princ "I am adding now")
  (+ a b))

;;; The followings don't work right now
(defparameter *foo* (lazy (add 1 2)))
(force *foo*)

(defmacro lazy (&body body)
  (let ((forced (gensym))
	(value (gensym)))
    `(let ((,forced nil)
	   (,value nil))
       (lambda ()
	 (unless ,forced
	   (setf ,value (progn ,@body))
	   (setf ,forced t))
	 ,value))))

(defun force (lazy-value)
  (funcall lazy-value))

;;; test
(defparameter *bar* (lazy (add 1 2)))
(force *bar*)
(force *bar*)

;; Creating a Lazy Lists Library

;; to be continued
