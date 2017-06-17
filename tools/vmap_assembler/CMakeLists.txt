# Copyright (C) 2005-2012 MaNGOS project <http://getmangos.com/>
#
# This file is free software; as a special exception the author gives
# unlimited permission to copy and/or distribute it, with or without
# modifications, as long as this notice is preserved.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY, to the extent permitted by law; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

cmake_minimum_required (VERSION 2.6)
project (MANGOS_VMAP_ASSEMB_IO)

set(CMAKE_VERBOSE_MAKEFILE true)

# uncomment next line to disable debug mode
ADD_DEFINITIONS("-DIOMAP_DEBUG")
ADD_DEFINITIONS("-DNO_CORE_FUNCS")

ADD_DEFINITIONS("-Wall")
ADD_DEFINITIONS("-ggdb")
ADD_DEFINITIONS("-O3")

include_directories(../../src/shared)
include_directories(../../src/game/vmap/)
include_directories(../../dep/include/)
include_directories(../../dep/ACE_wrappers/)
include_directories(../../objdir/dep/ACE_wrappers)
include_directories(../../src/framework/)

add_library(g3dlite ../../dep/g3dlite/source/AABox.cpp
	../../dep/g3dlite/source/Box.cpp
	../../dep/g3dlite/source/Crypto.cpp
	../../dep/g3dlite/source/format.cpp
	../../dep/g3dlite/source/Matrix3.cpp
	../../dep/g3dlite/source/Plane.cpp
	../../dep/g3dlite/source/System.cpp
	../../dep/g3dlite/source/Triangle.cpp
	../../dep/g3dlite/source/Vector3.cpp
	../../dep/g3dlite/source/Vector4.cpp
	../../dep/g3dlite/source/debugAssert.cpp
	../../dep/g3dlite/source/FileSystem.cpp
	../../dep/g3dlite/source/fileutils.cpp
	../../dep/g3dlite/source/g3dmath.cpp
	../../dep/g3dlite/source/g3dfnmatch.cpp
	../../dep/g3dlite/source/prompt.cpp
	../../dep/g3dlite/source/stringutils.cpp
	../../dep/g3dlite/source/Any.cpp
	../../dep/g3dlite/source/BinaryFormat.cpp
	../../dep/g3dlite/source/BinaryInput.cpp
	../../dep/g3dlite/source/BinaryOutput.cpp
	../../dep/g3dlite/source/Capsule.cpp
	../../dep/g3dlite/source/CollisionDetection.cpp
	../../dep/g3dlite/source/CoordinateFrame.cpp
	../../dep/g3dlite/source/Cylinder.cpp
	../../dep/g3dlite/source/Line.cpp
	../../dep/g3dlite/source/LineSegment.cpp
	../../dep/g3dlite/source/Log.cpp
	../../dep/g3dlite/source/Matrix4.cpp
	../../dep/g3dlite/source/MemoryManager.cpp
	../../dep/g3dlite/source/PhysicsFrame.cpp
	../../dep/g3dlite/source/Quat.cpp
	../../dep/g3dlite/source/Random.cpp
	../../dep/g3dlite/source/uint128.cpp
	../../dep/g3dlite/source/Ray.cpp
	../../dep/g3dlite/source/ReferenceCount.cpp
	../../dep/g3dlite/source/Sphere.cpp
	../../dep/g3dlite/source/TextInput.cpp
	../../dep/g3dlite/source/TextOutput.cpp
	../../dep/g3dlite/source/UprightFrame.cpp
	../../dep/g3dlite/source/Vector2.cpp
	)

add_library(vmap
	../../src/game/vmap/BIH.cpp
	../../src/game/vmap/VMapManager2.cpp
	../../src/game/vmap/MapTree.cpp
	../../src/game/vmap/TileAssembler.cpp
	../../src/game/vmap/WorldModel.cpp
	../../src/game/vmap/ModelInstance.cpp
	)

target_link_libraries(vmap g3dlite z)

add_executable(vmap_assembler vmap_assembler.cpp)
target_link_libraries(vmap_assembler vmap)

# add_executable(vmap_test coordinate_test.cpp)
# target_link_libraries(vmap_test vmap)

