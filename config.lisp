(defpackage :storage-manager.config
  (:use :cl :postmodern)
  (:export :create-tables
	   :*postgres-host*
	   :*postgres-user*
	   :*postgres-pass*
	   :*postgres-db*))

(in-package :storage-manager.config)

(defvar *postgres-host* "postgres" "Database host")

(defvar *postgres-user* "storuser" "Database username")

(defvar *postgres-pass* "storpass" "Database password")

(defvar *postgres-db* "stor" "Database name")
