(defpackage :storage-manager.db-storage
  (:use :cl :postmodern :storage-manager.config)
  (:export :storage
	   :storage-entity
	   :chemical))

(in-package :storage-manager.db-storage)

(defclass storage ()
  ((id :col-type bigserial :initarg :id :accessor storage-id)
   (location :col-type string :initarg :location :accessor storage-location)
   (name :col-type (or db-null string) :initarg :name :accessor storage-name))
  (:metaclass dao-class)
  (:keys id))

;;; Parent class for generic storage entity
(defclass storage-entity ()
  ((id :col-type bigserial :initarg :id :accessor storage-entity-id)
   (name :col-type (or db-null string) :initarg :name :accessor storage-entity-name)
   (comment :col-type (or db-null string) :initarg :comment :accessor storage-entity-comment)
   (stor-id :col-type integer :initarg :stor-id :accessor storage-entity-stor-id))
  (:metaclass dao-class)
  (:keys id))

;;; Household chemicals
(defclass chemical (storage-entity)
  ((volume :col-type integer :initarg :volume :accessor chemical-volume))
  (:metaclass dao-class))

(deftable chemical
  (!dao-def)
  (!unique 'id)
  (!foreign 'storage 'stor-id :primary-key :on-delete :cascade :on-update :cascade))

(deftable storage
  (!dao-def)
  (!unique 'id))

(defmethod print-object ((obj chemical) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((n storage-entity-name)
                     (c storage-entity-comment)
		     (l storage-entity-stor-id)
		     (v chemical-volume))
	obj
      (format stream "~a, [~d] comment: ~a @~d" n v c l))))

(defmethod print-object ((obj storage) stream)
  (print-unreadable-object (obj stream :type t)
    (with-accessors ((n storage-name)
		     (l storage-location))
	obj
      (format stream "~a, name: ~a" l n))))
