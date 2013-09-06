;;;;; From Previous Chapter
(defun pairs (lst)
  (labels ((f (lst acc)
             (split lst
                    (if tail
                        (f (cdr tail) (cons (cons head (car tail)) acc))
                        (reverse acc))
                    (reverse acc))))
    (f lst nil)))


;;; This Chapter
;; Creating XML and HTML with the tag Macro

(defun print-tag (name alst closingp)
  (princ #\<)
  (when closingp
    (princ #\/))
  (princ (string-downcase name))
  (mapc (lambda (att)
	  (format t " ~a =\"~a\"" (string-downcase (car att)) (cdr att)))
	alst)
  (princ #\>))

(print-tag 'mytag '((color . blue) (height . 9)) nil)

;;; Creating the tag Macro
;; (tag mytag (color 'blue height (+ 4 5)))
;; -> <mytag color="BLUE" height="9"></mytag>

(defmacro tag (name atts &body body)
  `(progn (print-tag ',name
		     (list ,@(mapcar (lambda (x)
				       `(cons ',(car x) ,(cdr x)))
				     (pairs atts)))
		     nil)
	  ,@body
	  (print-tag ',name nil t)))

(macroexpand '(tag mytag (color 'blue height (+ 4 5))))

(tag mytag (color 'blue size 'big)
  (tag first_inner_tag ())
  (tag second_inner_tag ()))

;; <mytag color ="BLUE" size ="BIG">
;;   <first_inner_tag></first_inner_tag>
;;   <second_inner_tag></second_inner_tag>
;; </mytag>

;;; Using the tag Macro to Generate HTML

;; to be continued
