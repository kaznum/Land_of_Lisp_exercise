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
(defun add-five ()
  (print "please enter a number:")
  (let ((num (read)))
    (print "When I add five I get")
    (print (+ num 5))))

(add-five)

(print '3)
(print '3.4)
(print 3.4)
(print 'foo)
(print "foo")
(print '"foo")
(print '#\a)

(print '#\newline)
(print '#\tab)
(print '#\space)

(print '|even this is a legal Lisp symbol!|)

;; Reading and Printing Stuff the Way Humans Like It

(princ '3)
(princ '3.4)
(princ 3.4)
(princ 'foo)
(princ '"foo")
(princ "foo")
(princ '#\a)
(princ #\a)

(progn (princ "This sentence will be interrupted")
       (princ #\newline)
       (princ "by an annoying newline character."))


(defun say-hello ()
  (princ "Please type your name:")
  (let ((name (read-line)))
    (princ "Nice to meet you, ")
    (princ name)))

(say-hello)

