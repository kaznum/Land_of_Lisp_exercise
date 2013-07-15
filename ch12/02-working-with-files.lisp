(with-open-file (my-stream "data.txt" :direction :output)
  (print "my data" my-stream))

(with-open-file (my-stream "data.txt" :direction :input)
  (read my-stream))

(let ((animal-noises '((dog . woof)
		       (cat . meow))))
  (with-open-file (my-stream "animal-noises.txt" :direction :output)
    (print animal-noises my-stream)))

(with-open-file (my-stream "animal-noises.txt" :direction :input)
    (read my-stream))


(with-open-file (my-stream "data.txt" :direction :output :if-exists :error)
  (print "my data" my-stream))

(with-open-file (my-stream "data.txt" :direction :output :if-exists :supersede)
  (print "my data" my-stream))

