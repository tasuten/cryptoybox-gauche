(define-module cryptoybox.prime.fermat
               (export fermat-test)
               )
(select-module cryptoybox.prime.fermat)

(define (fermat-test n a)
  (cond ((not (= (gcd n a) 1)) 'composite)
        ((not (= (expt-mod a (- n 1) n) 1)) 'composite)
        (else 'probably)
        )
  )

