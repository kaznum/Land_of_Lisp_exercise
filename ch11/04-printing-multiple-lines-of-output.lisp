(progn (princ 22)
       (terpri)
       (princ 33))

(progn (princ 22)
       (terpri)
       (terpri)
       (princ 33))

(progn (princ 22)
       (fresh-line)
       (princ 33))

(progn (princ 22)
       (fresh-line)
       (fresh-line)
       (princ 33))


(progn (format t "this is on one line ~%")
       (format t "~%this is on another line"))

(progn (format t "this is on one line ~&")
       (format t "~&this is on another line"))

(format t "this will print ~5%on two lines spread far apart")

