;; Creating the lazy and force Commands

;;; The followings don't work right now
(lazy (+ 1 2))
;;; #<FUNCTION ...>
(force (lazy (+ 1 2)))
;;; 3

