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

;; to be continued
