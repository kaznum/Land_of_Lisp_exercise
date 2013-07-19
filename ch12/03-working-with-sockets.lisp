;; Socket Addresses
;; (nothing)
;; Socket Connections
;; (nothing)
;; Sending a Message over a Socket
(defparameter my-socket (socket-server 4321))  ;; server
(defparameter my-stream (socket-accept my-socket)) ;; server

(defparameter my-stream (socket-connect 4321 "127.0.0.1")) ;; client

(print "Yo! Server!" my-stream) ;; client
(read my-stream) ;; server

(print "What up, client!" my-stream) ;; server
(read my-stream) ;; client

;; Tyding Up After Ourselves

(close my-stream) ;; client
(close my-stream) ;; server
(socket-server-close my-stream) ;; server



