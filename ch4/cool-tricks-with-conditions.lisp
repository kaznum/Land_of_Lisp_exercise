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


;; to be continued
