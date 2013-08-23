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
(decode-param "foo+bar")

;; Decoding Lists of Request Parameters

;; intern converts a string to a symbol
(defun parse-params (s)
  (let* ((i1 (position #\= s))
	 (i2 (position #\& s)))
    (cond (i1 (cons (cons (intern (string-upcase (subseq s 0 i1)))
			  (decode-param (subseq s (1+ i1) i2)))
		    (and i2 (parse-params (subseq s (1+ i2))))))
	  ((equal s "") nil)
	  (t s))))

(parse-params "name=bob&age=25&gender=male")
(parse-params "name=bob&age=25&gender=ma%3Fle")

;; Parsing the Request Header

;; Example: "GET /hello.html HTTP/1.1"
(defun parse-url (s)
  (let* ((url (subseq s
		      (+ 2 (position #\space s))
		      (position #\space s :from-end t)))
	 (x (position #\? url)))
    (if x
	(cons (subseq url 0 x) (parse-params (subseq url (1+ x))))
	(cons url '()))))

(parse-url "GET /lolcats.html HTTP/1.1")
(parse-url "GET /lolcats.html?extract-funny=yes HTTP/1.1")



;; to be continued
