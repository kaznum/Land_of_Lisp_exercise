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


;; To be continued
