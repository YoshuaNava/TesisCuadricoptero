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
 * Auto-generated by genmsg_cpp from file /home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/exportador_estado_csv/msg/ComandoMovimiento.msg
 *
 */


#ifndef EXPORTADOR_ESTADO_CSV_MESSAGE_COMANDOMOVIMIENTO_H
#define EXPORTADOR_ESTADO_CSV_MESSAGE_COMANDOMOVIMIENTO_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace exportador_estado_csv
{
template <class ContainerAllocator>
struct ComandoMovimiento_
{
  typedef ComandoMovimiento_<ContainerAllocator> Type;

  ComandoMovimiento_()
    : comandoPitch(0)
    , comandoRoll(0)
    , comandoAltura(0)  {
    }
  ComandoMovimiento_(const ContainerAllocator& _alloc)
    : comandoPitch(0)
    , comandoRoll(0)
    , comandoAltura(0)  {
    }



   typedef int16_t _comandoPitch_type;
  _comandoPitch_type comandoPitch;

   typedef int16_t _comandoRoll_type;
  _comandoRoll_type comandoRoll;

   typedef int16_t _comandoAltura_type;
  _comandoAltura_type comandoAltura;




  typedef boost::shared_ptr< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> const> ConstPtr;

}; // struct ComandoMovimiento_

typedef ::exportador_estado_csv::ComandoMovimiento_<std::allocator<void> > ComandoMovimiento;

typedef boost::shared_ptr< ::exportador_estado_csv::ComandoMovimiento > ComandoMovimientoPtr;
typedef boost::shared_ptr< ::exportador_estado_csv::ComandoMovimiento const> ComandoMovimientoConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace exportador_estado_csv

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'exportador_estado_csv': ['/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/exportador_estado_csv/msg'], 'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
{
  static const char* value()
  {
    return "b4b940224c0de969ca5cc85632c6b706";
  }

  static const char* value(const ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xb4b940224c0de969ULL;
  static const uint64_t static_value2 = 0xca5cc85632c6b706ULL;
};

template<class ContainerAllocator>
struct DataType< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
{
  static const char* value()
  {
    return "exportador_estado_csv/ComandoMovimiento";
  }

  static const char* value(const ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
{
  static const char* value()
  {
    return "int16 comandoPitch\n\
int16 comandoRoll\n\
int16 comandoAltura\n\
";
  }

  static const char* value(const ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.comandoPitch);
      stream.next(m.comandoRoll);
      stream.next(m.comandoAltura);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct ComandoMovimiento_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::exportador_estado_csv::ComandoMovimiento_<ContainerAllocator>& v)
  {
    s << indent << "comandoPitch: ";
    Printer<int16_t>::stream(s, indent + "  ", v.comandoPitch);
    s << indent << "comandoRoll: ";
    Printer<int16_t>::stream(s, indent + "  ", v.comandoRoll);
    s << indent << "comandoAltura: ";
    Printer<int16_t>::stream(s, indent + "  ", v.comandoAltura);
  }
};

} // namespace message_operations
} // namespace ros

#endif // EXPORTADOR_ESTADO_CSV_MESSAGE_COMANDOMOVIMIENTO_H
