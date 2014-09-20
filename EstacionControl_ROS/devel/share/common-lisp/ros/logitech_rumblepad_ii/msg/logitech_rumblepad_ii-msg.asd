
(cl:in-package :asdf)

(defsystem "logitech_rumblepad_ii-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Movimiento" :depends-on ("_package_Movimiento"))
    (:file "_package_Movimiento" :depends-on ("_package"))
    (:file "Encendido" :depends-on ("_package_Encendido"))
    (:file "_package_Encendido" :depends-on ("_package"))
  ))