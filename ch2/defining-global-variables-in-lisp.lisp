(defparameter *small* 1)
(defparameter *big* 100)

(defparameter *foo* 5)
*foo*
;; 5
(defparameter *foo* 6)
*foo*
;; 6 ;; changed

(defvar *bar* 5)
*bar*
;; 5
(defvar *bar* 6)
*bar*
;; 5   ;; not changed

