(loop for i
     below 5
     sum i)

;; Some loop Tricks
(loop for i
     from 5
     to 10
     sum i)
(loop for i
     in '(100 20 3)
     sum i)

(loop for i
     below 5
     do (print i))

(loop for i
     below 10
     when (oddp i)
     sum i)

(loop for i
     from 0
     do (print i)
     when (= i 5)
     return 'falafel)

(loop for i
     in '(2 3 4 5 6)
     collect (* i i))

(loop for x below 10
     for y below 10
     collect (+ x y))

(loop for x below 10
     collect (loop for y below 10
		  collect (+ x y)))

(loop for i
     from 0
     for day
     in '(monday tuesday wednesday thursday friday saturday sunday)
     collect (cons i day))

