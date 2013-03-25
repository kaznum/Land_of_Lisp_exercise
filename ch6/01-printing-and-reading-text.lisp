;; Printing to the Screen
(print "foo")

(progn (print "this")
       (print "is")
       (print "a")
       (print "test"))

(progn (prin1 "this")
       (prin1 "is")
       (prin1 "a")
       (prin1 "test"))


;; Saying Hello to the User
(defun say-hello ()
  (print "Please type your name:")
  (let ((name (read)))
    (print "Nice to meet you, ")
    (print name)))
(say-hello)

;; Starting with print and read

;; To be continued

