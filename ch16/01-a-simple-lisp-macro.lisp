(defun add (a b)
  (let ((x (+ a b)))
    (format t "The sum is ~a" x)
    x))

(add 2 3)


(defmacro let1 (var val &body body)
  `(let ((,var ,val))
     ,@body))

(let ((foo (+ 2 3)))
  (* foo foo))

(let1 foo (+ 2 3)
  (* foo foo))

;; Macro Expansion
;;; no code

;; How Macros Are Transformed
(let1 foo (+ 2 3)
  (princ "Lisp is awesome!")
  (* foo foo))

;; Using the Simple Macro
(defun add (a b)
  (let1 x (+ a b)
    (format t "The sum is ~a" x)
    x))

(add 1 2)

(macroexpand '(let1 foo (+ 2 3)
	       (* foo foo)))


