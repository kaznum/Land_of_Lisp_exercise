;; How a Web Server Works
;; (no code)
;; Request Parameters
(defun http-char (c1 c2 &optional (default #\Space))
  (let ((code (parse-integer
	       (coerce (list c1 c2) 'string)
	       :radix 16
	       :junk-allowed t)))
    (if code
	(code-char code)
	default)))

(defun decode-param (s)
  (labels ((f (lst)
	     (when lst
	       (case (car lst)
		 (#\% (cons (http-char (cadr lst) (caddr lst))
			    (f (cdddr lst))))
		 (#\+ (cons #\space (f (cdr lst))))
		 (otherwise (cons (car lst) (f (cdr lst))))))))
    (coerce (f (coerce s 'list)) 'string)))

(decode-param "foo")
(decode-param "foo%3F")

;; to be continued
