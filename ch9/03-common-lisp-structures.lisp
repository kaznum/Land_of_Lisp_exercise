;; Working with Structures
(defstruct person
  name
  age
  waist-size
  favorite-color)

(defparameter *bob* (make-person :name "Bob"
				 :age 35
				 :waist-size 32
				 :favorite-color "blue"))

*bob*

(person-age *bob*)

(setf (person-age *bob*) 36)
*bob*

(defparameter *that-guy* #S(person :name "Bob" :age 35 :waist-size 32 :favorite-color "blue"))

*that-guy*
(person-age *that-guy*)

;; When to use Structures

(defun make-person (name age waist-size favorite-color)
  (list name age waist-size favorite-color))


(defun person-age (person)
  (cadr person))

(defparameter *bob* (make-person "Bob" 35 32 "blue"))
*bob*
(person-age *bob*)


