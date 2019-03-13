(defpackage #:storagesite-asd
  (:use :cl :asdf))

(in-package :storagesite-asd)

(defsystem :storagesite
  :name "storagesite"
  :version "0.1"
  :maintainer "rayslava"
  :author "rayslava"
  :licence "BSD"
  :description "The home storage management server"
  :long-description "Lisp implementation of home storage management"
  :depends-on (:hunchentoot :cl-who :ht-simple-ajax :cl-css :local-time :postmodern)
  :components ((:file "site")
	       (:file "config")
	       (:file "db-storage"
		      :depends-on ("config"))
	       (:file "db-manage"
		      :depends-on ("db-storage"))))
