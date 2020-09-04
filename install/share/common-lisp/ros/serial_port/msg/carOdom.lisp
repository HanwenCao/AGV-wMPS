; Auto-generated. Do not edit!


(cl:in-package serial_port-msg)


;//! \htmlinclude carOdom.msg.html

(cl:defclass <carOdom> (roslisp-msg-protocol:ros-message)
  ((x
    :reader x
    :initarg :x
    :type cl:float
    :initform 0.0)
   (y
    :reader y
    :initarg :y
    :type cl:float
    :initform 0.0)
   (vth
    :reader vth
    :initarg :vth
    :type cl:float
    :initform 0.0))
)

(cl:defclass carOdom (<carOdom>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <carOdom>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'carOdom)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name serial_port-msg:<carOdom> is deprecated: use serial_port-msg:carOdom instead.")))

(cl:ensure-generic-function 'x-val :lambda-list '(m))
(cl:defmethod x-val ((m <carOdom>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial_port-msg:x-val is deprecated.  Use serial_port-msg:x instead.")
  (x m))

(cl:ensure-generic-function 'y-val :lambda-list '(m))
(cl:defmethod y-val ((m <carOdom>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial_port-msg:y-val is deprecated.  Use serial_port-msg:y instead.")
  (y m))

(cl:ensure-generic-function 'vth-val :lambda-list '(m))
(cl:defmethod vth-val ((m <carOdom>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader serial_port-msg:vth-val is deprecated.  Use serial_port-msg:vth instead.")
  (vth m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <carOdom>) ostream)
  "Serializes a message object of type '<carOdom>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'vth))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <carOdom>) istream)
  "Deserializes a message object of type '<carOdom>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'y) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'vth) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<carOdom>)))
  "Returns string type for a message object of type '<carOdom>"
  "serial_port/carOdom")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'carOdom)))
  "Returns string type for a message object of type 'carOdom"
  "serial_port/carOdom")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<carOdom>)))
  "Returns md5sum for a message object of type '<carOdom>"
  "c27a3de3b8c404eb1207e1eec3c23325")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'carOdom)))
  "Returns md5sum for a message object of type 'carOdom"
  "c27a3de3b8c404eb1207e1eec3c23325")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<carOdom>)))
  "Returns full string definition for message of type '<carOdom>"
  (cl:format cl:nil "float32 x  ~%float32 y  ~%float32 vth~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'carOdom)))
  "Returns full string definition for message of type 'carOdom"
  (cl:format cl:nil "float32 x  ~%float32 y  ~%float32 vth~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <carOdom>))
  (cl:+ 0
     4
     4
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <carOdom>))
  "Converts a ROS message object to a list"
  (cl:list 'carOdom
    (cl:cons ':x (x msg))
    (cl:cons ':y (y msg))
    (cl:cons ':vth (vth msg))
))
