(defun my-length (lst)
  (labels ((f (lst acc)
	     (if lst
		 (f (cdr lst) (1+ acc))
		 acc)))
    (f lst 0)))

;; A Macro for Splitting Lists

;;; the followings don't work because 'split' macro has not been defined yet
(split '(2 3)
       (format t "This can be split into ~a and ~a." head tail)
       (format t "This cannot be split."))
;;;; This can be split into 2 and (3)
(split '()
       (format t "This can be split into ~a and ~a." head tail)
       (format t "This cannot be split."))
;;;; This cannot be split.

;;;; The following macro contains bugs
(defmacro split (val yes no)
  `(if ,val
       (let ((head (car ,val))
	     (tail (cdr ,val)))
	 ,yes)
       ,no))

(defun my-length (lst)
  (label ((f (lst acc)
	     (split lst
		    (f tail (1+ acc))
		    acc)))
	 (f lst 0)))

(split (progn (princ "Lisp rocks!")
	      '(2 3))
       (format t "This can be split into ~a and ~a." head tail)
       (format t "This cannot be split."))

(macroexpand '(split (progn (princ "Lisp rocks!")
			    '(2 3))
	       (format t "This can be split into ~a and ~a." head tail)
	       (format t "This cannot be split.")))

;;;; still it has bugs
(defmacro split (val yes no)
  `(let1 x ,val
     (if x
	 (let ((head (car x))
	       (tail (cdr x)))
	   ,yes)
	 ,no)))

(split (progn (princ "Lisp rocks!")
	      '(2 3))
       (format t "This can be split into ~a and ~a." head tail)
       (format t "This cannot be split."))

;; Avoiding Variable Caputure
(let1 x 100
  (split '(2 3)
	 (+ x head)
	 nil))

(macroexpand '(split '(2 3)
	       (+ x head)
	       nil))

(gensym)

(defmacro split (val yes no)
  (let1 g (gensym)
    `(let1 ,g ,val
       (if ,g
	   (let ((head (car ,g))
		 (tail (cdr ,g)))
	     ,yes)
	   ,no))))

(macroexpand '(split '(2 3)
	       (+ x head)
	       nil))

;; A Recursion Macro
(defun my-length (lst)
  (labels ((f (lst acc)
	     (split lst
		    (f tail (1+ acc))
		    acc)))
    (f lst 0)))

;; 'recurse' has not been defined
(recurse (n 9)
	 (fresh-line)
	 (if (zerop n)
	     (princ "lift-off!")
	     (progn (princ n)
		    (self (1- n)))))

(defun pairs (lst)
  (labels ((f (lst acc)
	     (split lst
		    (if tail
			(f (cdr tail) (cons (cons head (car tail)) acc))
			(reverse acc))
		    (reverse acc))))
    (f lst nil)))

(pairs '(a b c d e f))
(pairs '(a b c d e f g)) ;; g is ignored

(defmacro recurse (vars &body body)
  (let1 p (pairs vars)
    `(labels ((self ,(mapcar #'car p)
		,@body))
       (self ,@(mapcar #'cdr p)))))


(defun my-length (lst)
  (recurse (lst lst acc 0)
	   (split lst
		  (self tail (1+ acc))
		  acc)))

(my-length '(1 2 3 4 5))

(macroexpand
 '(recurse (lst lst acc 0)
   (split lst
    (self tail (1+ acc))
    acc)))
;;(LABELS ((SELF (LST ACC)
;;	   (SPLIT LST
;;		  (SELF TAIL (1+ ACC))
;;		  ACC)))
;;  (SELF LST 0))
