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

;; to be continued
