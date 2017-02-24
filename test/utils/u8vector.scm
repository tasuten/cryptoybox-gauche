(use gauche.test)

(test-start "cryptoybox.utils.u8vector")
(import cryptoybox.utils.u8vector)
(test-module 'cryptoybox.utils.u8vector)

(test-section "Normal")
(test* "00000000" "00000000" (u8vector->hexstring (hexstring->u8vector "00000000")))
(test* "0123456789abcdef" "0123456789abcdef" (u8vector->hexstring (hexstring->u8vector "0123456789abcdef")))

(test-end :exit-on-failure #t)

