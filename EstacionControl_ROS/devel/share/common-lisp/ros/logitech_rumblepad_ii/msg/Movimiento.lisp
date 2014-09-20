; Auto-generated. Do not edit!


(cl:in-package logitech_rumblepad_ii-msg)


;//! \htmlinclude Movimiento.msg.html

(cl:defclass <Movimiento> (roslisp-msg-protocol:ros-message)
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

(cl:defclass Movimiento (<Movimiento>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Movimiento>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Movimiento)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name logitech_rumblepad_ii-msg:<Movimiento> is deprecated: use logitech_rumblepad_ii-msg:Movimiento instead.")))

(cl:ensure-generic-function 'comandoPitch-val :lambda-list '(m))
(cl:defmethod comandoPitch-val ((m <Movimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader logitech_rumblepad_ii-msg:comandoPitch-val is deprecated.  Use logitech_rumblepad_ii-msg:comandoPitch instead.")
  (comandoPitch m))

(cl:ensure-generic-function 'comandoRoll-val :lambda-list '(m))
(cl:defmethod comandoRoll-val ((m <Movimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader logitech_rumblepad_ii-msg:comandoRoll-val is deprecated.  Use logitech_rumblepad_ii-msg:comandoRoll instead.")
  (comandoRoll m))

(cl:ensure-generic-function 'comandoAltura-val :lambda-list '(m))
(cl:defmethod comandoAltura-val ((m <Movimiento>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader logitech_rumblepad_ii-msg:comandoAltura-val is deprecated.  Use logitech_rumblepad_ii-msg:comandoAltura instead.")
  (comandoAltura m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Movimiento>) ostream)
  "Serializes a message object of type '<Movimiento>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoPitch)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoRoll)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoAltura)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Movimiento>) istream)
  "Deserializes a message object of type '<Movimiento>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoPitch)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoRoll)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'comandoAltura)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Movimiento>)))
  "Returns string type for a message object of type '<Movimiento>"
  "logitech_rumblepad_ii/Movimiento")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Movimiento)))
  "Returns string type for a message object of type 'Movimiento"
  "logitech_rumblepad_ii/Movimiento")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Movimiento>)))
  "Returns md5sum for a message object of type '<Movimiento>"
  "53314ded530e1fa3e52a9cb10b19fe06")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Movimiento)))
  "Returns md5sum for a message object of type 'Movimiento"
  "53314ded530e1fa3e52a9cb10b19fe06")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Movimiento>)))
  "Returns full string definition for message of type '<Movimiento>"
  (cl:format cl:nil "uint8 comandoPitch~%uint8 comandoRoll~%uint8 comandoAltura~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Movimiento)))
  "Returns full string definition for message of type 'Movimiento"
  (cl:format cl:nil "uint8 comandoPitch~%uint8 comandoRoll~%uint8 comandoAltura~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Movimiento>))
  (cl:+ 0
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Movimiento>))
  "Converts a ROS message object to a list"
  (cl:list 'Movimiento
    (cl:cons ':comandoPitch (comandoPitch msg))
    (cl:cons ':comandoRoll (comandoRoll msg))
    (cl:cons ':comandoAltura (comandoAltura msg))
))
