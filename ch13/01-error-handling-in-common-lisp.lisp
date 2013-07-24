;; Signaling a Condition
(error "foo")

;; Creating Custom Conditions
(define-condition foo () ()
  (:report (lambda (condition stream)
	     (princ "Stop FOOing around, numbskull!" stream))))

(error 'foo)

;; Intercepting Conditions

;; to be continued

