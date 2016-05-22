file(GLOB_RECURSE shared_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

# Exclude Win32 files
if(WIN32)
  list(REMOVE_ITEM shared_SRCS
    PosixDaemon.h
    PosixDaemon.cpp
  )
else()
  list(REMOVE_ITEM shared_SRCS
    WheatyExceptionReport.cpp
    WheatyExceptionReport.h
    ServiceWin32.cpp
    ServiceWin32.h
  )
endif()

source_group("Util"
  REGULAR_EXPRESSION .*
)

foreach(SRC ${shared_SRCS})
  get_filename_component(PTH ${SRC} PATH)
  if(PTH)
    if(NOT XCODE) # FIXME: Xcode Generator has bug with nested dirs
      string(REPLACE "/" "\\\\" PTH ${PTH})
    endif()
    source_group(${PTH} FILES ${SRC})
  endif()
endforeach(SRC)

source_group("DataStores"
  REGULAR_EXPRESSION DBC
)

source_group("Log"
  REGULAR_EXPRESSION Log
)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_CURRENT_SOURCE_DIR}/Database
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_BINARY_DIR}
  ${ACE_INCLUDE_DIR}
  ${MYSQL_INCLUDE_DIR}
)

configure_file(${CMAKE_CURRENT_SOURCE_DIR}/SystemConfig.h ${CMAKE_CURRENT_BINARY_DIR}/SystemConfig.h)

add_library(shared STATIC
  ${shared_SRCS}
)

add_dependencies(shared revision.h)
if(NOT ACE_USE_EXTERNAL)
  add_dependencies(shared ACE_Project)
# add_dependencies(shared ace)
endif()
