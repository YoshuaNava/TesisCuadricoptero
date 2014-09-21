# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "comunicacion_serial: 3 messages, 0 services")

set(MSG_I_FLAGS "-Icomunicacion_serial:/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg;-Istd_msgs:/opt/ros/indigo/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(genlisp REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(comunicacion_serial_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg" NAME_WE)
add_custom_target(_comunicacion_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "comunicacion_serial" "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg" ""
)

get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg" NAME_WE)
add_custom_target(_comunicacion_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "comunicacion_serial" "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg" ""
)

get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg" NAME_WE)
add_custom_target(_comunicacion_serial_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "comunicacion_serial" "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg" ""
)

#
#  langs = gencpp;genlisp;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_cpp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_cpp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial
)

### Generating Services

### Generating Module File
_generate_module_cpp(comunicacion_serial
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(comunicacion_serial_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(comunicacion_serial_generate_messages comunicacion_serial_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_cpp _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_cpp _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_cpp _comunicacion_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(comunicacion_serial_gencpp)
add_dependencies(comunicacion_serial_gencpp comunicacion_serial_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS comunicacion_serial_generate_messages_cpp)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_lisp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_lisp(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial
)

### Generating Services

### Generating Module File
_generate_module_lisp(comunicacion_serial
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(comunicacion_serial_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(comunicacion_serial_generate_messages comunicacion_serial_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_lisp _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_lisp _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_lisp _comunicacion_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(comunicacion_serial_genlisp)
add_dependencies(comunicacion_serial_genlisp comunicacion_serial_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS comunicacion_serial_generate_messages_lisp)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_py(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial
)
_generate_msg_py(comunicacion_serial
  "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial
)

### Generating Services

### Generating Module File
_generate_module_py(comunicacion_serial
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(comunicacion_serial_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(comunicacion_serial_generate_messages comunicacion_serial_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoEncendido.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_py _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/ComandoMovimiento.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_py _comunicacion_serial_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/alfredoso/GitHub/TesisCuadricoptero/EstacionControl_ROS/src/comunicacion_serial/msg/EstadoCuadricoptero.msg" NAME_WE)
add_dependencies(comunicacion_serial_generate_messages_py _comunicacion_serial_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(comunicacion_serial_genpy)
add_dependencies(comunicacion_serial_genpy comunicacion_serial_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS comunicacion_serial_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/comunicacion_serial
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
add_dependencies(comunicacion_serial_generate_messages_cpp std_msgs_generate_messages_cpp)

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/comunicacion_serial
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
add_dependencies(comunicacion_serial_generate_messages_lisp std_msgs_generate_messages_lisp)

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/comunicacion_serial
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
add_dependencies(comunicacion_serial_generate_messages_py std_msgs_generate_messages_py)
