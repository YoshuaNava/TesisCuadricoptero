; Auto-generated. Do not edit!


(cl:in-package logitech_rumblepad_ii-msg)


;//! \htmlinclude Encendido.msg.html

(cl:defclass <Encendido> (roslisp-msg-protocol:ros-message)
  ((encendido
    :reader encendido
    :initarg :encendido
    :type cl:fixnum
    :initform 0))
)

(cl:defclass Encendido (<Encendido>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Encendido>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Encendido)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name logitech_rumblepad_ii-msg:<Encendido> is deprecated: use logitech_rumblepad_ii-msg:Encendido instead.")))

(cl:ensure-generic-function 'encendido-val :lambda-list '(m))
(cl:defmethod encendido-val ((m <Encendido>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader logitech_rumblepad_ii-msg:encendido-val is deprecated.  Use logitech_rumblepad_ii-msg:encendido instead.")
  (encendido m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Encendido>) ostream)
  "Serializes a message object of type '<Encendido>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'encendido)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Encendido>) istream)
  "Deserializes a message object of type '<Encendido>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'encendido)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Encendido>)))
  "Returns string type for a message object of type '<Encendido>"
  "logitech_rumblepad_ii/Encendido")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Encendido)))
  "Returns string type for a message object of type 'Encendido"
  "logitech_rumblepad_ii/Encendido")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Encendido>)))
  "Returns md5sum for a message object of type '<Encendido>"
  "ca1bb7756711dc79b7b20ec735aada07")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Encendido)))
  "Returns md5sum for a message object of type 'Encendido"
  "ca1bb7756711dc79b7b20ec735aada07")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Encendido>)))
  "Returns full string definition for message of type '<Encendido>"
  (cl:format cl:nil "uint8 encendido~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Encendido)))
  "Returns full string definition for message of type 'Encendido"
  (cl:format cl:nil "uint8 encendido~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Encendido>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Encendido>))
  "Converts a ROS message object to a list"
  (cl:list 'Encendido
    (cl:cons ':encendido (encendido msg))
))
