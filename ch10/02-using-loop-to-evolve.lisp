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

;; to be continued
