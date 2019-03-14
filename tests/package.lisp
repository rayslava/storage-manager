;;;; tests/package.lisp

(defpackage :storage-manager-tests
  (:use :cl :fiveam
	:storage-manager.db-storage
	:storage-manager.config)
  (:export :run!
	   :all-tests
	   :db-tests))
