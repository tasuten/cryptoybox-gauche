(define-module cryptoybox.hash.md2
               (export md2)
               (use gauche.uvector)
               (use srfi-1)
               (include "../utils/u8vector.scm")
               (import cryptoybox.utils.u8vector)
               )
(select-module cryptoybox.hash.md2)

(define (md2 message)
  (u8vector->hexstring
    (digest (compress (append-checksum (append-padding (string->u8vector message)))))
    )
  )


(define (append-padding bytes)
  (let ((len (- 16 (modulo (u8vector-length bytes) 16))))
    (u8vector-append bytes (make-u8vector len len))
    )
  )

(define (append-checksum bytes)
  (u8vector-append bytes (checksum-loop bytes (make-u8vector 16 0) 0))
  )

(define (checksum-loop bytes checksum last)
  (if (= 0 (u8vector-length bytes)) checksum
    (let ((section (u8vector-copy bytes 0 16)))
      (dotimes (index 16)
        (let ((tmp (u8vector-ref *PI_SUBST*
                                 (logxor last (u8vector-ref section index)))))
          (u8vector-set!
            checksum index (logxor tmp (u8vector-ref checksum index)))
          (set! last (u8vector-ref checksum index))
          )
        )

      (checksum-loop (u8vector-copy bytes 16) checksum last)
      )
    )
  )

(define *PI_SUBST*
  #u8(
      41  46  67  201 162 216 124 1   61  54  84  161 236 240 6
      19  98  167 5   243 192 199 115 140 152 147 43  217 188
      76  130 202 30  155 87  60  253 212 224 22  103 66  111 24
      138 23  229 18  190 78  196 214 218 158 222 73  160 251
      245 142 187 47  238 122 169 104 121 145 21  178 7   63
      148 194 16  137 11  34  95  33  128 127 93  154 90  144 50
      39  53  62  204 231 191 247 151 3   255 25  48  179 72  165
      181 209 215 94  146 42  172 86  170 198 79  184 56  210
      150 164 125 182 118 252 107 226 156 116 4   241 69  157
      112 89  100 113 135 32  134 91  207 101 230 45  168 2   27
      96  37  173 174 176 185 246 28  70  97  105 52  64  126 15
      85  71  163 35  221 81  175 58  195 92  249 206 186 197
      234 38  44  83  13  110 133 40  132 9   211 223 205 244 65
      129 77  82  106 220 55  200 108 193 171 250 36  225 123
      8   12  189 177 74  120 136 149 139 227 99  232 109 233
      203 213 254 59  0   29  57  242 239 183 14  102 88  208 228
      166 119 114 248 235 117 75  10  49  68  80  180 143 237
      31  26  219 153 141 51  159 17  131 20
      )
  )

(define (compress bytes)
  (compress-loop bytes (make-u8vector 48 0))
  )

(define (compress-loop bytes x)
  (if (= 0 (u8vector-length bytes)) x
    (let ((section (u8vector-copy bytes 0 16)))

      (dotimes (index 16)
        (u8vector-set! x (+ 16 index) (u8vector-ref section index))
        (u8vector-set! x (+ 32 index) (logxor (u8vector-ref x index) (u8vector-ref x (+ 16 index)))))

      (let ((t 0))
        (dotimes (r 18)
          (dotimes (k 48)
            (u8vector-set! x k (logxor (u8vector-ref x k) (u8vector-ref *PI_SUBST* t)))
            (set! t (u8vector-ref x k))
            )
          (set! t (modulo (+ t r) 256))
          )
        )

      (compress-loop (u8vector-copy bytes 16) x)
      )
    )
  )

(define (digest bytes)
  (u8vector-copy bytes 0 16)
  )
