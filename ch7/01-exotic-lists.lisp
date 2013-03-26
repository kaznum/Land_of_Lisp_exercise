(cons 1 (cons 2 (cons 3 nil)))

;; Dotted lists

(cons 1 (cons 2 3))

'(1 . (2 . (3 . nil)))

;; Pairs

(cons 2 3)

;; Circular Lists

(setf *print-circle* t)

(defparameter foo '(1 2 3))
(setf (cdddr foo) foo)
;; (1 2 3 . #1#)

;; Association Lists
(defparameter *drink-order* '((bill . double-espresso)
			      (lisa . small-drip-coffee)
			      (john . medium-latte)))

(assoc 'lisa *drink-order*)

(push '(lisa . large-mocha-with-whipped-cream) *drink-order*)

(assoc 'lisa *drink-order*)

