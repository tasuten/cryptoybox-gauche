#!/usr/bin/env gosh
(define (main args)
  (if (null? (cdr args))
    (test-all)
    (for-each (lambda (path)
                (test path)
                )
              (cdr args))
    )
  0
  )

; call like (test "hash/md2")
(define (test path)
  (load (string-append "./lib/" path ".scm"))
  (load (string-append "./test/" path ".scm"))
  )

(define (test-all)
  (for-each load (glob "./lib/**/*.scm"))
  (for-each load (glob "./test/**/*.scm"))
  )
