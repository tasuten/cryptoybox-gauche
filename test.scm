#!/usr/bin/env gosh
(define base-dir (sys-dirname "cryptoybox-gauche"))
(for-each load (glob #`",|base-dir|/lib/**/*.scm"))
(for-each load (glob #`",|base-dir|/test/**/*.scm"))

