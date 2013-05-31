(prin1 "foo")
(princ "foo")

(format t "I am printing ~s in the middle of this sentence." "foo")
(format t "I am printing ~a in the middle of this sentence." "foo")

(format t "I am printing ~10a in the middle of this sentence." "foo")
(format t "I am printing ~10@a in the middle of this sentence." "foo")
(format t "I am printing ~10,3a in the middle of this sentence." "foo")
(format t "I am printing ~,,4a in the middle of this sentence." "foo")

(format t "I am printing ~,,4,'!a in the middle of this sentence." "foo")
(format t "I am printing ~,,4,'!@a in the middle of this sentence." "foo")








