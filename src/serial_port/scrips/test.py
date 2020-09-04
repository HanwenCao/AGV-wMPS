#!/usr/bin/env python
# -*- coding: utf-8 -*


import  sys
import  tty, termios
import roslib; roslib.load_manifest('serial_port')
import rospy
import serial
import rospy  
import tf.transformations  
from geometry_msgs.msg import Twist  
from std_msgs.msg import String

reload(sys)
sys.setdefaultencoding('utf-8')

ser = serial.Serial('/dev/ttyUSB1', 38400)
#ser = serial.Serial('/dev/ttyS1', 38400)
print ser.name
print ser.port
print ser.isOpen()

def send(m_sspeed_x,m_sspeed_y,m_sspeed_w):
    checksum = 0x00
    m_state = 0x11
    m_Estop = 0x00
    m_cinstruction=[0,0,0, 0,0,0, 0,0,0, 0,0,0]
    m_cinstruction[0] = 0x02

       
    if m_sspeed_x<0:
        m_sspeed_x = 65536+m_sspeed_x
    m_cinstruction[1:3] = divmod(m_sspeed_x,256)


    if m_sspeed_y<0:
        m_sspeed_y = 65536+m_sspeed_y
    m_cinstruction[3:5] = divmod(m_sspeed_y,256)
        
    if m_sspeed_w<0:
        m_sspeed_w = 65536+m_sspeed_w
    m_cinstruction[5:7] = divmod(m_sspeed_w,256)

    m_cinstruction[7] = m_state#0待机；1行走
    m_cinstruction[8] = m_Estop#0正常；1急停
    m_cinstruction[9] = 0x55#上位机操作；AA遥控器操作
    for i in range(0,10):
        checksum ^= m_cinstruction[i]
    m_cinstruction[10] = checksum
    m_cinstruction[11] =0x03
#    print m_cinstruction
    return m_cinstruction
      
def callback(msg):
    #rospy.loginfo("Received a /cmd_vel message!")  
    rospy.loginfo("Linear: [%f, %f, %f]"%(msg.linear.x, msg.linear.y, msg.linear.z))  
    rospy.loginfo("Angular: [%f, %f, %f]"%(msg.angular.x, msg.angular.y, msg.angular.z))  
    if msg.angular.z >= 0.5:
        msg.angular.z = 0.5  # max rotational velocity limit
    cmd_twist_rotation =  int(1000*msg.angular.z ) #
    cmd_twist_y = -int(1000*msg.linear.x )   # change x to y
    cmd_twist_x = int(1000*msg.linear.y )   # front<-->end

    date = send(cmd_twist_x, cmd_twist_y, cmd_twist_rotation)
    #print "data:", date
    cmd  = "%c" * 12 % (date[0],date[1],date[2],date[3],date[4], date[5],date[6],date[7],date[8],date[9], date[10],date[11])
    #print "write:", cmd
    ser.write(cmd)


      
      
def listener():  
    rospy.init_node('cmd_vel_listener')  
    rospy.Subscriber("/cmd_vel", Twist, callback)#/cmd_vel  
    rospy.spin()  
          
if __name__ == '__main__':  
    listener()  
