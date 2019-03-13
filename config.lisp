(defpackage :storagesite.config
  (:use :cl :postmodern)
  (:export :create-tables
	   :*postgres-host*
	   :*postgres-user*
	   :*postgres-pass*
	   :*postgres-db*))

(in-package :storagesite.config)

(defvar *postgres-host* "postgres" "Database host")

(defvar *postgres-user* "storuser" "Database username")

(defvar *postgres-pass* "storpass" "Database password")

(defvar *postgres-db* "stor" "Database name")
