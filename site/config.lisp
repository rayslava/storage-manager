(defpackage :storage-manager.site.config
  (:use :cl :asdf)
  (:export :*admin-login*
	   :*admin-password*
	   :*access-log-file*
	   :*message-log-file*
	   :*default-static-path*
	   :*server-port*
	   :*admin-login-message*
	   :environment-credentials
	   :*credentials*
	   :*static-bucket*
	   :*aws-region*
	   :*distribution*))

(in-package :storage-manager.site.config)

(defvar *admin-login* "admin"
  "Admin page password")

(defvar *admin-password*
  (let ((envpass (asdf::getenv "ADMIN_PASSWORD")))
    (if envpass
	envpass
	"adminpassword"))
  "Admin page password")

(defvar *access-log-file* *error-output*
  "Server access log file")

(defvar *message-log-file* *error-output*
  "Server message log file")

(defvar *server-port* 8080
  "Default server port")

(defvar *admin-login-message* "Please enter admin credentials"
  "Message which will appear if user tries to get access to admin page")

(defvar *default-static-path* (concatenate 'string (namestring  (sb-posix::getcwd)) "/" "static")
  "Default path where server should search for files that should be exported as is")

(defclass environment-credentials () ())

(defmethod access-key ((credentials environment-credentials))
  (declare (ignore credentials))
  (asdf::getenv "AWS_ACCESS_KEY"))

(defmethod secret-key ((credentials environment-credentials))
  (declare (ignore credentials))
  (asdf::getenv "AWS_SECRET_KEY"))

(defmethod loaded ((credentials environment-credentials))
  (and (not (eq (access-key credentials) nil))
       (not (eq (secret-key credentials) nil))))

(defmethod print-object ((credentials environment-credentials) out)
  (print-unreadable-object (credentials out :type t)
    (if (loaded credentials)
	(format out "Environment credentials ~A:~A" (access-key credentials) (secret-key credentials))
	(format out "Empty credentials (envvars not set up)"))))
