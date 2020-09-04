#!/usr/bin/env python
# -*- coding: utf-8 -*


import  sys
import rospy
import serial

reload(sys)
sys.setdefaultencoding('utf-8')

ser = serial.Serial('COM0', 38400)
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
    
    
if __name__ == '__main__':  
    print "Reading from keyboard"
    print "Use WASD keys to control the robot"
    print "Press j to stop"
    print "Press q  to quit"
    