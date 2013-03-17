(if '()
    'i-am-true
    'i-am-false)

(if '(1)
    'i-am-true
    'i-am-false)

(defun my-length (list)
  (if list
      (1+ (my-length (cdr list)))
      0))

(my-length '(list with four symbols))

(eq '() nil)
(eq '() ())
(eq '() 'nil)


