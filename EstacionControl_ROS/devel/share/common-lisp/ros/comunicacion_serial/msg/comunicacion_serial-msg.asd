
(cl:in-package :asdf)

(defsystem "comunicacion_serial-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "Movimiento" :depends-on ("_package_Movimiento"))
    (:file "_package_Movimiento" :depends-on ("_package"))
    (:file "EstadoCuadricoptero" :depends-on ("_package_EstadoCuadricoptero"))
    (:file "_package_EstadoCuadricoptero" :depends-on ("_package"))
    (:file "Encendido" :depends-on ("_package_Encendido"))
    (:file "_package_Encendido" :depends-on ("_package"))
  ))