;; Using the Stealth Conditionals and and or

(and (oddp 5) (oddp 7) (oddp 9))

(or (oddp 4) (oddp 7) (oddp 8))

(defparameter *is-it-even* nil)
(or (oddp 4) (setf *is-it-even* t))
*is-it-even*

(defparameter *is-it-even* nil)
(or (oddp 5) (setf *is-it-even* t))
*is-it-even*

(if *file-modified*
    (if (ask-user-about-saving)
	(save-file)))

(and *file-modified* (ask-user-about-saving) (save-file))

(if (and *file-modified*
	 (ask-user-about-saving))
    (save-file))


;; Using Functions That Return More than Just the Truth

(if (member 1 '(3 4 1 5))
    'one-is-in-the-list
    'one-is-not-int-the-list)

(member 1 '(3 4 1 5))

(if (member nil '(3 4 nil 5))
    'nil-is-in-the-list
    'nil-is-not-in-the-list)

(find-if #'oddp '(2 4 5 6))

(if (find-if #'oddp '(2 4 5 6))
    'there-is-an-odd-number
    'there-is-no-odd-number)

(find-if #'null '(2 4 nil 6))
;; NIL

