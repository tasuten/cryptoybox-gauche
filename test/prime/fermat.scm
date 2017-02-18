(use gauche.test)

(test-start "cryptoybox.prime.fermat")
(import cryptoybox.prime.fermat)
(test-module 'cryptoybox.prime.fermat)

(test-section "Special")
(test* "0 is not prime" 'composite (fermat-test 0 2))
(test* "1 is not prime" 'composite (fermat-test 1 2))
(test* "2 is prime" 'probably (fermat-test 2 3))

(test-section "Composite")
(test* "9 is not prime" 'composite (fermat-test 9 4))
(test* "10 is not prime" 'composite (fermat-test 10 3))

(test-section "Prime")
(test* "3 is prime" 'probably (fermat-test 3 2))
(test* "5 is prime" 'probably (fermat-test 5 4))
(test* "20th Mersenne prime is prime" 'probably (fermat-test (- (expt 2 4423) 1) 123456))

(test-section "Carmichale number")
(test* "Carmichale number will be judged 'probably" 'probably (fermat-test 1105 11))

(test-section "Value check")
(test* "n in N" 'invalid (fermat-test -1 11))
(test* "2 <= a < n" 'invalid (fermat-test 11 11))


(test-end :exit-on-failure #t)
