#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <iostream>
#include <fstream>
#include <sstream>
#include <string>
#include <vector>
#include <cstdlib>
#include <Eigen/Eigen>
#include <stdlib.h>
#include <Eigen/Geometry>
#include <Eigen/Core>
#include <Eigen/Dense>
#include <math.h>
#include <sensor_msgs/LaserScan.h>
#include <stdio.h>
#include <string.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <unistd.h>
#define DEG2RAD(x) ((x)*M_PI/180.)

using namespace std;
using namespace Eigen;
 
//udp
char * host_name = "127.0.0.1"; // local host
int port = 9889;//9889
float xb(0),yb(0),zb(0),zthb(0);
/*
要点提示:
1. float和unsigned long具有相同的数据结构长度
2. union据类型里的数据存放在相同的物理空间
*/
typedef union
{
	float fdata;
	unsigned long ldata;
}FloatLongType;

/*
将4个字节数据byte[4]转化为浮点数存放在*f中
*/
void Byte_to_Float(float *f, unsigned char byte[])
{
	FloatLongType fl;
	fl.ldata = 0;
	fl.ldata = byte[0];
	fl.ldata = (fl.ldata << 8) | byte[1];
	fl.ldata = (fl.ldata << 8) | byte[2];
	fl.ldata = (fl.ldata << 8) | byte[3];
	*f = fl.fdata;
}

int main(int argc, char** argv){
	ros::init(argc, argv, "odometry_publisher");
  ros::NodeHandle n;
  ros::Publisher odom_pub = n.advertise<nav_msgs::Odometry>("odom", 50);
  //udp
  socklen_t cliaddr_len;
  char recvbuf[256],sendbuf[256];
  int sockfd;
  struct sockaddr_in servaddr,cliaddr;
  struct hostent *shost_name;

   if ((shost_name = gethostbyname(host_name)) == 0) {
    perror("Error resolving local host\n");
    return 0;
  }

  bzero(&servaddr, sizeof(servaddr));
  servaddr.sin_family = AF_INET;
  servaddr.sin_addr.s_addr = htonl(INADDR_ANY);
  servaddr.sin_port = htons(port);
  if ((sockfd = socket(PF_INET, SOCK_DGRAM, 0)) == -1) {
    perror("Error opening socket\n");
    return 0;
  }

  if (bind(sockfd, (struct sockaddr *)&servaddr, sizeof(servaddr)) < 0) {
    perror("call to bind");
  }

  tf::TransformBroadcaster odom_broadcaster;
  float x,y,z,xth,yth,zth;
 

  ros::Time current_time, last_time;
  current_time = ros::Time::now();
  last_time = ros::Time::now();

  ros::Rate r(100);
  while(n.ok()){

		cliaddr_len = sizeof(cliaddr);
		if (recvfrom(sockfd, recvbuf, 256, 0,(struct sockaddr *)&cliaddr, &cliaddr_len) == -1) {
			perror("Error in receiving response from server\n");
		  cout<<"wrong"<<endl;
		}
		unsigned char xByte[] = { recvbuf[2],recvbuf[3] ,recvbuf[4] ,recvbuf[5] };
		unsigned char yByte[] = { recvbuf[6],recvbuf[7] ,recvbuf[8] ,recvbuf[9] };
		unsigned char zByte[] = { recvbuf[10],recvbuf[11] ,recvbuf[12] ,recvbuf[13] };
		unsigned char rxByte[] = { recvbuf[19],recvbuf[20] ,recvbuf[21] ,recvbuf[22] };
		unsigned char ryByte[] = { recvbuf[23],recvbuf[24] ,recvbuf[25] ,recvbuf[26] };
		unsigned char rzByte[] = { recvbuf[27],recvbuf[28] ,recvbuf[29] ,recvbuf[30] };
		Byte_to_Float(&x, xByte);
		Byte_to_Float(&y, yByte);
		Byte_to_Float(&z, zByte);
		Byte_to_Float(&xth, rxByte);
		Byte_to_Float(&yth, ryByte);
		Byte_to_Float(&zth, rzByte);
		x=x/1000;
		y=y/1000;
		z=0;
		//定位失败
		if(x!=0 && y!=0) {
			xb=x;
			yb=y;
			zthb = zth;
		}
		else{
			x=xb;
			y=yb;
			zth = zthb;			
		}

		printf("6D:%f %f %f %f %f %f\n",x,y,z,xth,yth,zth);
    ros::spinOnce();               // check for incoming messages
    current_time = ros::Time::now();
    //since all odometry is 6DOF we'll need a quaternion created from yaw
    geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(zth);

    //first, we'll publish the transform over tf
    geometry_msgs::TransformStamped odom_trans;
    odom_trans.header.stamp = current_time;
    odom_trans.header.frame_id = "odom";
    odom_trans.child_frame_id = "base_footprint";

    odom_trans.transform.translation.x = x;
    odom_trans.transform.translation.y = y;
    odom_trans.transform.translation.z = z;
    odom_trans.transform.rotation = odom_quat;

    //send the transform

    odom_broadcaster.sendTransform(odom_trans);
			
    //next, we'll publish the odometry message over ROS
 
    nav_msgs::Odometry odom;
    odom.header.stamp = current_time;
    odom.header.frame_id = "odom";
    //odom.child_frame_id = "base_footprint";
    //set the position
    odom.pose.pose.position.x = x;
    odom.pose.pose.position.y = y;
    odom.pose.pose.position.z = z;
    odom.pose.pose.orientation = tf::createQuaternionMsgFromYaw(zth);
		odom.pose.covariance = {0.001, 0.0, 0.0, 0.0, 0.0, 0.0, 
			         							0.0, 0.001, 0.0, 0.0, 0.0, 0.0, 
			         							0.0, 0.0, 0.001, 0.0, 0.0, 0.0, 
			         							0.0, 0.0, 0.0, 0.001, 0.0, 0.0, 
			         							0.0, 0.0, 0.0, 0.0, 0.001, 0.0, 
			         							0.0, 0.0, 0.0, 0.0, 0.0, 0.001};
/*	//set the velocity	
		odom.twist.covariance = {10000, 0.0, 0.0, 0.0, 0.0, 0.0, 
			         								0.0, 10000, 0.0, 0.0, 0.0, 0.0, 
			         								0.0, 0.0, 10000, 0.0, 0.0, 0.0, 
			        								0.0, 0.0, 0.0, 10000, 0.0, 0.0, 
			         								0.0, 0.0, 0.0, 0.0,10000, 0.0, 
			         								0.0, 0.0, 0.0, 0.0, 0.0, 10000};

    odom.twist.twist.linear.x = 0;
    odom.twist.twist.linear.y = 0;
    odom.twist.twist.angular.z = 0;*/
    
    //publish the message

    odom_pub.publish(odom);
    last_time = current_time;
    r.sleep();
  }
  close(sockfd);
}
