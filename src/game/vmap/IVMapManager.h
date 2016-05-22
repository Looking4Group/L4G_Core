/*
 * Copyright (C) 2005-2010 MaNGOS <http://getmangos.com/>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef _IVMAPMANAGER_H
#define _IVMAPMANAGER_H

#include <string>
#include <Platform/Define.h>
#include <G3D/Table.h>

//===========================================================

/**
This is the minimum interface to the VMapMamager.
*/

namespace VMAP
{

    enum VMAPLoadResult
    {
        VMAP_LOAD_RESULT_ERROR,
        VMAP_LOAD_RESULT_OK,
        VMAP_LOAD_RESULT_IGNORED,
    };

    #define VMAP_INVALID_HEIGHT       -100000.0f            // for check
    #define VMAP_INVALID_HEIGHT_VALUE -200000.0f            // real assigned value in unknown height case

    //===========================================================
    class IVMapManager
    {
        private:
            bool iEnableClusterComputing;

        public:
            IVMapManager() : iEnableClusterComputing(false) {}

            virtual ~IVMapManager(void) {}

            virtual VMAPLoadResult loadMap(const char* pBasePath, unsigned int pMapId, int x, int y) = 0;

            virtual bool existsMap(const char* pBasePath, unsigned int pMapId, int x, int y) = 0;

            virtual void unloadMap(unsigned int pMapId, int x, int y) = 0;
            virtual void unloadMap(unsigned int pMapId) = 0;

            virtual bool isInLineOfSight(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2) = 0;
            virtual bool isInLineOfSight2(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2) = 0;
            virtual float getHeight(unsigned int pMapId, float x, float y, float z, float maxSearchDist) = 0;
            /**
            test if we hit an object. return true if we hit one. rx,ry,rz will hold the hit position or the dest position, if no intersection was found
            return a position, that is pReduceDist closer to the origin
            */
            virtual bool getObjectHitPos(unsigned int pMapId, float x1, float y1, float z1, float x2, float y2, float z2, float& rx, float &ry, float& rz, float pModifyDist) = 0;
            /**
            send debug commands
            */
            virtual bool processCommand(char *pCommand)= 0;

            void setEnableClusterComputing(bool pVal) { iEnableClusterComputing = pVal; }

            bool isClusterComputingEnabled() const { return iEnableClusterComputing; }

            virtual std::string getDirFileName(unsigned int pMapId, int x, int y) const =0;

            /**
            Query world model area info.
            \param z gets adjusted to the ground height for which this are info is valid
            */
            virtual bool getAreaInfo(unsigned int pMapId, float x, float y, float &z, uint32 &flags, int32 &adtId, int32 &rootId, int32 &groupId) const=0;
            virtual bool GetLiquidLevel(uint32 pMapId, float x, float y, float z, uint8 ReqLiquidType, float &level, float &floor, uint32 &type) const=0;
    };
}

#endif
