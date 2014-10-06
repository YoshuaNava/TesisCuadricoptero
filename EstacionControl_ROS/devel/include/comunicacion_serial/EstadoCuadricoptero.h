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
 * Auto-generated by genmsg_cpp from file /home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg
 *
 */


#ifndef COMUNICACION_SERIAL_MESSAGE_ESTADOCUADRICOPTERO_H
#define COMUNICACION_SERIAL_MESSAGE_ESTADOCUADRICOPTERO_H


#include <string>
#include <vector>
#include <map>

#include <ros/types.h>
#include <ros/serialization.h>
#include <ros/builtin_message_traits.h>
#include <ros/message_operations.h>


namespace comunicacion_serial
{
template <class ContainerAllocator>
struct EstadoCuadricoptero_
{
  typedef EstadoCuadricoptero_<ContainerAllocator> Type;

  EstadoCuadricoptero_()
    : tiempoEjecucion()
    , anguloPitch(0)
    , anguloRoll(0)
    , anguloYaw(0)
    , velocidadPitch(0)
    , velocidadRoll(0)
    , velocidadYaw(0)
    , altura(0)
    , encendido(0)
    , mensajesRecibidos(0)  {
    }
  EstadoCuadricoptero_(const ContainerAllocator& _alloc)
    : tiempoEjecucion()
    , anguloPitch(0)
    , anguloRoll(0)
    , anguloYaw(0)
    , velocidadPitch(0)
    , velocidadRoll(0)
    , velocidadYaw(0)
    , altura(0)
    , encendido(0)
    , mensajesRecibidos(0)  {
    }



   typedef ros::Time _tiempoEjecucion_type;
  _tiempoEjecucion_type tiempoEjecucion;

   typedef int32_t _anguloPitch_type;
  _anguloPitch_type anguloPitch;

   typedef int32_t _anguloRoll_type;
  _anguloRoll_type anguloRoll;

   typedef int32_t _anguloYaw_type;
  _anguloYaw_type anguloYaw;

   typedef int32_t _velocidadPitch_type;
  _velocidadPitch_type velocidadPitch;

   typedef int32_t _velocidadRoll_type;
  _velocidadRoll_type velocidadRoll;

   typedef int32_t _velocidadYaw_type;
  _velocidadYaw_type velocidadYaw;

   typedef int32_t _altura_type;
  _altura_type altura;

   typedef int32_t _encendido_type;
  _encendido_type encendido;

   typedef int64_t _mensajesRecibidos_type;
  _mensajesRecibidos_type mensajesRecibidos;




  typedef boost::shared_ptr< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> > Ptr;
  typedef boost::shared_ptr< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> const> ConstPtr;

}; // struct EstadoCuadricoptero_

typedef ::comunicacion_serial::EstadoCuadricoptero_<std::allocator<void> > EstadoCuadricoptero;

typedef boost::shared_ptr< ::comunicacion_serial::EstadoCuadricoptero > EstadoCuadricopteroPtr;
typedef boost::shared_ptr< ::comunicacion_serial::EstadoCuadricoptero const> EstadoCuadricopteroConstPtr;

// constants requiring out of line definition



template<typename ContainerAllocator>
std::ostream& operator<<(std::ostream& s, const ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> & v)
{
ros::message_operations::Printer< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >::stream(s, "", v);
return s;
}

} // namespace comunicacion_serial

namespace ros
{
namespace message_traits
{



// BOOLTRAITS {'IsFixedSize': True, 'IsMessage': True, 'HasHeader': False}
// {'std_msgs': ['/opt/ros/indigo/share/std_msgs/cmake/../msg'], 'comunicacion_serial': ['/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg']}

// !!!!!!!!!!! ['__class__', '__delattr__', '__dict__', '__doc__', '__eq__', '__format__', '__getattribute__', '__hash__', '__init__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_parsed_fields', 'constants', 'fields', 'full_name', 'has_header', 'header_present', 'names', 'package', 'parsed_fields', 'short_name', 'text', 'types']




template <class ContainerAllocator>
struct IsFixedSize< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsFixedSize< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
  : TrueType
  { };

template <class ContainerAllocator>
struct IsMessage< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> const>
  : TrueType
  { };

template <class ContainerAllocator>
struct HasHeader< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
  : FalseType
  { };

template <class ContainerAllocator>
struct HasHeader< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> const>
  : FalseType
  { };


template<class ContainerAllocator>
struct MD5Sum< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
{
  static const char* value()
  {
    return "a177d60ff9bc3445dc3d8bf718819b39";
  }

  static const char* value(const ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator>&) { return value(); }
  static const uint64_t static_value1 = 0xa177d60ff9bc3445ULL;
  static const uint64_t static_value2 = 0xdc3d8bf718819b39ULL;
};

template<class ContainerAllocator>
struct DataType< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
{
  static const char* value()
  {
    return "comunicacion_serial/EstadoCuadricoptero";
  }

  static const char* value(const ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator>&) { return value(); }
};

template<class ContainerAllocator>
struct Definition< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
{
  static const char* value()
  {
    return "time tiempoEjecucion\n\
int32 anguloPitch\n\
int32 anguloRoll\n\
int32 anguloYaw\n\
int32 velocidadPitch\n\
int32 velocidadRoll\n\
int32 velocidadYaw\n\
int32 altura\n\
int32 encendido\n\
int64 mensajesRecibidos\n\
";
  }

  static const char* value(const ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator>&) { return value(); }
};

} // namespace message_traits
} // namespace ros

namespace ros
{
namespace serialization
{

  template<class ContainerAllocator> struct Serializer< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
  {
    template<typename Stream, typename T> inline static void allInOne(Stream& stream, T m)
    {
      stream.next(m.tiempoEjecucion);
      stream.next(m.anguloPitch);
      stream.next(m.anguloRoll);
      stream.next(m.anguloYaw);
      stream.next(m.velocidadPitch);
      stream.next(m.velocidadRoll);
      stream.next(m.velocidadYaw);
      stream.next(m.altura);
      stream.next(m.encendido);
      stream.next(m.mensajesRecibidos);
    }

    ROS_DECLARE_ALLINONE_SERIALIZER;
  }; // struct EstadoCuadricoptero_

} // namespace serialization
} // namespace ros

namespace ros
{
namespace message_operations
{

template<class ContainerAllocator>
struct Printer< ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator> >
{
  template<typename Stream> static void stream(Stream& s, const std::string& indent, const ::comunicacion_serial::EstadoCuadricoptero_<ContainerAllocator>& v)
  {
    s << indent << "tiempoEjecucion: ";
    Printer<ros::Time>::stream(s, indent + "  ", v.tiempoEjecucion);
    s << indent << "anguloPitch: ";
    Printer<int32_t>::stream(s, indent + "  ", v.anguloPitch);
    s << indent << "anguloRoll: ";
    Printer<int32_t>::stream(s, indent + "  ", v.anguloRoll);
    s << indent << "anguloYaw: ";
    Printer<int32_t>::stream(s, indent + "  ", v.anguloYaw);
    s << indent << "velocidadPitch: ";
    Printer<int32_t>::stream(s, indent + "  ", v.velocidadPitch);
    s << indent << "velocidadRoll: ";
    Printer<int32_t>::stream(s, indent + "  ", v.velocidadRoll);
    s << indent << "velocidadYaw: ";
    Printer<int32_t>::stream(s, indent + "  ", v.velocidadYaw);
    s << indent << "altura: ";
    Printer<int32_t>::stream(s, indent + "  ", v.altura);
    s << indent << "encendido: ";
    Printer<int32_t>::stream(s, indent + "  ", v.encendido);
    s << indent << "mensajesRecibidos: ";
    Printer<int64_t>::stream(s, indent + "  ", v.mensajesRecibidos);
  }
};

} // namespace message_operations
} // namespace ros

#endif // COMUNICACION_SERIAL_MESSAGE_ESTADOCUADRICOPTERO_H
