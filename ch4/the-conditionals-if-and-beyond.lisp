(if (= (+ 1 2) 3)
    'yup
    'nope)

(if (= (+ 1 2) 4)
    'yup
    'nope)

(if '(1)
    'the-list-has-stuff-in-it
    'the-list-is-empty)

(if '()
    'the-list-has-stuff-in-it
    'the-list-is-empty)

(if (oddp 5)
    'odd-number
    'even-number)

(if (oddp 5)
    'odd-number
    (/ 1 0))
;; (/ 1 0) is not evaluated


(defvar *number-was-odd* nil)

(if (oddp 5)
    (progn (setf *number-was-odd* t)
	   'odd-number)
    'even-number)

*number-was-odd*

;; Going Beyond if: The when and unless Alternatives

(defvar *number-is-odd* nil)
(when (oddp 5)
  (setf *number-is-odd* t)
  'odd-number)

*number-is-odd*

(unless (oddp 4)
  (setf *number-is-odd* nil)
  'even-number)

*number-is-odd*

;; The Command That Does It All: cond

(defvar *arch-enemy* nil)
(defun pudding-eater (person)
  (cond ((eq person 'henry) (setf *arch-enemy* 'stupid-lisp-alien)
	 '(curse you lisp alien - you ate my pudding))
	((eq person 'johnny) (setf *arch-enemy* 'useless-old-johnny)
	 '(i hope you choked on my pudding johnny))
	(t '(why you ate my pudding stranger ?))))

;; TEST
(pudding-eater 'johnny)
*arch-enemy*
(pudding-eater 'george-clooney)

;; Branching with case

(defun pudding-eater (person)
  (case person
    ((henry) (setf *arch-enemy* 'stupid-lisp-alien)
     '(curse you lisp alien - you ate my pudding))
    ((johnny) (setf *arch-enemy* 'useless-old-johnny)
     '(i hope you choked on my pudding johnny))
    (otherwise '(why you ate my pudding stranger ?))))
;; TEST
(pudding-eater 'johnny)
*arch-enemy*
(pudding-eater 'george-clooney)

