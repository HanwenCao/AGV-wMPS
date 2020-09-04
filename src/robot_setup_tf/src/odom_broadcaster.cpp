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

using namespace std;
using namespace Eigen;
string Trim(string& str)
{
	//str.find_first_not_of(" \t\r\n"),在字符串str中从索引0开始，返回首次不匹配"\t\r\n"的位置
	str.erase(0, str.find_first_not_of(" \t\r\n"));
	str.erase(str.find_last_not_of(" \t\r\n") + 1);
	return str;
}


int main(int argc, char** argv){
  ros::init(argc, argv, "odometry_scan_publisher");
  ros::NodeHandle n;
  ros::Publisher odom_pub = n.advertise<nav_msgs::Odometry>("odom", 50);
  ros::Publisher scan_pub = n.advertise<sensor_msgs::LaserScan>("scan", 50);

//laser
  unsigned int num_readings = 100;
  double laser_frequency = 40;
  double ranges[num_readings];
  double intensities[num_readings];
  int count = 0;

  tf::TransformBroadcaster odom_broadcaster;
  double x = 0;
  double y = 0;
  double z = 0;
  double xth = 0;
  double yth = 0;
  double zth = 0;



  ros::Time current_time, last_time;
  current_time = ros::Time::now();
  last_time = ros::Time::now();

  ros::Rate r(1.0);
  ifstream fin("/home/max/catkin_ws/src/robot_setup_tf/src/TMAC.csv"); //打开文件流操作
  string line;
  int j=0;


  while(n.ok()){
       //generate some fake data for our laser scan
    for(unsigned int i = 0; i < num_readings; ++i)    {
      ranges[i] = count;
      intensities[i] = 100 + count;
    }


    //populate the LaserScan message
    sensor_msgs::LaserScan scan;
    scan.header.stamp = current_time;
    scan.header.frame_id = "laser_frame";
    scan.angle_min = -1.57;
    scan.angle_max = 1.57;
    scan.angle_increment = 3.14 / num_readings;
    scan.time_increment = (1 / laser_frequency) / (num_readings);
    scan.range_min = 0.0;
    scan.range_max = 100.0;


    if (getline(fin, line))   //整行读取，换行符“\n”区分，遇到文件尾标志eof终止读取
        {
            j++;
            //cout << "原始字符串：" << line << endl; //整行输出
            istringstream sin(line); //将整行字符串line读入到字符串流istringstream中
            vector<string> fields; //声明一个字符串向量
            string field;
            while (getline(sin, field, ',')) //将字符串流sin中的字符读入到field字符串中，以逗号为分隔符
            {
                fields.push_back(field); //将刚刚读取的字符串添加到向量fields中
            }
            string name = Trim(fields[0]); //清除掉向量fields中第一个元素的无效字符，并赋值给变量name
            string xx = Trim(fields[1]);
            string yy = Trim(fields[2]);
            string zz = Trim(fields[3]);
            string Rx = Trim(fields[4]);
            string Ry = Trim(fields[5]);
            string Rz = Trim(fields[6]);

            x = atof(xx.c_str())/1000;
            y = atof(yy.c_str())/1000;
            z = atof(zz.c_str())/1000;
            xth = M_PI*atof(Rx.c_str())/180;
            yth = M_PI*atof(Ry.c_str())/180;
            zth = M_PI*atof(Rz.c_str())/180;


            cout << "tmac_odom：" << name << "\t" << x << "\t" << y << "\t" << z << "\t" << xth << "\t" << yth << "\t" << zth << endl;
        }
    else
         cout<<"open failed"<<endl;
    ros::spinOnce();               // check for incoming messages
    current_time = ros::Time::now();


    //since all odometry is 6DOF we'll need a quaternion created from yaw
    geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromRollPitchYaw(xth,yth,zth);

    //first, we'll publish the transform over tf
    geometry_msgs::TransformStamped odom_trans;
    odom_trans.header.stamp = current_time;
    odom_trans.header.frame_id = "odom";
    odom_trans.child_frame_id = "tmac";

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

    //set the position
    odom.pose.pose.position.x = x;
    odom.pose.pose.position.y = y;
    odom.pose.pose.position.z = z;
    odom.pose.pose.orientation = odom_quat;

    //cout << odom_quat.x<<endl;

    //set the velocity
    odom.child_frame_id = "tmac";
    odom.twist.twist.linear.x = 0;
    odom.twist.twist.linear.y = 0;
    odom.twist.twist.angular.z = 0;


    scan.ranges.resize(num_readings);
    scan.intensities.resize(num_readings);
    for(unsigned int i = 0; i < num_readings; ++i){
      scan.ranges[i] = ranges[i];
      scan.intensities[i] = intensities[i];
    }
    //publish the message
    odom_pub.publish(odom);
    scan_pub.publish(scan);
    last_time = current_time;
    ++count;
    r.sleep();
  }
}

