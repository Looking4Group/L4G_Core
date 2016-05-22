
########### next target ###############

remove_definitions(
-ffast-math
-funsafe-math-optimizations
)

SET(vmaps_STAT_SRCS
   BIH.h
   BIH.cpp
   IVMapManager.h
   MapTree.h
   MapTree.cpp
   ModelInstance.h
   ModelInstance.cpp
   TileAssembler.h
   TileAssembler.cpp
   VMapDefinitions.h
   VMapFactory.h
   VMapFactory.cpp
   VMapManager2.h
   VMapManager2.cpp
   VMapTools.h
   WorldModel.h
   WorldModel.cpp
   VMapCluster.h
   VMapCluster.cpp
   PipeWrapper.h
   PipeWrapper.cpp
)

add_library(vmaps STATIC ${vmaps_STAT_SRCS})
