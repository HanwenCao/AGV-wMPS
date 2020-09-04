
(cl:in-package :asdf)

(defsystem "serial_port-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Num" :depends-on ("_package_Num"))
    (:file "_package_Num" :depends-on ("_package"))
    (:file "carOdom" :depends-on ("_package_carOdom"))
    (:file "_package_carOdom" :depends-on ("_package"))
  ))