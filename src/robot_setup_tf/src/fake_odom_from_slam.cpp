#include <ros/ros.h>
#include <tf/transform_broadcaster.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/PoseWithCovarianceStamped.h>
#include <geometry_msgs/Twist.h>

void slampose_callback(const geometry_msgs::PoseWithCovarianceStamped& msg);
void cmdvel_callback(const geometry_msgs::Twist& msg);

float x_est, y_est, z_est, w_est, yaw_est; //global variables: Pose estimated by SLAM
float vel_x, vel_y, ang_z; 


int main(int argc, char** argv){
  ros::init(argc, argv, "hectorslam_fake_odometry");

  ros::NodeHandle n;
  ros::Subscriber pose_sub = n.subscribe("poseupdate", 1000, slampose_callback);
  ros::Subscriber vel_sub = n.subscribe("cmd_vel", 1000, cmdvel_callback);
  ros::Publisher odom_pub = n.advertise<nav_msgs::Odometry>("odom", 50);
  tf::TransformBroadcaster odom_broadcaster;



  //double vx = 0.0;
  //double vy = 0.0;
  //double vyaw = 0;
  float dx_est, dy_est, dyaw_est, yaw_comp;
  float x,y,yaw;
  //float x_old, y_old, yaw_old; //for twist calculation
  double dt=0;
  geometry_msgs::Quaternion odom_quat;

  ros::Time current_time, last_time;
  current_time = ros::Time::now();
  last_time = ros::Time::now();

  ros::Rate r(10.0);

/////////////
  while(n.ok()){

    //ros::spinOnce();  


    //x = x_est; // hold (get the latest readings)
    //y = y_est;
    //yaw = yaw_est;
    current_time = ros::Time::now();   
    dt = (current_time - last_time).toSec();
    //ROS_INFO("dt:%f", dt);  //0.1s
    //dx_est = x - x_old; // in odom frame
    //dy_est = y - y_old;
    //dyaw_est = yaw - yaw_old;
        
    //vx = 0;
    //vx = (dx_est/cos(yaw_est) + dy_est/sin(yaw_est)) / dt; // in base frame
    //vy = (dy_est/cos(yaw_est) - dx_est/sin(yaw_est)) / dt;
    //vyaw = dyaw_est / dt;


    
    //since all odometry is 6DOF we'll need a quaternion created from yaw
    //geometry_msgs::Quaternion odom_quat = tf::createQuaternionMsgFromYaw(th);
    
    odom_quat.x = 0;
    odom_quat.y = 0;
    odom_quat.z = z_est;
    odom_quat.w = w_est;

    //yaw_comp = ang_z*dt + yaw;  //compensate
    //odom_quat = tf::createQuaternionMsgFromYaw(yaw_comp);
    //first, we'll publish the transform over tf
    geometry_msgs::TransformStamped odom_trans;
    odom_trans.header.stamp = current_time;
    odom_trans.header.frame_id = "odom";
    //odom_trans.child_frame_id = "base_link";
    odom_trans.child_frame_id = "base_footprint";


    odom_trans.transform.translation.x = x_est;
    odom_trans.transform.translation.y = y_est;
    odom_trans.transform.translation.z = 0.0;
    odom_trans.transform.rotation = odom_quat;

    //send the transform
    odom_broadcaster.sendTransform(odom_trans);

    //next, we'll publish the odometry message over ROS
    nav_msgs::Odometry odom;
    odom.header.stamp = current_time;
    odom.header.frame_id = "odom";

    //set the position
    odom.pose.pose.position.x = x_est;
    odom.pose.pose.position.y = y_est;
    odom.pose.pose.position.z = 0.0;
    odom.pose.pose.orientation = odom_quat;
    odom.pose.covariance = {1000, 0.0, 0.0, 0.0, 0.0, 0.0, 
			         0.0, 1000, 0.0, 0.0, 0.0, 0.0, 
			         0.0, 0.0, 1000, 0.0, 0.0, 0.0, 
			         0.0, 0.0, 0.0, 1000, 0.0, 0.0, 
			         0.0, 0.0, 0.0, 0.0, 1000, 0.0, 
			         0.0, 0.0, 0.0, 0.0, 0.0, 1000};
    //odom.pose = pose_est;

    //set the velocity
    odom.child_frame_id = "base_footprint";
    odom.twist.twist.linear.x = vel_x;  //vx;
    odom.twist.twist.linear.y = vel_y;  //vy;
    odom.twist.twist.angular.z = ang_z;  //vyaw;
    odom.twist.covariance = {1000, 0.0, 0.0, 0.0, 0.0, 0.0, 
			         0.0, 1000, 0.0, 0.0, 0.0, 0.0, 
			         0.0, 0.0, 1000, 0.0, 0.0, 0.0, 
			         0.0, 0.0, 0.0, 1000, 0.0, 0.0, 
			         0.0, 0.0, 0.0, 0.0,1000, 0.0, 
			         0.0, 0.0, 0.0, 0.0, 0.0, 1000};
    
    

    

    //publish the message
    odom_pub.publish(odom);


    //x_old = x; // update
    //y_old = y;
    //yaw_old = yaw;
    last_time = current_time;

    r.sleep();
  }
  ros::spin();
  return 0;
}


void slampose_callback(const geometry_msgs::PoseWithCovarianceStamped& msg)
{
  //ROS_INFO("%f %f %f %f",msg.pose.pose.orientation.x, msg.pose.pose.orientation.y,msg.pose.pose.orientation.z,msg.pose.pose.orientation.w );
  //pose_est = msg.pose;
  x_est = msg.pose.pose.position.x;
  y_est = msg.pose.pose.position.y;
  z_est = msg.pose.pose.orientation.z;
  w_est = msg.pose.pose.orientation.w;
  //ROS_INFO("x: %f ;y: %f ;z: %f",x_est,y_est,z_est);
  yaw_est = tf::getYaw(msg.pose.pose.orientation);
  //ROS_INFO("Raw: %f", yaw_est);

}

void cmdvel_callback(const geometry_msgs::Twist& msg)
{
  // listen to cmd_vel
  vel_x = msg.linear.x;
  vel_y = msg.linear.y;
  ang_z = msg.angular.z;
  //ROS_INFO("vel_x: %f", vel_x);


}

