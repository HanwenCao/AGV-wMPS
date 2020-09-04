;; Auto-generated. Do not edit!


(when (boundp 'serial_port::Num)
  (if (not (find-package "SERIAL_PORT"))
    (make-package "SERIAL_PORT"))
  (shadow 'Num (find-package "SERIAL_PORT")))
(unless (find-package "SERIAL_PORT::NUM")
  (make-package "SERIAL_PORT::NUM"))

(in-package "ROS")
;;//! \htmlinclude Num.msg.html


(defclass serial_port::Num
  :super ros::object
  :slots (_leftspeed _rightspeed ))

(defmethod serial_port::Num
  (:init
   (&key
    ((:leftspeed __leftspeed) 0.0)
    ((:rightspeed __rightspeed) 0.0)
    )
   (send-super :init)
   (setq _leftspeed (float __leftspeed))
   (setq _rightspeed (float __rightspeed))
   self)
  (:leftspeed
   (&optional __leftspeed)
   (if __leftspeed (setq _leftspeed __leftspeed)) _leftspeed)
  (:rightspeed
   (&optional __rightspeed)
   (if __rightspeed (setq _rightspeed __rightspeed)) _rightspeed)
  (:serialization-length
   ()
   (+
    ;; float32 _leftspeed
    4
    ;; float32 _rightspeed
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _leftspeed
       (sys::poke _leftspeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rightspeed
       (sys::poke _rightspeed (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _leftspeed
     (setq _leftspeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rightspeed
     (setq _rightspeed (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get serial_port::Num :md5sum-) "8b290d1f063538827f22923db0bccdbf")
(setf (get serial_port::Num :datatype-) "serial_port/Num")
(setf (get serial_port::Num :definition-)
      "float32 leftspeed  
float32 rightspeed

")



(provide :serial_port/Num "8b290d1f063538827f22923db0bccdbf")


