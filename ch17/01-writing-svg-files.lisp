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
(tag html ()
  (tag body ()
    (princ "Hello World!")))

(defmacro html (&body body)
  `(tag html ()
     ,@body))
(defmacro body (&body body)
  `(tag body ()
     ,@body))

(html
  (body
    (princ "Hello World!")))

;; Creating SVG-Specific Macros and Functions
(defmacro svg (&body body)
  `(tag svg (xmlns "http://www.w3.org/2000/svg"
		   "xmlns:xlink" "http://www.w3.org/1999/xlink")
     ,@body))

(defun brightness (col amt)
  (mapcar (lambda (x)
	    (min 255 (max 0 (+ x amt))))
	  col))

(brightness '(255 0 0) -100)

(defun svg-style (color)
  (format nil
	  "~{fill:rgb(~a,~a,~a);stroke:rgb(~a,~a,~a)~}"
	  (append color
		  (brightness color -100))))


(defun circle (center radius color)
  (tag circle (cx (car center)
		  cy (cdr center)
		  r radius
		  style (svg-style color))))


(svg (circle '(50 . 50) 50 '(255 0 0))
     (circle '(100 . 100) 50 '(0 0 255)))

;; Building a More Complicated SVG Excample
(defun polygon (points color)
  (tag polygon (points (format nil
			       "~{~a,~a ~}"
			       (mapcan (lambda (tp)
					 (list (car tp) (cdr tp)))
				       points))
		       style (svg-style color))))

(mapcan (lambda (tp)
	  (list (car tp) (cdr tp)))
	'((1 . 2) (3 . 4) (5 . 6)))

(mapcar (lambda (tp)
	  (list (car tp) (cdr tp)))
	'((1 . 2) (3 . 4) (5 . 6)))

(defun random-walk (value length)
  (unless (zerop length)
    (cons value
	  (random-walk (if (zerop (random 2))
			   (1- value)
			   (1+ value))
		       (1- length)))))

(random-walk 1 5)
(random-walk 100 10)

(with-open-file (*standard-output* "random_walk.svg"
				   :direction :output
				   :if-exists :supersede)
  (svg (loop repeat 10
	  do (polygon (append '((0 . 200))
			      (loop for x
				 for y in (random-walk 100 400)
				 collect (cons x y))
			      '((400 . 200)))
		      (loop repeat 3
			 collect (random 256))))))

;; how to perform 'loop for x'
(loop for x
     for y in '(100 200 300 400)
     collect (cons x y))
