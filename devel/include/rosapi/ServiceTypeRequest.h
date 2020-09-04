// Generated by gencpp from file rosapi/ServiceTypeRequest.msg
// DO NOT EDIT!


#ifndef ROSAPI_MESSAGE_SERVICETYPEREQUEST_H
#define ROSAPI_MESSAGE_SERVICETYPEREQUEST_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace rosapi
{
template <class ContainerAllocator>
struct ServiceTypeRequest_
{
  typedef ServiceTypeRequest_<ContainerAllocator> Type;

  ServiceTypeRequest_()
    : service()  {
    }
  ServiceTypeRequest_(const ContainerAllocator& _alloc)
    : service(_alloc)  {
  (void)_alloc;
    }



   typedef std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other >  _service_type;
  _service_type service;





  typedef boost::shared_ptr< ::rosapi::ServiceTypeRequest_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::rosapi::ServiceTypeRequest_<ContainerAllocator> const> ConstPtr;

}; // struct ServiceTypeRequest_

typedef ::rosapi::ServiceTypeRequest_<std::allocator<void> > ServiceTypeRequest;

typedef boost::shared_ptr< ::rosapi::ServiceTypeRequest > ServiceTypeRequestPtr;
typedef boost::shared_ptr< ::rosapi::ServiceTypeRequest const> ServiceTypeRequestConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::rosapi::ServiceTypeRequest_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace rosapi

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': False, 'IsMessage': True, 'HasHeader': False}
// {'rosapi': ['/home/hanwen/hw_ws/src/rosbridge_suite/rosapi/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::rosapi::ServiceTypeRequest_<ContainerAllocator> const>
  : FalseType
  { };

template <class ContainerAllocator>
struct IsMessage< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::rosapi::ServiceTypeRequest_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::rosapi::ServiceTypeRequest_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "1cbcfa13b08f6d36710b9af8741e6112";
  }

  static const char* value(const ::rosapi::ServiceTypeRequest_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0x1cbcfa13b08f6d36ULL;
  static const uint64_t static_value2 = 0x710b9af8741e6112ULL;
};

template<class ContainerAllocator>
struct DataType< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "rosapi/ServiceTypeRequest";
  }

  static const char* value(const ::rosapi::ServiceTypeRequest_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
{
  static const char* value()
  {
    return "string service\n\
";
  }

  static const char* value(const ::rosapi::ServiceTypeRequest_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.service);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER
  }; // struct ServiceTypeRequest_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::rosapi::ServiceTypeRequest_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::rosapi::ServiceTypeRequest_<ContainerAllocator>& v)
  {
    s << indent << "service: ";
    Printer<std::basic_string<char, std::char_traits<char>, typename ContainerAllocator::template rebind<char>::other > >::stream(s, indent + "  ", v.service);
  }
};

} // namespace message_operations
} // namespace ros

#endif // ROSAPI_MESSAGE_SERVICETYPEREQUEST_H
