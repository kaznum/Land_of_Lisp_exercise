;; Working with Sequences

(length '(a b c))
(length "blub")
(length (make-array 5))

;; Sequence Functions for Searching
(find-if #'numberp '(a b 5 c))
(count #\s "mississippi")
(position #\4 "2dfa4dfas4f5")
(some #'numberp '(a b c 5 d))
(every #'numberp '(a b c 5 d))

;; Sequence Functions for Iterating Across a Sequence
(reduce #'+ '(3 4 6 5 2))

(reduce (lambda (best item)
	  (if (and (evenp item) (> item best))
	      item
	    best))
	'(7 4 6 5 2)
	:initial-value 0)

(reduce (lambda (best item)
	  (if (and (evenp item) (> item best))
	      item
	    best))
	'(7 4 6 5 2))

(defun sum (lst)
  (reduce #'+ lst))

(sum '(1 2 3))

(sum (make-array 5 :initial-contents '(1 2 3 4 5)))

(sum "hogehoge")

(map 'list
     (lambda (x)
       (if (eq x #\s)
	   #\S
	 x))
     "this is a string")

(map 'string
     (lambda (x)
       (if (eq x #\s)
	   #\S
	 x))
     "this is a string")

;; Two More Important Sequence Functions

;; to be continued

