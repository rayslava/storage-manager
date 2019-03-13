;;;; tests/main.lisp

(in-package #:storage-manager-tests)

(def-suite all-tests
    :description "The master suite of all storage-manager tests.")

(in-suite all-tests)

(defun test-storage-manager ()
  (run! 'all-tests))

(test dummy-tests
  "Just a placeholder."
  (is (listp (list 1 2)))
  (is (= 5 (+ 2 3))))
