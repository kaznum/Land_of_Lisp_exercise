(load "graph-util")
(defparameter *congestion-city-nodes* nil)
(defparameter *congestion-city-edges* nil)
(defparameter *visited-nodes* nil)

(defparameter *node-num* 30)
(defparameter *edge-num* 45)
(defparameter *worm-num* 3)
(defparameter *cop-odds* 15)

;; Generating Random Edges

(defun random-node ()
  (1+ (random *node-num*)))

(defun edge-pair (a b)
  (unless (eql a b)
    (list (cons a b) (cons b a))))

(defun make-edge-list ()
  (apply #'append (loop repeat *edge-num*
		       collect (edge-pair (random-node) (random-node)))))
(make-edge-list)

;; Looping with the loop Command

(loop repeat 10
     collect 1)

(loop for n from 1 to 10
     collect n)

(loop for n from 1 to 10
     collect (+ 100 n))

;; Preventing Islands
(defun direct-edges (node edge-list)
  (remove-if-not (lambda (x)
		   (eql (car x) node))
		 edge-list))

(defun get-connected (node edge-list)
  (let ((visited nil))
    (label ((traverse (node)
		      (unless (member node visited)
			(push node visited)
			(mapc (lambda (edge)
				(traverse (cdr edge)))
			      (direct-edges node edge-list)))))
	   (traverse node))
    visited))

(defun find-islands (nodes edge-list)
  (let ((islands nil))
    (labels ((find-island (nodes)
			 (let* ((connected (get-connected (car nodes) edge-list))
				(unconnected (set-difference nodes connected)))
			   (push connected islands)
			   (when unconnected
			     (find-island unconnected)))))
	   (find-island nodes))
    islands))

(defun connect-with-bridge (islands)
  (when (cdr islands)
    (append (edge-pair (caar islands) (caadr islands))
	    (connect-with-bridge (cdr islands)))))


(defun connect-all-islands (nodes edge-list)
  (append (connect-with-bridge (find-island nodes edge-list)) edge-list))

;; Building the Final Edges for Congestion City

;; To be continued
