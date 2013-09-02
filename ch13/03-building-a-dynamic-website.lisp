(defun hello-request-handler (path header params)
  (if (equal path "greeting")
      (let ((name (assoc 'name params)))
	(if (not name)
	    (princ "<html><form>What is your name?<input name='name'/></form></html>")
	    (format t "<html>Nice to meet you, ~a!</html>" (cdr name))))
      (princ "Sorry... I don't know that page.")))

;; Testing the Request Handler
(hello-request-handler "lolcats" '() '())

(hello-request-handler "greeting" '() '())

(hello-request-handler "greeting" '() '((name . "Bob")))

;; Launching the Website

;; The followings should be in REPL
(load "02-writing-a-web-server-from-scratch")
(load "03-building-a-dynamic-website")
(serve #'hello-request-handler)
