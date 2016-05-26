file(GLOB_RECURSE game_SRCS RELATIVE ${CMAKE_CURRENT_SOURCE_DIR} *.cpp *.h)

include_directories(
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${CMAKE_SOURCE_DIR}/dep/g3dlite/include
  ${CMAKE_SOURCE_DIR}/dep/recastnavigation/Detour
  ${CMAKE_SOURCE_DIR}/dep/recastnavigation/
  ${CMAKE_CURRENT_SOURCE_DIR}/vmap
  ${CMAKE_CURRENT_SOURCE_DIR}/movemap
  ${CMAKE_SOURCE_DIR}/dep/include
  ${CMAKE_SOURCE_DIR}/src/shared
  ${CMAKE_SOURCE_DIR}/src/shared/Database
  ${CMAKE_SOURCE_DIR}/src/framework
  ${CMAKE_BINARY_DIR}
  ${CMAKE_BINARY_DIR}/src/shared
  ${MYSQL_INCLUDE_DIR}
  ${ACE_INCLUDE_DIR}
)

source_group("Object"
  REGULAR_EXPRESSION .*
)

source_group("World/Handlers"
  # REGULAR_EXPRESSION Mgr|Handler|Manager|BattleGround|Cell|Channel|Chat|Gossip|Grid|Group|Instance|Mail|Map|Path|Pool|Quest|Script|Skill|Spell|Transports|Update|Weather|World
  REGULAR_EXPRESSION Mgr|Handler|Manager|Cell|Channel|Chat|Gossip|Grid|Instance|Map|Path|Pool|Script|Skill|Transports|Update|Weather|World
)

source_group("Motion generators"
  REGULAR_EXPRESSION MoveMap|MoveMapSharedDefines|Generator|MotionMaster|Holder
)

source_group("Movement"
  REGULAR_EXPRESSION spline|Spline|packet_builder
  FILES
    movement/typedefs.h
    movement/util.cpp
)

source_group("Server"
  REGULAR_EXPRESSION Socket|Session|Opcodes|DBC
  FILES
    SharedDefines.h
)

source_group("Chat Commands"
  REGULAR_EXPRESSION Level[0-9]
  FILES
    debugcmds.cpp
)

source_group("Tool"
  REGULAR_EXPRESSION Language
)

source_group("References"
  REGULAR_EXPRESSION Reference|RefManager|ThreatManager
)

add_library(game STATIC
  ${game_SRCS}
)

target_link_libraries(game
  shared
  g3dlib
  detour
)

if(UNIX)
  # Both systems don't have libdl and don't need them
  if (NOT (CMAKE_SYSTEM_NAME STREQUAL "FreeBSD" OR CMAKE_SYSTEM_NAME STREQUAL "NetBSD"))
    target_link_libraries(game
      dl
    )
  endif()
endif()

add_dependencies(game revision.h g3dlite)
if(NOT ACE_USE_EXTERNAL)
  add_dependencies(game ACE_Project)
# add_dependencies(game ace)
endif()
