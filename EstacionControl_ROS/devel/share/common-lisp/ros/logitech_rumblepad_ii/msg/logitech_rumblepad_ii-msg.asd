
(cl:in-package :asdf)

(defsystem "logitech_rumblepad_ii-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ComandoMovimiento" :depends-on ("_package_ComandoMovimiento"))
    (:file "_package_ComandoMovimiento" :depends-on ("_package"))
    (:file "ComandoEncendido" :depends-on ("_package_ComandoEncendido"))
    (:file "_package_ComandoEncendido" :depends-on ("_package"))
  ))