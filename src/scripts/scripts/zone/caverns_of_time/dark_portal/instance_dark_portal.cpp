/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
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

/* ScriptData
SDName: Instance_Dark_Portal
SD%Complete: 90
SDComment: Quest support: 9836, 10297. Still needs post-event support.
SDCategory: Caverns of Time, The Dark Portal
EndScriptData */

#include "precompiled.h"
#include "def_dark_portal.h"

#define ENCOUNTERS              4

#define C_MEDIVH                15608
#define C_TIME_RIFT             17838

#define SPELL_RIFT_CHANNEL      31387

#define RIFT_BOSS               1

#define C_DEJA                  17879
#define INF_C_DEJA              21697
#define C_TEMPO                 17880
#define INF_TIMEREAVER          21698
#define C_AEONUS                17881

#define C_RKEEP                 21104
#define C_RLORD                 17839

inline uint32 RandRiftBoss() { return rand()%2 ? C_RKEEP : C_RLORD; }

float PortalLocation[4][4]=
{
    {-2041.06, 7042.08, 29.99, 1.30},
    {-1968.18, 7042.11, 21.93, 2.12},
    {-1885.82, 7107.36, 22.32, 3.07},
    {-1928.11, 7175.95, 22.11, 3.44}
};

struct Wave
{
    uint32 PortalBoss;                                      //protector of current portal
};

Wave RiftWaves[]=
{
    {RIFT_BOSS},
    {C_DEJA},
    {RIFT_BOSS},
    {C_TEMPO},
    {RIFT_BOSS},
    {C_AEONUS}
};

struct instance_dark_portal : public ScriptedInstance
{
    instance_dark_portal(Map *map) : ScriptedInstance(map)
    {
        Heroic = map->IsHeroic();
        Initialize();
    };

    uint32 Encounter[ENCOUNTERS];

    bool Heroic;

    uint32 mRiftPortalCount;
    uint32 mShieldPercent;
    uint8 mRiftWaveCount;
    uint8 mRiftWaveId;

    uint32 NextPortal_Timer;
    uint32 DespawnDelay;
    uint32 Check_Timer;

    uint64 MedivhGUID;
    uint8 CurrentRiftId;

    std::list<uint64> PortalGUID;

    void Initialize()
    {
        MedivhGUID = 0;
        PortalGUID.clear();
        Clear();
    }

    void Clear()
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] != DONE)
                Encounter[i] = NOT_STARTED;

        mRiftPortalCount    = 0;
        mShieldPercent      = 100;
        mRiftWaveCount      = 0;
        mRiftWaveId         = 0;

        CurrentRiftId = 0;

        NextPortal_Timer    = 0;
        Check_Timer = 0;
        DespawnDelay = 20000;
    }

    Player* GetPlayerInMap()
    {
        Map::PlayerList const& players = instance->GetPlayers();

        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                    return plr;
            }
        }

        debug_log("TSCR: Instance Black Portal: GetPlayerInMap, but PlayerList is empty!");
        return NULL;
    }

    void FailQuests()
    {
        Map::PlayerList const& players = instance->GetPlayers();

        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* plr = itr->getSource())
                {
                    if (plr->GetQuestStatus(QUEST_OPENING_PORTAL) == QUEST_STATUS_INCOMPLETE)
                        plr->FailQuest(QUEST_OPENING_PORTAL);
                    if (plr->GetQuestStatus(QUEST_MASTER_TOUCH) == QUEST_STATUS_INCOMPLETE)
                        plr->FailQuest(QUEST_MASTER_TOUCH);
                }
            }
        }
        else
            debug_log("TSCR: Instance Black Portal: FailQuests, but PlayerList is empty!");
    }

    bool IsAnyPortalOpened()
    {
        Player* player = GetPlayerInMap();

        if (!player)
            return false;

        if (!PortalGUID.empty())
        {
            for (std::list<uint64>::iterator portalGUID = PortalGUID.begin(); portalGUID != PortalGUID.end(); ++portalGUID)
            {
                if (player->GetMap()->GetUnit(*portalGUID))
                    return true;
            }
        }

        return false;
    }

    void UpdateBMWorldState(uint32 id, uint32 state)
    {
        Map::PlayerList const& players = instance->GetPlayers();

        if (!players.isEmpty())
        {
            for (Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
            {
                if (Player* player = itr->getSource())
                    player->SendUpdateWorldState(id,state);
            }
        }
        else
            debug_log("TSCR: Instance Black Portal: UpdateBMWorldState, but PlayerList is empty!");
    }

    void InitWorldState(bool Enable = true)
    {
        UpdateBMWorldState(WORLD_STATE_BM,Enable ? 1 : 0);
        UpdateBMWorldState(WORLD_STATE_BM_SHIELD, 100);
        UpdateBMWorldState(WORLD_STATE_BM_RIFT, 0);
    }

    bool IsEncounterInProgress()
    {
        if (GetData(TYPE_MEDIVH) == IN_PROGRESS)
            return true;

        return false;
    }

    void OnPlayerEnter(Player *player)
    {
        if (GetData(TYPE_MEDIVH) == IN_PROGRESS)
            return;

        player->SendUpdateWorldState(WORLD_STATE_BM,0);
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        if (creature->GetEntry() == C_MEDIVH)
        {
            creature->setActive(true);
            MedivhGUID = creature->GetGUID();
        }
    }

    //what other conditions to check?
    bool CanProgressEvent()
    {
        if (!GetPlayerInMap())
            return false;

        return true;
    }

    uint8 GetRiftWaveId()
    {
        switch (mRiftPortalCount)
        {
        case 6:
            mRiftWaveId = 2;
            return 1;
        case 12:
            mRiftWaveId = 4;
            return 3;
        case 18:
            return 5;
        default:
            return mRiftWaveId;
        }
    }

    uint32 GetTimer(uint32 portal_counter)
    {
        switch (portal_counter)
        {
            case 1:
            case 2:
            case 3:
            case 4:
            case 5:
                return 85000;
            case 6:
                return 120000;
            case 7:
            case 8:
            case 9:
            case 10:
            case 11:
                return 70000;
            case 12:
                return 120000;
            case 13:
            case 14:
            case 15:
            case 16:
            case 17:
                return 50000;
            case 18:
                return 0;
            default:
                return 0;
        }
    }

    void SetData(uint32 type, uint32 data)
    {
        Player *player = GetPlayerInMap();

        if (!player)
        {
            debug_log("TSCR: Instance Black Portal: SetData (Type: %u Data %u) cannot find any player.", type, data);
            return;
        }

        switch (type)
        {
            case TYPE_MEDIVH:
                if (data == SPECIAL && Encounter[0] == IN_PROGRESS)
                {
                    --mShieldPercent;
                    UpdateBMWorldState(WORLD_STATE_BM_SHIELD,mShieldPercent);

                    if (mShieldPercent <= 0)
                    {
                        if (Unit *medivh = Unit::GetUnit(*player,MedivhGUID))
                        {
                            if (medivh->isAlive())
                            {
                                medivh->DealDamage(medivh, medivh->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                                Encounter[0] = FAIL;
                                Encounter[1] = NOT_STARTED;
                            }
                        }
                    }
                }
                else
                {
                    if (data == IN_PROGRESS)
                    {
                        debug_log("TSCR: Instance Dark Portal: Starting event.");
                        InitWorldState();
                        Encounter[1] = IN_PROGRESS;
                        NextPortal_Timer = 15000;
                    }

                    if (data == DONE)
                    {
                        //this may be completed further out in the post-event
                        if (Unit *medivh = Unit::GetUnit(*player,MedivhGUID))
                        {
                            medivh->RemoveAurasDueToSpell(31556);
                            medivh->SetUInt32Value(UNIT_NPC_EMOTESTATE,EMOTE_STATE_NONE);
                            player->GroupEventHappens(QUEST_OPENING_PORTAL,medivh);
                            player->GroupEventHappens(QUEST_MASTER_TOUCH,medivh);
                        }
                    }

                    if (data == FAIL)
                    {
                        FailQuests();
                        Clear();
                        InitWorldState();
                    }
                }
                if (data != SPECIAL)
                    Encounter[0] = data;
                break;
            case TYPE_RIFT:
                if (data == SPECIAL)
                {
                    if (mRiftPortalCount == 18)
                    {
                        NextPortal_Timer = 0;
                        Check_Timer = 0;
                    }
                    else if (mRiftPortalCount != 6 && mRiftPortalCount != 12)
                        Check_Timer = 2000;
                }
                else
                    Encounter[1] = data;
                break;
            case TYPE_C_DEJA:
                if (data == DONE && Heroic)
                    Encounter[2] = data;

                NextPortal_Timer = 30000;
                Check_Timer = 0;
                break;
            case TYPE_TEMPORUS:
                if (data == DONE && Heroic)
                    Encounter[3] = data;

                NextPortal_Timer = 30000;
                Check_Timer = 0;
                break;
        }

        if (data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch (type)
        {
            case TYPE_MEDIVH:
                return Encounter[0];
            case TYPE_RIFT:
                return Encounter[1];
            case TYPE_C_DEJA:
                return Encounter[2];
            case TYPE_TEMPORUS:
                return Encounter[3];
            case DATA_PORTAL_COUNT:
                return mRiftPortalCount;
            case DATA_SHIELD:
                return mShieldPercent;
        }
        return 0;
    }

    uint64 GetData64(uint32 data)
    {
        if (data == DATA_MEDIVH)
            return MedivhGUID;

        return 0;
    }

    Unit* SummonedPortalBoss(Unit* source)
    {
        uint32 entry;

        if (Heroic)
        {
            if (GetRiftWaveId()== 1 && Encounter[2] == DONE)
                entry = INF_C_DEJA;
            else if (GetRiftWaveId()== 3 && Encounter[3] == DONE)
                entry = INF_TIMEREAVER;
            else
                entry = RiftWaves[GetRiftWaveId()].PortalBoss;
        }
        else
            entry = RiftWaves[GetRiftWaveId()].PortalBoss;

        if (entry == RIFT_BOSS)
            entry = RandRiftBoss();

        float x,y,z;
        source->GetRandomPoint(source->GetPositionX(),source->GetPositionY(),source->GetPositionZ(),10.0f,x,y,z);
        //normalize Z-level if we can, if rift is not at ground level.
        source->UpdateAllowedPositionZ(x, y, z);

        debug_log("TSCR: Instance Dark Portal: Summoning rift boss entry %u.",entry);

        Unit *Summon = source->SummonCreature(entry,x,y,z,source->GetOrientation(),
            TEMPSUMMON_TIMED_OR_DEAD_DESPAWN,300000);

        if (Summon)
            return Summon;

        debug_log("TSCR: Instance Dark Portal: what just happened there? No boss, no loot, no fun...");
        return NULL;
    }

    void DoSpawnPortal()
    {
        Player *player = GetPlayerInMap();
        if (!player)
            return;

        if (Unit *medivh = Unit::GetUnit(*player,MedivhGUID))
        {
            for(uint8 i = 0; i < 4; i++)
            {
                int tmp = rand()%4;
                if (tmp != CurrentRiftId)
                {
                    debug_log("TSCR: Instance Dark Portal: Creating Time Rift at locationId %i (old locationId was %u).",tmp,CurrentRiftId);

                    CurrentRiftId = tmp;

                    Unit *temp = medivh->SummonCreature(C_TIME_RIFT,
                        PortalLocation[tmp][0],PortalLocation[tmp][1],PortalLocation[tmp][2],PortalLocation[tmp][3],
                        TEMPSUMMON_CORPSE_DESPAWN,0);
                    if (temp)
                    {
                        PortalGUID.push_back(temp->GetGUID());
                        temp->setActive(true);
                        temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
                        temp->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);


                        if (Unit* boss = SummonedPortalBoss(temp))
                        {
                            boss->setActive(true);

                            if (boss->GetEntry() == 20737 || boss->GetEntry() == 17881)
                            {
                                boss->Attack(medivh, false);
                            }
                            else
                            {
                                temp->AddThreat(medivh, 0.0f);
                                temp->CastSpell(boss,SPELL_RIFT_CHANNEL,false);
                            }
                        }
                    }
                    break;
                }
            }
        }
    }

    void Update(uint32 diff)
    {
        Player *player = GetPlayerInMap();

        if (!player)
            return;

        if (Encounter[0] == FAIL)
            if (DespawnDelay && DespawnDelay < diff)
            {
                if (Unit* medivh = Unit::GetUnit(*player, MedivhGUID))
                    ((Creature*)medivh)->RemoveCorpse();
                DespawnDelay = 0;
            }
            else
                DespawnDelay -= diff;

        if (Encounter[1] != IN_PROGRESS)
            return;

        //add delay timer?
        if (!CanProgressEvent())
        {
            Clear();
            SetData(DATA_MEDIVH, FAIL);
            return;
        }

        if (Check_Timer && Check_Timer <= diff)
        {
            if (!IsAnyPortalOpened())
                NextPortal_Timer = 13000;

            Check_Timer = 0;
        }
        else
            Check_Timer -= diff;

        if (NextPortal_Timer && NextPortal_Timer <= diff)
        {            
            if (!IsAnyPortalOpened()){            
                ++mRiftPortalCount;
                UpdateBMWorldState(WORLD_STATE_BM_RIFT,mRiftPortalCount);

                DoSpawnPortal();
                NextPortal_Timer = GetTimer(mRiftPortalCount);
            }
            else
                NextPortal_Timer = GetTimer(mRiftPortalCount);
        }
        else
            NextPortal_Timer -= diff;
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounter[0] << " ";
        stream << Encounter[1] << " ";
        stream << Encounter[2] << " ";
        stream << Encounter[3];

        OUT_SAVE_INST_DATA_COMPLETE;

        return stream.str();
    }

    void Load(const char* in)
    {
        if (!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);

        std::istringstream loadStream(in);
        loadStream >> Encounter[0] >> Encounter[1] >> Encounter[2] >> Encounter[3];

        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounter[i] == IN_PROGRESS)
                Encounter[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

};

InstanceData* GetInstanceData_instance_dark_portal(Map* map)
{
    return new instance_dark_portal(map);
}

void AddSC_instance_dark_portal()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name = "instance_dark_portal";
    newscript->GetInstanceData = &GetInstanceData_instance_dark_portal;
    newscript->RegisterSelf();
}

