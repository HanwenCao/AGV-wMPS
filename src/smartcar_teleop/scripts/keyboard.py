#!/usr/bin/env python
# -*- coding: utf-8 -*

import  os
import  sys
import  tty, termios
import roslib; roslib.load_manifest('smartcar_teleop')
import rospy
from geometry_msgs.msg import Twist
from std_msgs.msg import String
import serial

# 全局变量
cmd = Twist()
pub = rospy.Publisher('cmd_vel', Twist)
#+
#ser = serial.Serial(2 ,38400)
#print ser.name
#print ser.port
#print ser.isOpen()

#m_cinstruction=[0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00]
#checksum = 0x00
#m_state = 0x11
#m_Estop=0x00 
#m_sspeed_x=0x00
#m_sspeed_y=0x00
#m_sspeed_w=0x00
#
#def send():
#    #+
#    global m_cinstruction, checksum, m_state, m_Estop, m_sspeed_x, m_sspeed_y, m_sspeed_w
#    m_cinstruction[0] = 0x02
#
#    m_cinstruction[2] = m_sspeed_x
#    m_cinstruction[1] = m_sspeed_x>>8
#
#    m_cinstruction[4] = m_sspeed_y
#    m_cinstruction[3] = m_sspeed_y>>8
#
#    m_cinstruction[6] = m_sspeed_w
#    m_cinstruction[5] = m_sspeed_w>>8
#
#    m_cinstruction[7] = m_state
#    m_cinstruction[8] = m_Estop
#    m_cinstruction[9] = 0x55
##    for i in range (0, 10):
##        checksum ^= m_cinstruction[i];
##        m_cinstruction[10] = checksum;
#    m_cinstruction[10] =0x0d
#    m_cinstruction[11] =0x03    
#    return m_cinstruction
    
def keyboardLoop():
    #初始化
    rospy.init_node('smartcar_teleop')
    rate = rospy.Rate(rospy.get_param('~hz', 1))
    

    #速度变量
    walk_vel_ = rospy.get_param('walk_vel', 0.01)
    run_vel_ = rospy.get_param('run_vel', 0.1)
    yaw_rate_ = rospy.get_param('yaw_rate', 0.02)
    yaw_rate_run_ = rospy.get_param('yaw_rate_run', 0.1)

    max_tv = walk_vel_
    max_rv = yaw_rate_
    
    #+
    global m_Estop, m_sspeed_x, m_sspeed_y, m_sspeed_w
    

    #显示提示信息
    print "Reading from keyboard"
    print "Use WASD keys to control the robot"
    print "Press Caps to move faster"
    print "Press j to stop"
    print "Press q to quit"

    #读取按键循环
    while not rospy.is_shutdown():
        fd = sys.stdin.fileno()
        old_settings = termios.tcgetattr(fd)
		#不产生回显效果
        old_settings[3] = old_settings[3] & ~termios.ICANON & ~termios.ECHO
        try :
            tty.setraw( fd )
            ch = sys.stdin.read( 1 )
        finally :
            termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)

        if ch == 'w':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 100
#            m_sspeed_w = 0
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            
            max_tv = walk_vel_
            speed_x = 1
            speed_y = 0
            turn = 0
        elif ch == 's':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y =-100
#            m_sspeed_w = 0
#            m_Estop = 0x00
#            date=send()            
            #ser.write(date)
#            print date
            
            max_tv = walk_vel_
            speed_x = -1
            speed_y = 0
            turn = 0
        elif ch == 'a':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 0
#            m_sspeed_w =50
#            m_Estop = 0x00
#            date=send()            
#           # ser.write(date)
#            print date
            
            max_rv = yaw_rate_
            speed_x = 0
            speed_y = 0
            turn = 1
        elif ch == 'd':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 0
#            m_sspeed_w =-50
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            
            max_rv = yaw_rate_
            speed_x = 0
            speed_y = 0
            turn = -1
        elif ch == 'W':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 200
#            m_sspeed_w =0
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            
            max_tv = run_vel_
            speed_x = 1
            speed_y = 0
            turn = 0
        elif ch == 'S':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = -200
#            m_sspeed_w =0
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            max_tv = run_vel_
            speed_x = -1
            speed_y = 0
            turn = 0
        elif ch == 'A':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 0
#            m_sspeed_w =100
#            m_Estop = 0x00
#            date=send()            
#           # ser.write(date)
#            print date
            
            max_rv = yaw_rate_run_
            speed_x = 0
            speed_y = 0
            turn = 1
        
        elif ch == 'D':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 0
#            m_sspeed_w =-100
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            
            max_rv = yaw_rate_run_
            speed_x = 0
            speed_y = 0
            turn = -1
        elif ch == 'j':
            #+
#            m_sspeed_x = 0
#            m_sspeed_y = 0
#            m_sspeed_w =-100
#            m_Estop = 0x00
#            date=send()            
#            #ser.write(date)
#            print date
            
            max_rv = yaw_rate_
            speed_x = 0
            speed_y = 0
            turn = 0
        
#        elif ch == 'q':
#            #+
##            m_sspeed_x = 0
##            m_sspeed_y = 0
##            m_sspeed_w =-100
##            m_Estop = 0x00
##            date=send()            
##            #ser.write(date)
##            print date
#            
#            max_rv = yaw_rate_
#            speed_x = 0
#            speed_y = 0
#            turn = 1
#        
#        elif ch == 'e':
#            #+
##            m_sspeed_x = 0
##            m_sspeed_y = 0
##            m_sspeed_w =-100
##            m_Estop = 0x00
##            date=send()            
##            #ser.write(date)
##            print date
#            
#            max_rv = yaw_rate_
#            speed_x = 0
#            speed_y = 0
#            turn = -1
#        
#        elif ch == 'Q':
#            #+
##            m_sspeed_x = 0
##            m_sspeed_y = 0
##            m_sspeed_w =-100
##            m_Estop = 0x00
##            date=send()            
##            #ser.write(date)
##            print date
#            
#            max_rv = yaw_rate_run_
#            speed_x = 0
#            speed_y = 0
#            turn = 1
#            
#        elif ch == 'E':
#            #+
##            m_sspeed_x = 0
##            m_sspeed_y = 0
##            m_sspeed_w =-100
##            m_Estop = 0x00
##            date=send()            
##            #ser.write(date)
##            print date
#            
#            max_rv = yaw_rate_
#            speed_x = 0
#            speed_y = 0
#            turn = -1
        elif ch == 'q':
            exit()
        else:
            max_tv = walk_vel_
            max_rv = yaw_rate_
            speed_x = 0
            speed_y = 0
            turn = 0

        #发送消息
        cmd.linear.x = speed_x * max_tv;
        cmd.linear.y = speed_y *max_tv;
        cmd.angular.z = turn * max_rv;
        pub.publish(cmd)
        rate.sleep()
		#停止机器人
        stop_robot();

def stop_robot():
    cmd.linear.x = 0.0
    cmd.angular.z = 0.0
    pub.publish(cmd)

if __name__ == '__main__':
    try:
        keyboardLoop()
    except rospy.ROSInterruptException:
        pass
