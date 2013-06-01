;; Control Sequences for Formatting Integers

(format t "The number 1000 in hexadecimal is ~x" 1000)

(format t "The number 1000 in binary is ~b" 1000)

(format t "The number 1000 in decimal is ~d" 1000)

(format t "Numbers with commas in them are ~:d times better" 1000000)

(format t "I am printing ~10d within ten spaces of room" 1000000)

(format t "I am printing ~10,'xd within ten spaces of room" 1000000)

;; Control Sequences for Formatting Floating-Point Numbers

(format t "PI can be estimated as ~4f" 3.1415936)

(format t "PI can be estimated as ~,4f" 3.1415936)

(format t "Percentages are ~,,2f percent better than fractions" 0.77)

(format t "I wish I had ~$ dollars in my bank account" 100000.2)

