(defparameter *fruit* 'apple)

(cond ((eq *fruit* 'apple) 'its-an-apple)
      ((eq *fruit* 'orange) 'its-an-orange))

(equal 'apple 'apple)
(equal (list 1 2 3) (list 1 2 3))

;; This need nil which is not in the textbook
(equal '(1 2 3) (cons 1 (cons 2 (cons 3 nil))))

(equal 5 5)
(equal 2.5 2.5)
(equal "foo" "foo")
(equal #\a #\a)

(eql 'foo 'foo)
(eql 3.4 3.4)
(eql #\a #\a)

;; the following returns NIL
(eql "foo" "foo")


(equalp "Bob Smith" "bob smith")
(equalp 0 0.0)

;; The following is NIL
(equalp 0 "0")

