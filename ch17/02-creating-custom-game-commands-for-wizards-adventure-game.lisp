;; Creating New Game Commands by Hand
(load "wizards_game")

;;; A Command for Welding
(defun have (object)
  (member object (inventory)))

(defparameter *chain-welded* nil)

(defun weld (subject object)
  (if (and (eq *location* 'attic)
	   (eq subject 'chain)
	   (eq object 'bucket)
	   (have 'chain)
	   (have 'bucket)
	   (not *chain-welded*))
      (progn (setf *chain-welded* t)
	     '(the chain is now securely welded to the buckets.))
      '(you cannot weld like that.)))

(pushnew 'weld *allowed-commands*)

;;; A Command for Dunking

;; to be continued
