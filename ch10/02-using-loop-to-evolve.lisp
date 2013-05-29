(defparameter *width* 100)
(defparameter *height* 30)
(defparameter *jungle* '(45 10 10 10))
(defparameter *plant-energy* 80)

;; Glowing Plants in Our World

(defparameter *plants* (make-hash-table :test #'equal))
(defun random-plant (left top width height)
  (let ((pos (cons (+ left (random width)) (+ top (random height)))))
    (setf (gethash pos *plants*) t)))
(defun add-plants ()
  (apply #'random-plant *jungle*)
  (random-plant 0 0 *width* *height*))

;; Creating Animals
(defstruct animal x y energy dir genes)

;; Anatomy of an Animal

(defparameter *animals*
  (list (make-animal :x (ash *width* -1)
		     :y (ash *height* -1)
		     :energy 1000
		     :dir 0
		     :genes (loop repeat 8
				 collecting (1+ (random 10))))))

;; Handling Animal Motion
(defun move (animal)
  (let ((dir (animal-dir animal))
	(x (animal-x animal))
	(y (animal-y animal)))
    (setf (animal-x animal) (mod (+ x
				    (cond ((and (>= dir 2) (< dir 5)) 1)
					  ((or (= dir 1) (= dir 5)) 0)
					  (t -1))
				    *width*)
				 *width*))
    (setf (animal-y animal) (mod (+ y
				    (cond ((and (>= dir 0) (< dir 3)) -1)
					  ((or (>= dir 4) (< dir 7)) 1)
					  (t 0))
				    *height*)
				 *height*))
    (decf (animal-energy animal))))


;; Handling Animal Turning
(defun turn (animal)
  (let (x (random (apply #'+ (animal-genes animal))))
    (labels ((angle (genes x)
	       (let ((xnu (- x (car genes))))
		 (if (< xnu 0)
		     0
		     (1+ (angle (cdr genes) xnu))))))
      (setf (animal-dir animal)
	    (mod (+ (animal-dir animal) (angle (animal-genes animal) x)) 8)))))

;; Handling Animal Eating
(defun eat (animal)
  (let ((pos (cons (animal-x animal) (animal-y animal))))
    (when (gethash pos *plants*)
      (incf (aniaml-energy animal) *plant-energy*)
      (remhash pos *plants*))))

;; Handling Animal Reproduction
(defun reproduce (animal)
  (let ((e (animal-energy animal)))
    (when (>= e *reproduction-energy*)
      (setf (animal-energy animal) (ash e -1))
      (let ((animal-nu (copy-structure aniaml))
	    (genes (copy-list (animal-genes animal)))
	    (mutation (random 8)))
	(setf (nth mutation genes) (max 1 (+ (nth mutation genes) (random 3) -1)))
	(setf (animal-genes animal-nu) genes)
	(push animal-nu *animals*)))))


;; copy-structure test
(defparameter *parent* (make-animal :x 0
				    :y 0
				    :energy 0
				    :dir 0
				    :genes '(1 1 1 1 1 1 1 1)))
(defparameter *child* (copy-structure *parent*))
(setf (nth 2 (animal-genes *parent*)) 10)
*parent*
*child*

;; Simulating a Day in Our World
(defun update-world ()
  (setf *animals* (remove-if (lambda (animal)
			       (<= (animal-energy animal) 0))
			     *animals*))
  (mapc (lambda (animal)
	  (turn animal)
	  (move animal)
	  (eat animal)
	  (reproduce animal))
	*animals*)
  (add-plants))

;; Drawing Our World
(defun draw-world ()
  (loop for y
       below *height*
       do (progn (fresh-line)
		 (princ "|")
		 (loop for x
		      below *width*
		      do (princ (cond ((some (lambda (animal)
					       (and (= (animal-x animal) x)
						    (= (animal-y animal) y)))
					     *animals*)
				       #\M)
				      ((gethash (cons x y) *plants*) #\*)
				      (t #\space))))
		 (princ "|"))))

;; Creating a User Interface
(defun evaluation ()
  (draw-world)
  (fresh-line)
  (let ((str (read-line)))
    (cond ((equal str "quit") ())
	  (t (let ((x (parse-integer str :junk-allowed t)))
	       (if x
		   (loop for i
		      below x
		      do (update-world)
		      if (zerop (mod i 1000))
		      do (princ #\.))
		   (update-world))
	       (evaluation))))))

;; Let's Watch Some Evaluation
;; to be continued

