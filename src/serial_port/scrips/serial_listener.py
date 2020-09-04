#!/usr/bin/env python
# -*- coding: utf-8 -*
# Software License Agreement (BSD License)
#
# Copyright (c) 2008, Willow Garage, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  * Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#  * Redistributions in binary form must reproduce the above
#    copyright notice, this list of conditions and the following
#    disclaimer in the documentation and/or other materials provided
#    with the distribution.
#  * Neither the name of Willow Garage, Inc. nor the names of its
#    contributors may be used to endorse or promote products derived
#    from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
# LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# Revision $Id$

## Simple talker demo that listens to std_msgs/Strings published 
## to the 'chatter' topic

import  sys
import  tty, termios
import roslib; roslib.load_manifest('smartcar_teleop')
import rospy
from std_msgs.msg import String
import serial

reload(sys)
sys.setdefaultencoding('utf-8')

ser = serial.Serial('ttyUSB0', 38400)
print ser.name
#print ser.port
print ser.isOpen()



checksum = 0x00
m_state = 0x11
str_input=0
m_sspeed_x=0
m_sspeed_y=0
m_sspeed_w=0
m_state=0x11
m_Estop=0x00
m_cinstruction=[0,0,0, 0,0,0, 0,0,0, 0,0,0]

def callback(data):
    global str_input
#    rospy.loginfo(data.data)
    
    str_input = data.data
#    print str_input
    return str_input
    
    
def send():
    checksum = 0x00
    global m_cinstruction, checksum, m_state, m_Estop, m_sspeed_x, m_sspeed_y, m_sspeed_w
    m_cinstruction[0] = 0x23

       
    if m_sspeed_x<0:
        m_cinstruction[1] = 255
        m_cinstruction[2] = m_sspeed_x+256
    else: 
        m_cinstruction[1] = 0
        m_cinstruction[2] = m_sspeed_x

    if m_sspeed_y<0:
        m_cinstruction[3] = 255
        m_cinstruction[4] = m_sspeed_y+256
    else: 
        m_cinstruction[3] = 0
        m_cinstruction[4] = m_sspeed_y
        
    if m_sspeed_w<0:
        m_cinstruction[5] = 255
        m_cinstruction[6] = m_sspeed_w+256
    else: 
        m_cinstruction[5] = 0
        m_cinstruction[6] = m_sspeed_w

    m_cinstruction[7] = m_state
    m_cinstruction[8] = m_Estop
    m_cinstruction[9] = 0x55
    for i in range(0,10):
        checksum ^= m_cinstruction[i]
        m_cinstruction[10] = checksum
#    m_cinstruction[10] =0x0d
    m_cinstruction[11] =0x03
#    print m_cinstruction
    return m_cinstruction
    

def serial_listener():

    # In ROS, nodes are uniquely named. If two nodes with the same
    # name are launched, the previous one is kicked off. The
    # anonymous=True flag means that rospy will choose a unique
    # name for our 'listener' node so that multiple listeners can
    # run simultaneously.
    global m_sspeed_x, m_sspeed_y, m_sspeed_w,m_Estop,str_input        
    rospy.init_node('serial_listener', anonymous=True)
    rate = rospy.Rate(rospy.get_param('~hz', 1))
    
    while not rospy.is_shutdown():
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
    		#not back show
        old_settings[3] = old_settings[3] & ~termios.ICANON & ~termios.ECHO
        try :
            tty.setraw( fd )
            rospy.Subscriber('chatter', String, callback)
        finally :
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
            
        
        
        if str_input:
            if str_input=='w':
                m_sspeed_x = 0
                m_sspeed_y = 200
                m_sspeed_w = 0
                m_Estop = 0x00
                cmd=send()
    #            print cmd
        #            str_date='11-100'
                cmd  = "%c" * 12 % (cmd[0],cmd[1],cmd[2],cmd[3],cmd[4], cmd[5],cmd[6],cmd[7],cmd[8],cmd[9], cmd[10],cmd[11])
        #            str_date=str_date.decode('hex')
        #            ser.write(str_date)
                ser.write(cmd)
                print cmd
        
               
            elif str_input=='s':
                m_sspeed_x = 0
                m_sspeed_y = -200
                m_sspeed_w = 0
                m_Estop = 0x00
                cmd =send()
                
                cmd  = "%c" * 12 % (cmd[0],cmd[1],cmd[2],cmd[3],cmd[4], cmd[5],cmd[6],cmd[7],cmd[8],cmd[9], cmd[10],cmd[11])
        #            ser.write(cmd)
                print cmd
         
            elif str_input=='a':
                m_sspeed_x = -200
                m_sspeed_y = 0
                m_sspeed_w = 0
                m_Estop = 0x00
                cmd =send()
                
                cmd  = "%c" * 12 % (cmd[0],cmd[1],cmd[2],cmd[3],cmd[4], cmd[5],cmd[6],cmd[7],cmd[8],cmd[9], cmd[10],cmd[11])
                
                ser.write(cmd)
                print cmd
                
            elif str_input=='d':
                m_sspeed_x = 200
                m_sspeed_y = 0
                m_sspeed_w = 0
                m_Estop = 0x00
                cmd =send()
                
                cmd  = "%c" * 12 % (cmd[0],cmd[1],cmd[2],cmd[3],cmd[4], cmd[5],cmd[6],cmd[7],cmd[8],cmd[9], cmd[10],cmd[11])
                
                ser.write(cmd)
                print cmd
               
            elif str_input=='j':
                m_sspeed_x = 0
                m_sspeed_y = 0
                m_sspeed_w = 0
                m_Estop = 0x00
                cmd =send()
                
                cmd  = "%c" * 12 % (cmd[0],cmd[1],cmd[2],cmd[3],cmd[4], cmd[5],cmd[6],cmd[7],cmd[8],cmd[9], cmd[10],cmd[11])
                
                ser.write(cmd)
                print cmd
                
                
            elif str_input == 'q':
                exit()
                
                
            else:
                print("choose from w a s d j")
            str_input=0
        rate.sleep()


    # spin() simply keeps python from exiting until this node is stopped
#    rospy.spin()

if __name__ == '__main__':       
    try:
        serial_listener()
    except rospy.ROSInterruptException:
        pass

       