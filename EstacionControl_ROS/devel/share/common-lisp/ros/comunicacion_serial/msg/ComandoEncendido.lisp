; Auto-generated. Do not edit!


(cl:in-package comunicacion_serial-msg)


;//! \htmlinclude ComandoEncendido.msg.html

(cl:defclass <ComandoEncendido> (roslisp-msg-protocol:ros-message)
  ((encendido
    :reader encendido
    :initarg :encendido
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ComandoEncendido (<ComandoEncendido>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ComandoEncendido>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ComandoEncendido)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name comunicacion_serial-msg:<ComandoEncendido> is deprecated: use comunicacion_serial-msg:ComandoEncendido instead.")))

(cl:ensure-generic-function 'encendido-val :lambda-list '(m))
(cl:defmethod encendido-val ((m <ComandoEncendido>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader comunicacion_serial-msg:encendido-val is deprecated.  Use comunicacion_serial-msg:encendido instead.")
  (encendido m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ComandoEncendido>) ostream)
  "Serializes a message object of type '<ComandoEncendido>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'encendido)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ComandoEncendido>) istream)
  "Deserializes a message object of type '<ComandoEncendido>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'encendido)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ComandoEncendido>)))
  "Returns string type for a message object of type '<ComandoEncendido>"
  "comunicacion_serial/ComandoEncendido")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ComandoEncendido)))
  "Returns string type for a message object of type 'ComandoEncendido"
  "comunicacion_serial/ComandoEncendido")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ComandoEncendido>)))
  "Returns md5sum for a message object of type '<ComandoEncendido>"
  "ca1bb7756711dc79b7b20ec735aada07")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ComandoEncendido)))
  "Returns md5sum for a message object of type 'ComandoEncendido"
  "ca1bb7756711dc79b7b20ec735aada07")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ComandoEncendido>)))
  "Returns full string definition for message of type '<ComandoEncendido>"
  (cl:format cl:nil "uint8 encendido~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ComandoEncendido)))
  "Returns full string definition for message of type 'ComandoEncendido"
  (cl:format cl:nil "uint8 encendido~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ComandoEncendido>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ComandoEncendido>))
  "Converts a ROS message object to a list"
  (cl:list 'ComandoEncendido
    (cl:cons ':encendido (encendido msg))
))
