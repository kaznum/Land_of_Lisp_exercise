(defparameter *edges* '((living-room (garden west door)
			 (attic upstairs ladder))
			(garden (living-room east door))
			(attic (living-room downstairs ladder))))


(defun describe-path (edge)
  `(there is a ,(caddr edge) going ,(cadr edge) from here.))

(describe-path '(garden west door))

;; Describing Multiple Paths at Once
(defun describe-paths (location edges)
  (apply #'append (mapcar #'describe-path (cdr (assoc location edges)))))

(describe-paths 'living-room *edges*)

(cdr (assoc 'living-room *edges*))

(mapcar #'describe-path (cdr (assoc 'living-room *edges*)))

(mapcar #'sqrt '(1 2 3 4 5))


;; To be continued

