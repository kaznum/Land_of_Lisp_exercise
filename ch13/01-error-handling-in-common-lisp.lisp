;; Signaling a Condition
(error "foo")

;; Creating Custom Conditions
(define-condition foo () ()
  (:report (lambda (condition stream)
	     (princ "Stop FOOing around, numbskull!" stream))))

(error 'foo)

;; Intercepting Conditions
(defun bad-function ()
  (error 'foo))

(handler-case (bad-function)
  (foo () "somebody signaled foo!")
  (bar () "somebody signaled bar!"))

;; Protecting Resources Against Unexpected Conditions
(unwind-protect (/ 1 0)
  (princ "I need to say 'flubyduby' matter what"))

