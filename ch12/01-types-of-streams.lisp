;; Streams by Direction

;;; Output Streams
(output-stream-p *standard-output*)
(write-char #\x *standard-output*)

;;; Input Streams
(input-stream-p *standard-input*)
(read-char *standard-input*)

(print 'foo *standard-output*)

