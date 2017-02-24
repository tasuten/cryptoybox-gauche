(define-module cryptoybox.utils.u8vector
               (export
                 u8vector->hexstring
                 hexstring->u8vector
                 )
               (use gauche.uvector)
               )
(select-module cryptoybox.utils.u8vector)

(define (u8vector->hexstring bytes)
  (string-join
    (map (lambda (byte) (format #f "~2,'0x" byte))
         (u8vector->list bytes)
         )
    "")
  )

(define (hexstring->u8vector hex)
  (hex-u8vector-loop hex #u8())
  )

(define (hex-u8vector-loop hex acc)
  (if (= 0 (string-length hex)) acc
    (hex-u8vector-loop
      (string-copy hex 2)
      (u8vector-append  acc
                        (u8vector (string->number (string-copy hex 0 2) 16)))
      )
    )
  )
