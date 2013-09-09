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
(defmacro lazy-cons (a d)
  `(lazy (cons ,a ,d)))

(defun lazy-car (x)
  (car (force x)))

(defun lazy-cdr (x)
  (cdr (force x)))

(defparameter *foo* (lazy-cons 4 7))

(lazy-car *foo*)
(lazy-cdr *foo*)

(defparameter *integers*
  (labels ((f (n)
	     (lazy-cons n (f (1+ n)))))
    (f 1)))

(lazy-car *integers*)
(lazy-car (lazy-cdr *integers*))
(lazy-car (lazy-cdr (lazy-cdr *integers*)))

(defun lazy-nil ()
  (lazy nil))

(defun lazy-null (x)
  (not (force x)))

;; Converting Between Regular Lists and Lazy Lists
(defun make-lazy (lst)
  (lazy (when lst
	  (cons (car lst) (make-lazy (cdr lst))))))

(defun take (n lst)
  (unless (or (zerop n) (lazy-null lst))
    (cons (lazy-car lst) (take (1- n) (lazy-cdr lst)))))

(defun take-all (lst)
  (unless (lazy-null lst)
    (cons (lazy-car lst) (take-all (lazy-cdr lst)))))

(take 10 *integers*)
(take 10 (make-lazy '(q w e r t y u i o p a s d f)))
(take-all (make-lazy '(q w e r t y u i o p a s d f)))

;; Mapping and Searching Across Lazy Lists

;; to be continued
