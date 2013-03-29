;; *wizard-nodes*, *wizard-edges* are from the previous section
(defparameter *wizard-nodes* '((living-room (you are in the living-room.
					     a wizard is snoring loudly on the couch.))
			       (garden (you are in a beautiful garden.
					there is a well in front of you.))
			       (attic (you are in the attic.
				       there is a giant welding torch in the corner.))))

(defparameter *wizard-edges* '((living-room (garden west door)
				(attic upstairs ladder))
			       (garden (living-room east door))
			       (attic (living-room downstairs ladder))))


;; See test.dot and test.dot.png which are generated by 'neato -Tpng -O test.dot' on shell.

;; Generating the Dot Information

;; Converting Node Identifier
(defun dot-name (exp)
  (substitute-if #\_ (complement #'alphanumericp) (prin1-to-string exp)))

(dot-name 'foo)
(dot-name 'foo!)
(dot-name '24)

;; substitute-if is a generic function
;; for string
(substitute-if #\e #'digit-char-p "I'm a l33t hack3r")
;; for list
(substitute-if 0 #'oddp '(1 2 3 4 5 6 7 8))

(complement #'alphanumericp)

(apply (complement #'alphanumericp) (list #\1))
(apply (complement #'alphanumericp) (list #\x))
(apply (complement #'alphanumericp) (list #\.))
(funcall (complement #'alphanumericp) #\1)
(funcall (complement #'alphanumericp) #\x)
(funcall (complement #'alphanumericp) #\.)

;; Adding labels to Graph Nodes

(defparameter *max-label-length* 30)

(defun dot-label (exp)
  (if exp
      (let ((s (write-to-string exp :pretty nil)))
	(if (> (length s) *max-label-length*)
	    (concatenate 'string (subseq s 0 (- *max-label-length* 3)) "...")
	    s))
      ""))

;; TEST
(dot-label 'abcde)
(dot-label 'abcdeabcdeabcdeabcdeabcdeabcdeabcde)

;; Generating the DOT Information for Nodes
(defun nodes->dot (nodes)
  (mapc (lambda (node)
	  (fresh-line)
	  (princ (dot-name (car node)))
	  (princ "[label=\"")
	  (princ (dot-label node))
	  (princ "\"];"))
	nodes))

(nodes->dot *wizard-nodes*)

;; Converting Edges in DOT Format

(defun edges->dot (edges)
  (mapc (lambda (node)
	  (mapc (lambda (edge)
		  (fresh-line)
		  (princ (dot-name (car node)))
		  (princ "->")
		  (princ (dot-name (car edge)))
		  (princ "[label=\"")
		  (princ (dot-label (cdr edge)))
		  (princ "\"]"))
		(cdr node)))
	edges))

(edges->dot *wizard-edges*)


;; Generating All the DOT Data

(defun graph->dot (nodes edges)
  (princ "digraph{")
  (nodes->dot nodes)
  (edges->dot edges)
  (princ "}"))

(graph->dot *wizard-nodes* *wizard-edges*)

;; Turning the DOT File into a Picture

(defun dot->png (fname thunk)
  (with-open-file (*standard-output*
		   fname
		   :direction :output
		   :if-exists :supersede)
    (funcall thunk))
  (ext:shell (concatenate 'string "dot -Tpng -O " fname)))

;; Using Thunks
;;;; no code

;; Writing to a File

(with-open-file (my-stream
		 "testfile.txt"
		 :direction :output
		 :if-exists :supersede)
  (princ "Hello File!" my-stream))

;; Creating a Stream

;; Understanding Keyword Parameters
(let ((cigar 5))
  cigar)

(let ((:cigar 5))
  :cigar)
;; error

;; Capturing the Console Output

;; Creating a Picture of Our Graph


;; to be continued
