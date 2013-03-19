(defparameter *edges '((living-room (garden west door)
			(attic upstairs ladder))
		       (garden (living-room east door))
		       (attic (living-room downstairs ladder))))


(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(describe-path '(garden west door))
