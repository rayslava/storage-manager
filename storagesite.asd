(defpackage #:storage-manager-asd
  (:use #:cl #:asdf))

(in-package :storage-manager-asd)

(defsystem :storage-manager
  :name "storage-manager"
  :version "0.1"
  :maintainer "rayslava"
  :author "rayslava"
  :licence "BSD"
  :description "The home storage management server"
  :long-description "Lisp implementation of home storage management"
  :depends-on (:hunchentoot :cl-who :ht-simple-ajax :cl-css :local-time :postmodern :fiveam)
  :in-order-to ((test-op (test-op "storage-manager/tests")))
  :components ((:module "site"
			:components ((:file "config")
				     (:file "static"
					    :depends-on ("config"))
				     (:file "style"
					    :depends-on ("config"))
				     (:file "site"
					    :depends-on ("style" "static"))))
	       (:file "config")
	       (:file "db-storage"
		      :depends-on ("config"))))

(defsystem :storage-manager/tests
  :depends-on (:storage-manager #:fiveam)
  :components ((:module "tests"
			:components ((:file "package")
				     (:file "main"
					    :depends-on ("package"))
				     (:file "db"
					    :depends-on ("package")))))
  :perform (test-op (o c)
		    (uiop:symbol-call :fiveam :run! :all-tests)))
