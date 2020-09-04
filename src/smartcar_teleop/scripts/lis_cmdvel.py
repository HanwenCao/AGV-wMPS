#!/usr/bin/env python
#coding:utf-8
import binascii
#refernence: http://answers.ros.org/question/29706/twist-message-example-and-cmd_vel/
import roslib; roslib.load_manifest('smartcar_teleop')
import rospy
import tf.transformations
import  os
import  sys
import  tty, termios
import rospy
import string
from geometry_msgs.msg import Twist
from std_msgs.msg import String
import serial
import numpy

#ser = serial.Serial('/dev/ttyUSB0' ,38400)
#print ser.name
#print ser.port
#print ser.isOpen()
m_cinstruction=[0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
checksum = 0x00
m_state = 0x11
m_Estop=0x00 
m_sspeed_x=0x00
m_sspeed_y=0x00
m_sspeed_w=0x00



def send():
#    #+
    global m_cinstruction, checksum, m_state, m_Estop, m_sspeed_x, m_sspeed_y, m_sspeed_w
    m_cinstruction[0] = 0x02

    m_cinstruction[4] = numpy.uint8(m_sspeed_x)
    m_cinstruction[3] = numpy.uint8(m_sspeed_x>>8)

        

    m_cinstruction[2] = numpy.uint8(m_sspeed_y)
    m_cinstruction[1] = numpy.uint8(m_sspeed_y>>8)

        
    m_cinstruction[6] = numpy.uint8(m_sspeed_w)
    m_cinstruction[5] = numpy.uint8(m_sspeed_w>>8)

    m_cinstruction[7] = m_state
    m_cinstruction[8] = m_Estop
    m_cinstruction[9] = 0x55
    checksum = m_cinstruction[0]
    for i in range (1, 10):
        checksum ^= m_cinstruction[i]
    m_cinstruction[10] = checksum
    m_cinstruction[11] =0x03   
    print m_cinstruction
    res=''
    for v in m_cinstruction:
        res=res+chr(v)
    return res
    
def callback(msg):
    rospy.loginfo("Received a /cmd_vel message!")
    rospy.loginfo("Linear Components: [%f, %f, %f]"%(msg.linear.x, msg.linear.y, msg.linear.z))
    rospy.loginfo("Angular Components: [%f, %f, %f]"%(msg.angular.x, msg.angular.y, msg.angular.z))
    global m_Estop, m_sspeed_x, m_sspeed_y, m_sspeed_w
    
    linear_vel_ = rospy.get_param('linear_vel_', 100)

    # Do velocity processing here:
    # Use the kinematics of your robot to map linear and angular velocities into motor commands
    m_sspeed_x = int(msg.linear.x*linear_vel_)
    m_sspeed_y = int(msg.linear.y*linear_vel_)
    m_sspeed_w = int(msg.angular.z*linear_vel_)
    m_Estop = 0x00
    if abs(m_sspeed_x)>200:
        if m_sspeed_x>0:
            m_sspeed_x=200
        else:
            m_sspeed_x=-200
    if abs(m_sspeed_y)>200:
        if m_sspeed_y>0:
            m_sspeed_y=200
        else:
            m_sspeed_y=-200
    if abs(m_sspeed_w)>200:
        if m_sspeed_w>0:
            m_sspeed_w=200
        else:
            m_sspeed_w=-200
    data=send()            
    #ser.write(data)
    #print '\x02\x00\x64\x00\x00\x00\x00\x11\x00\x55\x22\x03'
    #print data
    #print type(data)
    
    # Then set your wheel speeds (using wheel_left and wheel_right as examples)
#    wheel_left.set_speed(v_l)
#    wheel_right.set_speed(v_r)
 
def listener():
    rospy.init_node('cmd_vel_listener')
    rospy.Subscriber("/cmd_vel", Twist, callback)#/cmd_vel
    rospy.spin()
    
if __name__ == '__main__':
    listener()
