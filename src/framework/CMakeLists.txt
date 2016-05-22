file(GLOB_RECURSE framework_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

source_group("Other"
  REGULAR_EXPRESSION .*
)

source_group("GameSystem"
  REGULAR_EXPRESSION GameSystem
)

source_group("Platform"
  REGULAR_EXPRESSION Platform
)

source_group("Policies"
  REGULAR_EXPRESSION Policies
)

source_group("Utilities"
  REGULAR_EXPRESSION Utilities
)

source_group("Dynamic"
  REGULAR_EXPRESSION Dynamic
)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${ACE_INCLUDE_DIR}
)

add_library(framework STATIC
  ${framework_SRCS}
)

if(NOT TBB_USE_EXTERNAL)
  add_dependencies(framework TBB_Project)
# add_dependencies(framework tbb)
# add_dependencies(framework tbbmalloc)
endif()
if(NOT ACE_USE_EXTERNAL)
  add_dependencies(framework ACE_Project)
# add_dependencies(framework ace)
endif()

target_link_libraries(framework
  ${TBB_LIBRARIES}
)
