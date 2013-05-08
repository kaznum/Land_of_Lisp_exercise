;; Global Variables for the Player and Monsters
(defparameter *player-health* nil)
(defparameter *player-agility* nil)
(defparameter *player-strength* nil)

(defparameter *monsters* nil)
(defparameter *monster-builders* nil)
(defparameter *monster-num* 12)

;; Main Game Functions

(defun orc-battle ()
  (init-monsters)
  (init-player)
  (game-loop)
  (when (player-dead)
    (princ "You have been killed. Game Over."))
  (when (monsters-dead)
    (princ "Congratulations! You have vanquished all of your foes.")))

(defun game-loop ()
  (unless (or (player-dead) (monsters-dead))
    (show-player)
    (dotimes (k (1+ (truncate (/ (max 0 *player-agility*) 15))))
      (unless (monsters-dead)
	(show-monsters)
	(player-attack)))
    (fresh-line)
    (map 'list
	 (lambda (m)
	   (or (monster-dead m) (monster-attack m)))
	 *monsters*)
    (game-loop)))


(dotimes (i 3)
  (fresh-line)
  (princ i)
  (princ ". Hatchoo!"))


;; Player Management Functions
(defun init-player ()
  (setf *player-health* 30)
  (setf *player-agility* 30)
  (setf *player-strength* 30))

(defun player-dead ()
  (<= *player-health* 0))

(defun show-player ()
  (fresh-line)
  (princ "You are a valiant knight with a health of ")
  (princ *player-health*)
  (princ ", an agility of ")
  (princ *player-agility*)
  (princ ", and a strength of ")
  (princ *player-strength*))

(defun player-attack ()
  (fresh-line)
  (princ "Attack style: [s]tab [d]ouble swing [r]oundhouse: ")
  (case (read)
    (s (monster-hit (pick-monster)
		    (+ 2 (randval (ash *player-strength* -1)))))
    (d (let ((x (randval (truncate (/ *player-strength* 6)))))
	 (princ "Your double swing has a strength of ")
	 (princ x)
	 (fresh-line)
	 (monster-hit (pick-monster) x)
	 (unless (monsters-dead)
	   (monster-hit (pick-monster) x))))
    (otherwise (dotimes (x (1+ (randval (truncate (/ *player-strength* 3)))))
		 (unless (monsters-dead)
		   (monster-hit (random-monster) 1))))))

(defun randval (n)
  (1+ (random (max 1 n))))

(dotimes (i 10)
  (princ (random 5))
  (princ " "))

;; Helper Functions for Player Attacks
(defun random-monster ()
  (let ((m (aref *monsters* (random (length *monsters*)))))
    (if (monster-dead m)
	(random-monster)
	m)))

(defun pick-monster ()
  (fresh-line)
  (princ "Monster #:")
  (let ((x (read)))
    (if (not (and (integerp x) (>= x 1) (<= x *monster-num*)))
	(progn (princ "That is not a valid monster number.")
	       (pick-monster))
	(let ((m (aref *monsters* (1- x))))
	  (if (monster-dead m)
	      (progn (princ "That monster is already dead.")
		     (pick-monster))
	      m)))))

;; Monster Management Functions
(defun init-monsters ()
  (setf *monsters*
	(map 'vector
	     (lambda (x)
	       (funcall (nth (random (length *monster-builders*))
			     *monster-builders*)))
	     (make-array *monster-num*))))


(defun monster-dead (m)
  (<= (monster-health m) 0))

(defun monsters-dead ()
  (every #'monster-dead *monsters*))

(defun show-monsters ()
  (fresh-line)
  (princ "Your foes:")
  (let ((x 0))
    (map 'list
	 (lambda (m)
	   (fresh-line)
	   (princ "     ")
	   (princ (incf x))
	   (princ ". ")
	   (if (monster-dead m)
	       (princ "**dead**")
	       (progn (princ "(health=")
		      (princ (monster-health m))
		      (princ ") ")
		      (show-monster m))))
	 *monsters*)))

;; Monsters
(defstruct monster (health (randval 10)))

(make-monster)
(defmethod monster-hit (m x)
  (decf (monster-health m) x)
  (if (monster-dead m)
      (progn (princ "You killed the ")
	     (princ (type-of m))
	     (princ "! "))
      (progn (princ "You hit the ")
	     (princ (type-of m))
	     (princ ", knocking off ")
	     (princ x)
	     (princ " health points! "))))


(type-of 'foo)
(type-of 1)
;; bit
(type-of 5)
(type-of "foo")
(type-of (make-monster))

(defmethod monster-show (m)
  (princ "A fierce ")
  (princ (type-of m)))

;; Currently the following method is a placeholder
(defmethod monster-attack (m))

;; The Wicked Orc
(defstruct (orc (:include monster)) (club-level (randval 8)))
(push #'make-orc *monster-builders*)

(defmethod monster-show ((m orc))
  (princ "A wicked orc with a level ")
  (princ (orc-club-level m))
  (princ " club"))

(defmethod monster-attack ((m orc))
  (let ((x (randval (orc-club-level m))))
    (princ "An orc swings his club at you and knocks off ")
    (princ x)
    (princ " of your health points. ")
    (decf *player-health* x)))

;; The Malicious Hydra
(defstruct (hydra (:include monster)))
(push #'make-hydra *monster-builders*)
(defmethod monster-show ((m hydra))
  (princ "A malicious hydra with ")
  (princ (monster-health m))
  (princ " heads."))

(defmethod monster-hit ((m hydra) x)
  (decf (monster-health m) x)
  (if (monster-dead m)
      (princ "The corpse of the fully deprecated and decapacitated hydra falls to the floor!")
      (progn (princ "You lop off ")
	     (princ x)
	     (princ " of the hydra's heads"))))

(defmethod monster-attack ((m hydra))
  (let ((x (randval (ash (monster-health m) -1))))
    (princ "A hydra attacks you with ")
    (princ x)
    (princ " of its heads! It also grows back one more head!")
    (incf (monster-health m))
    (decf *player-health* x)))

;; The Slimy Slime Mold

;; to be continue

