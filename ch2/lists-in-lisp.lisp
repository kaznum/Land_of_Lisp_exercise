(expt 2 3)

;; Cons Cells
'(1 2 3)

;; List Functions
(cons 'chicken 'cat)  ;; This is not a list just linking those two items together

(cons 'chicken 'nil)
;; (CHECKEN)

(cons 'chicken nil)
;; (CHECKEN)

(cons 'chicken ())
;; (CHECKEN)
(cons 'chicken '())
;; (CHECKEN)

(cons 'pork '(beef checken))

;; They are all same
(eq 1 '1)
;; T
(eq '() ())
;; T

(cons 'beef (cons 'checken ()))

(cons 'pork (cons 'beef (cons 'checken ())))

;; the car and cdr functions

(car '(pork beef chicken))

(cdr '(pork beef chicken))

(cdr '(pork beef chicken))
(car '(beef chicken))
(car (cdr '(pork beef chicken)))
(cadr '(pork beef chicken))
(caddr '(pork beef chicken))

;; The list function

(list 'pork 'beef 'chicken)

;; Nested Lists
'(cat (duck bat) ant)

(car '((peas carrots tomatoes) (pork beef chicken)))
(cdr '(peas carrots tomatoes))
(cdr (car '((peas carrots tomatoes) (pork beef chicken))))
(cdar'((peas carrots tomatoes) (pork beef chicken)))

(cons (cons 'peas (cons 'carrots (cons 'tomatoes ())))
      (cons (cons 'pork (cons 'beef (cons 'chicken ())))
	    ()))

;; to be continued

