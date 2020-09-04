# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "serial_port: 2 messages, 1 services")

set(MSG_I_FLAGS "-Iserial_port:/home/hanwen/hw_ws/src/serial_port/msg;-Istd_msgs:/opt/ros/kinetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(serial_port_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_custom_target(_serial_port_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "serial_port" "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" ""
)

get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_custom_target(_serial_port_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "serial_port" "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" ""
)

get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_custom_target(_serial_port_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "serial_port" "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port
)
_generate_msg_cpp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port
)

### Generating Services
_generate_srv_cpp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port
)

### Generating Module File
_generate_module_cpp(serial_port
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(serial_port_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(serial_port_generate_messages serial_port_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_cpp _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_cpp _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(serial_port_generate_messages_cpp _serial_port_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(serial_port_gencpp)
add_dependencies(serial_port_gencpp serial_port_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS serial_port_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port
)
_generate_msg_eus(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port
)

### Generating Services
_generate_srv_eus(serial_port
  "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port
)

### Generating Module File
_generate_module_eus(serial_port
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(serial_port_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(serial_port_generate_messages serial_port_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_eus _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_eus _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(serial_port_generate_messages_eus _serial_port_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(serial_port_geneus)
add_dependencies(serial_port_geneus serial_port_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS serial_port_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port
)
_generate_msg_lisp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port
)

### Generating Services
_generate_srv_lisp(serial_port
  "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port
)

### Generating Module File
_generate_module_lisp(serial_port
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(serial_port_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(serial_port_generate_messages serial_port_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_lisp _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_lisp _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(serial_port_generate_messages_lisp _serial_port_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(serial_port_genlisp)
add_dependencies(serial_port_genlisp serial_port_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS serial_port_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port
)
_generate_msg_nodejs(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port
)

### Generating Services
_generate_srv_nodejs(serial_port
  "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port
)

### Generating Module File
_generate_module_nodejs(serial_port
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(serial_port_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(serial_port_generate_messages serial_port_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_nodejs _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_nodejs _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(serial_port_generate_messages_nodejs _serial_port_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(serial_port_gennodejs)
add_dependencies(serial_port_gennodejs serial_port_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS serial_port_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port
)
_generate_msg_py(serial_port
  "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port
)

### Generating Services
_generate_srv_py(serial_port
  "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port
)

### Generating Module File
_generate_module_py(serial_port
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(serial_port_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(serial_port_generate_messages serial_port_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/carOdom.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_py _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/msg/Num.msg" NAME_WE)
add_dependencies(serial_port_generate_messages_py _serial_port_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/hanwen/hw_ws/src/serial_port/srv/AddTwoInts.srv" NAME_WE)
add_dependencies(serial_port_generate_messages_py _serial_port_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(serial_port_genpy)
add_dependencies(serial_port_genpy serial_port_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS serial_port_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/serial_port
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(serial_port_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/serial_port
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(serial_port_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/serial_port
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(serial_port_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/serial_port
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(serial_port_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port)
  install(CODE "execute_process(COMMAND \"/usr/bin/python\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/serial_port
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(serial_port_generate_messages_py std_msgs_generate_messages_py)
endif()
