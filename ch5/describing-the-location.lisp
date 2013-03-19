;; Given in the previous section
(defparameter *nodes* '((living-room (you are in the living-room.
				     a wizard is snoring loudly on the couch.))
		       (garden (you are in a beautiful garden.
				there is a well in front of you.))
		       (attic (you are in the attic.
			       there is a giant welding torch in the corner.))))

;; assoc
(assoc 'garden *nodes*)

(defun describe-location (location nodes)
  (cadr (assoc location nodes)))

;; TEST
(describe-location 'living-room *nodes*)
