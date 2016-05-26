#ifndef _ANTICHEAT_H
#define _ANTICHEAT_H

#include <ace/Method_Request.h>

#include "Player.h"

class ACRequest : public ACE_Method_Request
{
    public:
        ACRequest(Player *player, MovementInfo lastPacket, MovementInfo newPacket)
            : m_ownerGUID(player->GetGUID()), m_oldMovement(lastPacket), m_newMovement(newPacket) {}

        virtual int call();

        bool DetectWaterWalkHack(Player *);
        bool DetectTeleportToPlane(Player*);
        bool DetectFlyHack(Player*);
        bool DetectSpeedHack(Player*);

        MovementInfo &GetLastMovementInfo() { return m_oldMovement; }
        MovementInfo &GetNewMovementInfo() { return m_newMovement; }

    private:
        uint64 m_ownerGUID;

        MovementInfo m_oldMovement;
        MovementInfo m_newMovement;
};

#endif
