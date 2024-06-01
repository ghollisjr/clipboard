(defpackage :clipboard
  (:nicknames :cb)
  (:use :cl)
  (:export :clipboard))

(in-package :clipboard)

(defun clipboard (&key
                    type
                    (selection "c"))
  "Gets clipboard as MIME type.  setf-able."
  (with-output-to-string (s)
    (sb-ext:run-program "/usr/bin/env"
                        (append (list "xclip"
                                      "-o")
                                (when type
                                  (list "-t" type))
                                (when selection
                                  (list "-sel" selection)))
                        :output s)))

(defun (setf clipboard) (val
                            &key
                            type
                            (selection "c"))
  "setf for clipboard"
  (with-input-from-string (s val)
    (sb-ext:run-program "/usr/bin/env"
                        (append
                         (list "xclip"
                               "-i")
                         (when type
                           (list "-t" type))
                         (when selection
                           (list "-sel" selection)))
                        :input s))
  val)
