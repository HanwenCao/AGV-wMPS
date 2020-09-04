;; Auto-generated. Do not edit!


(when (boundp 'serial_port::carOdom)
  (if (not (find-package "SERIAL_PORT"))
    (make-package "SERIAL_PORT"))
  (shadow 'carOdom (find-package "SERIAL_PORT")))
(unless (find-package "SERIAL_PORT::CARODOM")
  (make-package "SERIAL_PORT::CARODOM"))

(in-package "ROS")
;;//! \htmlinclude carOdom.msg.html


(defclass serial_port::carOdom
  :super ros::object
  :slots (_x _y _vth ))

(defmethod serial_port::carOdom
  (:init
   (&key
    ((:x __x) 0.0)
    ((:y __y) 0.0)
    ((:vth __vth) 0.0)
    )
   (send-super :init)
   (setq _x (float __x))
   (setq _y (float __y))
   (setq _vth (float __vth))
   self)
  (:x
   (&optional __x)
   (if __x (setq _x __x)) _x)
  (:y
   (&optional __y)
   (if __y (setq _y __y)) _y)
  (:vth
   (&optional __vth)
   (if __vth (setq _vth __vth)) _vth)
  (:serialization-length
   ()
   (+
    ;; float32 _x
    4
    ;; float32 _y
    4
    ;; float32 _vth
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _x
       (sys::poke _x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _y
       (sys::poke _y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _vth
       (sys::poke _vth (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _x
     (setq _x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _y
     (setq _y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _vth
     (setq _vth (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get serial_port::carOdom :md5sum-) "c27a3de3b8c404eb1207e1eec3c23325")
(setf (get serial_port::carOdom :datatype-) "serial_port/carOdom")
(setf (get serial_port::carOdom :definition-)
      "float32 x  
float32 y  
float32 vth

")



(provide :serial_port/carOdom "c27a3de3b8c404eb1207e1eec3c23325")


