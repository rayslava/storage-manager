;;;; Database interaction tests

(in-package :storage-manager-tests)

(def-suite db-tests
    :description "The master suite of  storage-manager database interaction tests."
    :in all-tests)

(in-suite db-tests)

(defun test-storage-manager-db ()
  (run! 'db-tests))

(test storage-tests
  "Storage table tests"
  (postmodern:with-connection
      `(,*postgres-db* ,*postgres-user* ,*postgres-pass* ,*postgres-host*)

    (postmodern:query (:drop-table 'chemical))
    (postmodern:query (:drop-table 'storage))

    (postmodern:create-table 'storage)
    (postmodern:create-table 'chemical)

    (let ((stor (make-instance 'storage :location "Kitchen" :name "ok")))
      (postmodern:insert-dao stor))

    (let ((stor (make-instance 'storage :location "Wardrobe" :name "somewhere")))
      (postmodern:insert-dao stor))

    (let ((chem (make-instance 'chemical :name "ХИМИЯ" :comment "Злая химия!" :volume 1 :stor-id 1))
	  (chem2 (make-instance 'chemical :name "Химия" :comment "Злая химия N2" :volume 8 :stor-id 2))
	  (chem3 (make-instance 'chemical :name "Зубная паста" :comment "Обычной породы" :volume 1 :stor-id 1)))
      (mapcar #'postmodern:insert-dao (list chem chem2 chem3)))
    (let ((result (postmodern:select-dao 'chemical (:= 'stor-id 1))))
      (is (= (length result) 2))
      (is (string= (slot-value (car result) 'storage-manager.db-storage::name) "ХИМИЯ"))
      (is (string= (slot-value (cadr result) 'storage-manager.db-storage::name) "Зубная паста")))
    (let ((result (postmodern:select-dao 'chemical (:= 'stor-id 2))))
      (is (= (length result) 1))
      (is (string= (slot-value (car result) 'storage-manager.db-storage::name) "Химия"))
      (is (string= (slot-value (car result) 'storage-manager.db-storage::comment) "Злая химия N2"))
      (is (= (slot-value (car result) 'storage-manager.db-storage::volume) 8)))))
