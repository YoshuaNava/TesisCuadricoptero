; Auto-generated. Do not edit!


(cl:in-package exportador_estado_csv-msg)


;//! \htmlinclude ComandoMovimiento.msg.html

(cl:defclass <ComandoMovimiento> (roslisp-msg-protocol:ros-message)
  ((comandoPitch
    :reader comandoPitch
    :initarg :comandoPitch
    :type cl:fixnum
    :initform 0)
   (comandoRoll
    :reader comandoRoll
    :initarg :comandoRoll
    :type cl:fixnum
    :initform 0)
   (comandoAltura
    :reader comandoAltura
    :initarg :comandoAltura
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ComandoMovimiento (<ComandoMovimiento>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ComandoMovimiento>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ComandoMovimiento)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name exportador_estado_csv-msg:<ComandoMovimiento> is deprecated: use exportador_estado_csv-msg:ComandoMovimiento instead.")))

(cl:ensure-generic-function 'comandoPitch-val :lambda-list '(m))
(cl:defmethod comandoPitch-val ((m <ComandoMovimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exportador_estado_csv-msg:comandoPitch-val is deprecated.  Use exportador_estado_csv-msg:comandoPitch instead.")
  (comandoPitch m))

(cl:ensure-generic-function 'comandoRoll-val :lambda-list '(m))
(cl:defmethod comandoRoll-val ((m <ComandoMovimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exportador_estado_csv-msg:comandoRoll-val is deprecated.  Use exportador_estado_csv-msg:comandoRoll instead.")
  (comandoRoll m))

(cl:ensure-generic-function 'comandoAltura-val :lambda-list '(m))
(cl:defmethod comandoAltura-val ((m <ComandoMovimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader exportador_estado_csv-msg:comandoAltura-val is deprecated.  Use exportador_estado_csv-msg:comandoAltura instead.")
  (comandoAltura m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ComandoMovimiento>) ostream)
  "Serializes a message object of type '<ComandoMovimiento>"
  (cl:let* ((signed (cl:slot-value msg 'comandoPitch)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'comandoRoll)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'comandoAltura)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ComandoMovimiento>) istream)
  "Deserializes a message object of type '<ComandoMovimiento>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'comandoPitch) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'comandoRoll) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'comandoAltura) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ComandoMovimiento>)))
  "Returns string type for a message object of type '<ComandoMovimiento>"
  "exportador_estado_csv/ComandoMovimiento")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ComandoMovimiento)))
  "Returns string type for a message object of type 'ComandoMovimiento"
  "exportador_estado_csv/ComandoMovimiento")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ComandoMovimiento>)))
  "Returns md5sum for a message object of type '<ComandoMovimiento>"
  "b4b940224c0de969ca5cc85632c6b706")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ComandoMovimiento)))
  "Returns md5sum for a message object of type 'ComandoMovimiento"
  "b4b940224c0de969ca5cc85632c6b706")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ComandoMovimiento>)))
  "Returns full string definition for message of type '<ComandoMovimiento>"
  (cl:format cl:nil "int16 comandoPitch~%int16 comandoRoll~%int16 comandoAltura~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ComandoMovimiento)))
  "Returns full string definition for message of type 'ComandoMovimiento"
  (cl:format cl:nil "int16 comandoPitch~%int16 comandoRoll~%int16 comandoAltura~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ComandoMovimiento>))
  (cl:+ 0
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ComandoMovimiento>))
  "Converts a ROS message object to a list"
  (cl:list 'ComandoMovimiento
    (cl:cons ':comandoPitch (comandoPitch msg))
    (cl:cons ':comandoRoll (comandoRoll msg))
    (cl:cons ':comandoAltura (comandoAltura msg))
))
