/* Software License Agreement (BSD License)
 *
 * Copyright (c) 2011, Willow Garage, Inc.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *  * Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *  * Redistributions in binary form must reproduce the above
 *    copyright notice, this list of conditions and the following
 *    disclaimer in the documentation and/or other materials provided
 *    with the distribution.
 *  * Neither the name of Willow Garage, Inc. nor the names of its
 *    contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 * Auto-generated by genmsg_cpp from file /home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/logitech_rumblepad_ii/msg/Encendido.msg
 *
 */


#ifndef LOGITECH_RUMBLEPAD_II_MESSAGE_ENCENDIDO_H
#define LOGITECH_RUMBLEPAD_II_MESSAGE_ENCENDIDO_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace logitech_rumblepad_ii
{
template <class ContainerAllocator>
struct Encendido_
{
  typedef Encendido_<ContainerAllocator> Type;

  Encendido_()
    : encendido(0)  {
    }
  Encendido_(const ContainerAllocator& _alloc)
    : encendido(0)  {
    }



   typedef uint8_t _encendido_type;
  _encendido_type encendido;




  typedef boost::shared_ptr< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> const> ConstPtr;

}; // struct Encendido_

typedef ::logitech_rumblepad_ii::Encendido_<std::allocator<void> > Encendido;

typedef boost::shared_ptr< ::logitech_rumblepad_ii::Encendido > EncendidoPtr;
typedef boost::shared_ptr< ::logitech_rumblepad_ii::Encendido const> EncendidoConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace logitech_rumblepad_ii

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg'], 'logitech_rumblepad_ii': ['/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/logitech_rumblepad_ii/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
{
  static const char* value()
  {
    return "ca1bb7756711dc79b7b20ec735aada07";
  }

  static const char* value(const ::logitech_rumblepad_ii::Encendido_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xca1bb7756711dc79ULL;
  static const uint64_t static_value2 = 0xb7b20ec735aada07ULL;
};

template<class ContainerAllocator>
struct DataType< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
{
  static const char* value()
  {
    return "logitech_rumblepad_ii/Encendido";
  }

  static const char* value(const ::logitech_rumblepad_ii::Encendido_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
{
  static const char* value()
  {
    return "uint8 encendido\n\
";
  }

  static const char* value(const ::logitech_rumblepad_ii::Encendido_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.encendido);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct Encendido_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::logitech_rumblepad_ii::Encendido_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::logitech_rumblepad_ii::Encendido_<ContainerAllocator>& v)
  {
    s << indent << "encendido: ";
    Printer<uint8_t>::stream(s, indent + "  ", v.encendido);
  }
};

} // namespace message_operations
} // namespace ros

#endif // LOGITECH_RUMBLEPAD_II_MESSAGE_ENCENDIDO_H
