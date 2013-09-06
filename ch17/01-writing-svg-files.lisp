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

;; to be continued
