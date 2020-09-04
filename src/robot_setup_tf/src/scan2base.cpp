#include <ros/ros.h>
#include <tf/transform_listener.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <sensor_msgs/LaserScan.h>
#include <iostream>

using namespace std;

void chatterCallback(const sensor_msgs::LaserScan& msg){
	ros::NodeHandle nh;
	static ros::Publisher scan_pub = nh.advertise<sensor_msgs::LaserScan>("base_scan", 1000);
	sensor_msgs::LaserScan scan_msg;
	scan_msg = msg;
	for(int i=0;i<90;i++){
		scan_msg.ranges[i]=std::numeric_limits<float>::infinity();
		scan_msg.ranges[i+270]=std::numeric_limits<float>::infinity();
		scan_msg.intensities[i]=0;
		scan_msg.intensities[i+270]=0;
	}
	scan_pub.publish(scan_msg);
}

int main(int argc, char** argv){
	ros::init(argc, argv, "scan2base");
	ros::NodeHandle n;
	ros::Subscriber sub = n.subscribe("scan", 1000, chatterCallback);
	

	ros::spin();


  return 0;
};
