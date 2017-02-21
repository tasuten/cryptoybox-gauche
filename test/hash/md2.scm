(use gauche.test)

(test-start "cryptoybox.hash.md2")
(import cryptoybox.hash.md2)
(test-module 'cryptoybox.hash.md2)


(test-section "RFC 1319")
(test* "empty string" "8350e5a3e24c153df2275c9f80692773" (md2 ""))
(test* "a" "32ec01ec4a6dac72c0ab96fb34c0b5d1" (md2 "a"))
(test* "abc" "da853b0d3f88d99b30283a69e6ded6bb" (md2 "abc"))
(test* "message digest" "ab4f496bfb2a530b219ff33031fe06b0" (md2 "message digest"))
(test* "a-z" "4e8ddff3650292ab5a4108c3aa47940b" (md2 "abcdefghijklmnopqrstuvwxyz"))
(test* "A-Za-z0-9" "da33def2a42df13975352846c30338cd" (md2 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"))
(test* "1-90 x 8" "d5976f79d83d3a0dc9806c3c66f3efd8" (md2 "12345678901234567890123456789012345678901234567890123456789012345678901234567890"))


(test-end :exit-on-failure #t)

