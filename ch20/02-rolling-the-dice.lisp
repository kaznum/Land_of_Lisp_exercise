(load "01-increasing-the-number-of-players")

;; Building Chance Nodes

;;; previous move node format
;;; (nil|(<src> <dest>) <tree>)
;;; new move node format
;;; (nil|(<src> <dest>) <winning-tree> <losing-tree>)
(defun attacking-moves (board cur-player spare-dice)
  (labels ((player (pos)
	     (car (aref board pos)))
	   (dice (pos)
	     (cadr (aref board pos))))
    (lazy-mapcan (lambda (src)
		   (if (eq (player src) cur-player)
		       (lazy-mapcan
			(lambda (dst)
			  (if (and (not (eq (player dst) cur-player))
				   (> (dice src) 1))
			      (make-lazy (list (list (list src dst)
						     (game-tree (board-attack board cur-player src dst (dice src))
								cur-player
								(+ spare-dice (dice dst))
								nil)
						     (game-tree (board-attack-fail board cur-player src dst (dice src))
								cur-player
								(+ spare-dice (dice dst))
								nil))))
			      (lazy-nil)))
			(make-lazy (neighbors src)))
		       (lazy-nil)))
		 (make-lazy (loop for n below *board-hexnum*
				 collect n)))))

(defun board-attack-fail (board player src dst dice)
  (board-array (loop for pos from 0
		    for hex across board
		    collect (if (eq pos src)
				(list player 1)
				hex))))

;; Doing the Actual Dice Rolling


;; to be continued

