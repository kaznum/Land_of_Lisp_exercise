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
(defun lazy-mapcar (fun lst)
  (lazy (unless (lazy-null lst)
	  (cons (funcall fun (lazy-car lst))
		(lazy-mapcar fun (lazy-cdr lst))))))

(defun lazy-mapcan (fun lst)
  (labels ((f (lst-cur)
	     (if (lazy-null lst-cur)
		 (force (lazy-mapcan fun (lazy-cdr lst)))
		 (cons (lazy-car lst-cur) (lazy (f (lazy-cdr lst-cur)))))))
    (lazy (unless (lazy-null lst)
	    (f (funcall fun (lazy-car lst)))))))


(defun add1 (x)
  (mapcar (lambda (y) (1+ y)) x))
(mapcan 'add1  '((1 2 3) (4 5 6)))

(defun lazy-find-if (fun lst)
  (unless (lazy-null lst)
    (let ((x (lazy-car lst)))
      (if (funcall fun x)
	  x
	  (lazy-find-if fun (lazy-cdr lst))))))

(defun lazy-nth (n lst)
  (if (zerop n)
      (lazy-car lst)
      (lazy-nth (1- n) (lazy-cdr lst))))

(take 10 (lazy-mapcar #'sqrt *integers*))

(take 10 (lazy-mapcan (lambda (x)
			(if (evenp x)
			    (make-lazy (list x))
			    (lazy-nil)))
		      *integers*))

(lazy-find-if #'oddp (make-lazy '(2 4 6 7 8 10)))

(lazy-nth 4 (make-lazy '(a b c d e f g)))

