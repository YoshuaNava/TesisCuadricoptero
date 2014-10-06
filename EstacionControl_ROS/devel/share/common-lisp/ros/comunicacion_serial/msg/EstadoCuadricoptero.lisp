; Auto-generated. Do not edit!


(cl:in-package comunicacion_serial-msg)


;//! \htmlinclude EstadoCuadricoptero.msg.html

(cl:defclass <EstadoCuadricoptero> (roslisp-msg-protocol:ros-message)
  ((tiempoEjecucion
    :reader tiempoEjecucion
    :initarg :tiempoEjecucion
    :type cl:real
    :initform 0)
   (anguloPitch
    :reader anguloPitch
    :initarg :anguloPitch
    :type cl:integer
    :initform 0)
   (anguloRoll
    :reader anguloRoll
    :initarg :anguloRoll
    :type cl:integer
    :initform 0)
   (anguloYaw
    :reader anguloYaw
    :initarg :anguloYaw
    :type cl:integer
    :initform 0)
   (velocidadPitch
    :reader velocidadPitch
    :initarg :velocidadPitch
    :type cl:integer
    :initform 0)
   (velocidadRoll
    :reader velocidadRoll
    :initarg :velocidadRoll
    :type cl:integer
    :initform 0)
   (velocidadYaw
    :reader velocidadYaw
    :initarg :velocidadYaw
    :type cl:integer
    :initform 0)
   (altura
    :reader altura
    :initarg :altura
    :type cl:integer
    :initform 0)
   (encendido
    :reader encendido
    :initarg :encendido
    :type cl:integer
    :initform 0)
   (mensajesRecibidos
    :reader mensajesRecibidos
    :initarg :mensajesRecibidos
    :type cl:integer
    :initform 0))
)

(cl:defclass EstadoCuadricoptero (<EstadoCuadricoptero>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <EstadoCuadricoptero>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'EstadoCuadricoptero)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comunicacion_serial-msg:<EstadoCuadricoptero> is deprecated: use comunicacion_serial-msg:EstadoCuadricoptero instead.")))

(cl:ensure-generic-function 'tiempoEjecucion-val :lambda-list '(m))
(cl:defmethod tiempoEjecucion-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:tiempoEjecucion-val is deprecated.  Use comunicacion_serial-msg:tiempoEjecucion instead.")
  (tiempoEjecucion m))

(cl:ensure-generic-function 'anguloPitch-val :lambda-list '(m))
(cl:defmethod anguloPitch-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:anguloPitch-val is deprecated.  Use comunicacion_serial-msg:anguloPitch instead.")
  (anguloPitch m))

(cl:ensure-generic-function 'anguloRoll-val :lambda-list '(m))
(cl:defmethod anguloRoll-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:anguloRoll-val is deprecated.  Use comunicacion_serial-msg:anguloRoll instead.")
  (anguloRoll m))

(cl:ensure-generic-function 'anguloYaw-val :lambda-list '(m))
(cl:defmethod anguloYaw-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:anguloYaw-val is deprecated.  Use comunicacion_serial-msg:anguloYaw instead.")
  (anguloYaw m))

(cl:ensure-generic-function 'velocidadPitch-val :lambda-list '(m))
(cl:defmethod velocidadPitch-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:velocidadPitch-val is deprecated.  Use comunicacion_serial-msg:velocidadPitch instead.")
  (velocidadPitch m))

(cl:ensure-generic-function 'velocidadRoll-val :lambda-list '(m))
(cl:defmethod velocidadRoll-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:velocidadRoll-val is deprecated.  Use comunicacion_serial-msg:velocidadRoll instead.")
  (velocidadRoll m))

(cl:ensure-generic-function 'velocidadYaw-val :lambda-list '(m))
(cl:defmethod velocidadYaw-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:velocidadYaw-val is deprecated.  Use comunicacion_serial-msg:velocidadYaw instead.")
  (velocidadYaw m))

(cl:ensure-generic-function 'altura-val :lambda-list '(m))
(cl:defmethod altura-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:altura-val is deprecated.  Use comunicacion_serial-msg:altura instead.")
  (altura m))

(cl:ensure-generic-function 'encendido-val :lambda-list '(m))
(cl:defmethod encendido-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:encendido-val is deprecated.  Use comunicacion_serial-msg:encendido instead.")
  (encendido m))

(cl:ensure-generic-function 'mensajesRecibidos-val :lambda-list '(m))
(cl:defmethod mensajesRecibidos-val ((m <EstadoCuadricoptero>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:mensajesRecibidos-val is deprecated.  Use comunicacion_serial-msg:mensajesRecibidos instead.")
  (mensajesRecibidos m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <EstadoCuadricoptero>) ostream)
  "Serializes a message object of type '<EstadoCuadricoptero>"
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'tiempoEjecucion)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'tiempoEjecucion) (cl:floor (cl:slot-value msg 'tiempoEjecucion)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let* ((signed (cl:slot-value msg 'anguloPitch)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'anguloRoll)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'anguloYaw)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'velocidadPitch)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'velocidadRoll)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'velocidadYaw)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'altura)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'encendido)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'mensajesRecibidos)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 18446744073709551616) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <EstadoCuadricoptero>) istream)
  "Deserializes a message object of type '<EstadoCuadricoptero>"
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tiempoEjecucion) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'anguloPitch) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'anguloRoll) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'anguloYaw) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'velocidadPitch) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'velocidadRoll) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'velocidadYaw) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'altura) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'encendido) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mensajesRecibidos) (cl:if (cl:< unsigned 9223372036854775808) unsigned (cl:- unsigned 18446744073709551616))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<EstadoCuadricoptero>)))
  "Returns string type for a message object of type '<EstadoCuadricoptero>"
  "comunicacion_serial/EstadoCuadricoptero")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'EstadoCuadricoptero)))
  "Returns string type for a message object of type 'EstadoCuadricoptero"
  "comunicacion_serial/EstadoCuadricoptero")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<EstadoCuadricoptero>)))
  "Returns md5sum for a message object of type '<EstadoCuadricoptero>"
  "a177d60ff9bc3445dc3d8bf718819b39")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'EstadoCuadricoptero)))
  "Returns md5sum for a message object of type 'EstadoCuadricoptero"
  "a177d60ff9bc3445dc3d8bf718819b39")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<EstadoCuadricoptero>)))
  "Returns full string definition for message of type '<EstadoCuadricoptero>"
  (cl:format cl:nil "time tiempoEjecucion~%int32 anguloPitch~%int32 anguloRoll~%int32 anguloYaw~%int32 velocidadPitch~%int32 velocidadRoll~%int32 velocidadYaw~%int32 altura~%int32 encendido~%int64 mensajesRecibidos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'EstadoCuadricoptero)))
  "Returns full string definition for message of type 'EstadoCuadricoptero"
  (cl:format cl:nil "time tiempoEjecucion~%int32 anguloPitch~%int32 anguloRoll~%int32 anguloYaw~%int32 velocidadPitch~%int32 velocidadRoll~%int32 velocidadYaw~%int32 altura~%int32 encendido~%int64 mensajesRecibidos~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <EstadoCuadricoptero>))
  (cl:+ 0
     8
     4
     4
     4
     4
     4
     4
     4
     4
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <EstadoCuadricoptero>))
  "Converts a ROS message object to a list"
  (cl:list 'EstadoCuadricoptero
    (cl:cons ':tiempoEjecucion (tiempoEjecucion msg))
    (cl:cons ':anguloPitch (anguloPitch msg))
    (cl:cons ':anguloRoll (anguloRoll msg))
    (cl:cons ':anguloYaw (anguloYaw msg))
    (cl:cons ':velocidadPitch (velocidadPitch msg))
    (cl:cons ':velocidadRoll (velocidadRoll msg))
    (cl:cons ':velocidadYaw (velocidadYaw msg))
    (cl:cons ':altura (altura msg))
    (cl:cons ':encendido (encendido msg))
    (cl:cons ':mensajesRecibidos (mensajesRecibidos msg))
))
