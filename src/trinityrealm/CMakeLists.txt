set(EXECUTABLE_NAME trinityrealm)
file(GLOB_RECURSE EXECUTABLE_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

if(WIN32)
  list(APPEND EXECUTABLE_SRCS
    TrinityRealm.rc
  )
endif()

include_directories(
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_BINARY_DIR}/dep
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/src/shared
  ${MYSQL_INCLUDE_DIR}
  ${ACE_INCLUDE_DIR}
)

add_executable(${EXECUTABLE_NAME}
  ${EXECUTABLE_SRCS}
)

add_dependencies(${EXECUTABLE_NAME} revision.h)
if(NOT ACE_USE_EXTERNAL)
  add_dependencies(${EXECUTABLE_NAME} ACE_Project)
# add_dependencies(${EXECUTABLE_NAME} ace)
endif()

target_link_libraries(${EXECUTABLE_NAME}
  shared
  framework
  ${ACE_LIBRARIES}
  ${OPENSSL_LIBRARIES}
)

if(WIN32)
  target_link_libraries(${EXECUTABLE_NAME}
    optimized ${MYSQL_LIBRARY}
    debug ${MYSQL_DEBUG_LIBRARY}
  )
  if(PLATFORM MATCHES X86)
    target_link_libraries(${EXECUTABLE_NAME})
  endif()
endif()

if(UNIX)
  target_link_libraries(${EXECUTABLE_NAME}
    ${MYSQL_LIBRARY}
    ${OPENSSL_EXTRA_LIBRARIES}
  )
endif()

set(EXECUTABLE_LINK_FLAGS "")

if(UNIX)
  set(EXECUTABLE_LINK_FLAGS "-pthread ${EXECUTABLE_LINK_FLAGS}")
endif()

if(APPLE)
  set(EXECUTABLE_LINK_FLAGS "-framework Carbon ${EXECUTABLE_LINK_FLAGS}")
endif()

set_target_properties(${EXECUTABLE_NAME} PROPERTIES LINK_FLAGS
  "${EXECUTABLE_LINK_FLAGS}"
)

install(TARGETS ${EXECUTABLE_NAME} DESTINATION ${BIN_DIR})
install(FILES trinityrealm.conf.dist DESTINATION ${CONF_DIR} RENAME trinityrealm.conf.dist)

if(WIN32 AND MSVC)
  install(FILES ${CMAKE_CURRENT_BINARY_DIR}/\${BUILD_TYPE}/${EXECUTABLE_NAME}.pdb DESTINATION ${BIN_DIR} CONFIGURATIONS Debug)
endif()
