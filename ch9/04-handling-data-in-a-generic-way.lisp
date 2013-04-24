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


;; to be continued

