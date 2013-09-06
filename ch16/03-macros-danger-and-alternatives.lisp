(defun my-length (lst)
  (reduce (lambda (x i)
	    (1+ x))
	  lst
	  :initial-value 0))


(my-length '(a b c d e))
