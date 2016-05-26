/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* This program is free software; you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation; either version 2 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program; if not, write to the Free Software
* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
*/

/* ScriptData
SDName: Instance_Black_Temple
SD%Complete: 100
SDComment: Instance Data Scripts and functions to acquire mobs and set encounter status for use in various Black Temple Scripts
SDCategory: Black Temple
EndScriptData */

#include "precompiled.h"
#include "def_black_temple.h"

#define ENCOUNTERS     10

/* Black Temple encounters:
0 - High Warlord Naj'entus event
1 - Supremus Event
2 - Shade of Akama Event
3 - Teron Gorefiend Event
4 - Gurtogg Bloodboil Event
5 - Reliquary Of Souls Event
6 - Mother Shahraz Event
7 - Illidari Council Event
8 - Illidan Stormrage Event
9 - Akama open door after Illidari defeat
*/

struct instance_black_temple : public ScriptedInstance
{
    instance_black_temple(Map *map) : ScriptedInstance(map) {Initialize();};

    uint64 m_najentusGUID;
    uint64 m_akamaillidanGUID;    // This is the Akama that starts the Illidan encounter.
    uint64 m_akamashadeGUID;      // This is the Akama that starts the Shade of Akama encounter.
    uint64 m_shadeGUID;
    uint64 m_teronGUID;
    uint64 m_supremusGUID;
    uint64 m_malandeGUID;
    uint64 m_gathiosGUID;
    uint64 m_zerevorGUID;
    uint64 m_verasGUID;
    uint64 m_illidariGUID;
    uint64 m_voiceGUID;
    uint64 m_illidanGUID;
    uint64 m_reliquaryGUID;

    uint64 NajentusGate;
    uint64 MainTempleDoors;
    uint64 ShadeOfAkamaDoor;
    uint64 CommonDoor;//Teron
    uint64 TeronDoor;
    uint64 GuurtogDoor;
    uint64 MotherDoor;
    uint64 TempleDoor;//Befor mother
    uint64 CouncilDoor;
    uint64 SimpleDoor;//council
    uint64 IllidanGate;
    uint64 IllidanDoor[2];

    uint32 EnslavedSoulsCount;

    uint32 Encounters[ENCOUNTERS];

    std::map<uint64, uint32> sodList;
    std::vector<uint64> weaponmasterList;
    std::list<uint64> SoulFragmentsList;
    std::list<uint64> AshtongueBrokenList;

    void Initialize()
    {
        sodList.clear();
        SoulFragmentsList.clear();
        AshtongueBrokenList.clear();

        m_shadeGUID = 0;
        m_akamashadeGUID = 0;

        m_teronGUID = 0;

        m_supremusGUID = 0;

        m_najentusGUID = 0;

        m_akamaillidanGUID = 0;
        m_illidanGUID = 0;

        m_malandeGUID = 0;
        m_gathiosGUID = 0;
        m_zerevorGUID = 0;
        m_verasGUID = 0;

        m_illidariGUID = 0;
        m_voiceGUID = 0;

        m_reliquaryGUID = 0;

        NajentusGate     = 0;
        MainTempleDoors  = 0;
        ShadeOfAkamaDoor = 0;
        CommonDoor              = 0; //teron
        TeronDoor               = 0;
        GuurtogDoor             = 0;
        MotherDoor              = 0;
        TempleDoor              = 0;
        SimpleDoor              = 0; //Bycouncil
        CouncilDoor             = 0;
        IllidanGate     = 0;
        IllidanDoor[0]  = 0;
        IllidanDoor[1]  = 0;

        EnslavedSoulsCount = 0;

        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            Encounters[i] = NOT_STARTED;
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
        {
            if (Encounters[i] == IN_PROGRESS)
                return true;
        }
        return false;
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

        debug_log("TSCR: Instance Black Temple: GetPlayerInMap, but PlayerList is empty!");
        return NULL;
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch (entry)
        {
            case 22887:
                return EVENT_HIGHWARLORDNAJENTUS;
            case 22841:
                return EVENT_SHADEOFAKAMA;
            case 22871:
                return EVENT_TERONGOREFIEND;
            case 22898:
                return EVENT_SUPREMUS;
            case 22917:
                return EVENT_ILLIDANSTORMRAGE;
            case 22947:
                return EVENT_MOTHERSHAHRAZ;
            case 22948:
                return EVENT_GURTOGGBLOODBOIL;
            case 22949:
            case 22950:
            case 22951:
            case 22952:
            case 23426: // The Illidari Council - main creature link
                return EVENT_ILLIDARICOUNCIL;
            case 22856:
            case 23418:
            case 23420:
            case 23419:
                return EVENT_RELIQUARYOFSOULS;
            default:
                return 0;
        }
    }

    void OnCreatureCreate(Creature *pCreature, uint32 cEntry)
    {
        bool ashtongueBroken = false;
        switch (cEntry)
        {
            // High Warlord Naj'entus
            case 22887:
                m_najentusGUID = pCreature->GetGUID();
                break;
            case 23089:
                if (!pCreature->GetDBTableGUIDLow())
                    break;

                m_akamaillidanGUID = pCreature->GetGUID();
                break;
            case 23191:
                m_akamashadeGUID = pCreature->GetGUID();
                break;
            // Shade of Akama
            case 22841:
                m_shadeGUID = pCreature->GetGUID();
                break;
            // Teron Gorefiend
            case 22871:
                m_teronGUID = pCreature->GetGUID();
                break;
            // Supremus
            case 22898:
                m_supremusGUID = pCreature->GetGUID();
                break;
            // Illidan Stormrage
            case 22917:
                m_illidanGUID = pCreature->GetGUID();
                break;
            // Illidari Council
            case 22949:
                m_gathiosGUID = pCreature->GetGUID();
                break;
            case 22950:
                m_zerevorGUID = pCreature->GetGUID();
                break;
            case 22951:
                m_malandeGUID = pCreature->GetGUID();
                break;
            case 22952:
                m_verasGUID = pCreature->GetGUID();
                break;
            case 23426:
                m_illidariGUID = pCreature->GetGUID();
                if (GetData(EVENT_ILLIDARICOUNCIL) == DONE && GetData(EVENT_ILLIDARIDOOR) != DONE)
                    if (Creature *pAkama = pCreature->SummonCreature(23089, 671.309f, 305.427f, 271.689f, 6.068f, TEMPSUMMON_DEAD_DESPAWN, 0))
                        pAkama->AI()->DoAction(6);
                break;
            case 23499:
                m_voiceGUID = pCreature->GetGUID();
                break;
            // Reliquary of the Lost
            case 22856:
                m_reliquaryGUID = pCreature->GetGUID();
                break;
            case 23047:
                weaponmasterList.push_back(pCreature->GetGUID());
                break;
            case 23398:
            case 23401:
            case 23399:
                SoulFragmentsList.push_back(pCreature->GetGUID());
                break;
            case 22844:
            case 22849:
            case 22845:
            case 22847:
            case 23374:
            case 22846:
            case 22848:
                AshtongueBrokenList.push_back(pCreature->GetGUID());
                ashtongueBroken = true;
                break;
            case 23254: //Fel Geyser
                pCreature->CastSpell(pCreature, 40593, false);
                break;
        }

        const CreatureData *tmp = pCreature->GetLinkedRespawnCreatureData();
        if (!tmp)
            return;

        if (pCreature->isAlive() && GetData(GetEncounterForEntry(tmp->id)) == DONE)
        {
            if (ashtongueBroken)
                pCreature->setFaction(1820);
            else
            {
                pCreature->setDeathState(JUST_DIED);
                pCreature->RemoveCorpse();
            }
        }
    }

    void OnObjectCreate(GameObject* go)
    {
        switch(go->GetEntry())
        {
        case 185483:
            NajentusGate = go->GetGUID();       // Gate past Naj'entus (at the entrance to Supermoose's courtyards)
            if(Encounters[0] == DONE)
                HandleGameObject(0, true, go);
            break;
        case 185882:
            MainTempleDoors = go->GetGUID();    // Main Temple Doors - right past Supermoose (Supremus)
            if(Encounters[1] == DONE)
                HandleGameObject(0, true, go);
            break;
        case 185478:
            ShadeOfAkamaDoor = go->GetGUID();
            break;
        case 185480:
            CommonDoor = go->GetGUID();
            if(Encounters[3] == DONE)
                HandleGameObject(0, true, go);
            break;
        case 186153:
            TeronDoor = go->GetGUID();
            if(Encounters[3] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 185892:
            GuurtogDoor = go->GetGUID();
            if(Encounters[4] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 185479:
            TempleDoor = go->GetGUID();
            if(Encounters[2] == DONE && Encounters[3] == DONE && Encounters[4] == DONE && Encounters[5] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 185482:
            MotherDoor = go->GetGUID();
            if(Encounters[6] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 185481:
            CouncilDoor = go->GetGUID();
            if(Encounters[7] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 186152:
            SimpleDoor = go->GetGUID();
            if(Encounters[7] == DONE)
                HandleGameObject(0,true,go);
            break;
        case 185905:
            if(Encounters[9] == DONE)
                HandleGameObject(0,true,go);

            IllidanGate = go->GetGUID();
            break; // Gate leading to Temple Summit
        case 186261:
            IllidanDoor[0] = go->GetGUID();
            break; // Right door at Temple Summit
        case 186262:
            IllidanDoor[1] = go->GetGUID();
            break; // Left door at Temple Summit
        }
    }

    uint64 GetData64(uint32 identifier)
    {
        switch(identifier)
        {
            case DATA_HIGHWARLORDNAJENTUS:         return m_najentusGUID;
            case DATA_AKAMA:                       return m_akamaillidanGUID;
            case DATA_AKAMA_SHADE:                 return m_akamashadeGUID;
            case DATA_SHADEOFAKAMA:                return m_shadeGUID;
            case EVENT_RELIQUARYOFSOULS:           return m_reliquaryGUID;
            case DATA_TERONGOREFIEND:              return m_teronGUID;
            case DATA_SUPREMUS:                    return m_supremusGUID;
            case DATA_ILLIDANSTORMRAGE:            return m_illidanGUID;
            case DATA_GATHIOSTHESHATTERER:         return m_gathiosGUID;
            case DATA_HIGHNETHERMANCERZEREVOR:     return m_zerevorGUID;
            case DATA_LADYMALANDE:                 return m_malandeGUID;
            case DATA_VERASDARKSHADOW:             return m_verasGUID;
            case DATA_ILLIDARICOUNCIL:             return m_illidariGUID;
            case DATA_BLOOD_ELF_COUNCIL_VOICE:     return m_voiceGUID;

            case DATA_GAMEOBJECT_NAJENTUS_GATE:    return NajentusGate;
            case DATA_GAMEOBJECT_ILLIDAN_GATE:     return IllidanGate;
            case DATA_GAMEOBJECT_ILLIDAN_DOOR_R:   return IllidanDoor[0];
            case DATA_GAMEOBJECT_ILLIDAN_DOOR_L:   return IllidanDoor[1];
            case DATA_GAMEOBJECT_SUPREMUS_DOORS:   return MainTempleDoors;

            case DATA_WEAPONMASTER_SOLDIER:
            case DATA_WEAPONMASTER_SOLDIER+1:
            case DATA_WEAPONMASTER_SOLDIER+2:
            case DATA_WEAPONMASTER_SOLDIER+3:
            case DATA_WEAPONMASTER_SOLDIER+4:
            case DATA_WEAPONMASTER_SOLDIER+5:
            case DATA_WEAPONMASTER_SOLDIER+6:
            case DATA_WEAPONMASTER_SOLDIER+7:
                return weaponmasterList[identifier-30];
        }
        return 0;
    }

    void SetData(uint32 type, uint32 data)
    {
        switch (type)
        {
            case EVENT_HIGHWARLORDNAJENTUS:
                if (data == DONE)
                    HandleGameObject(NajentusGate, true);

                if(Encounters[0] != DONE)
                    Encounters[0] = data;
            break;
            case EVENT_SUPREMUS:
                if (data == DONE)
                    HandleGameObject(NajentusGate, true);

                if (Encounters[1] != DONE)
                    Encounters[1] = data;
            break;
            case EVENT_SHADEOFAKAMA:
                if (data == DONE && !AshtongueBrokenList.empty())
                {
                    if(Encounters[5] == DONE && Encounters[3] == DONE && Encounters[4] == DONE)
                        HandleGameObject(TempleDoor, true);
                    // after Shade Of Akama is defeated all Ashtongue change faction
                    for (std::list<uint64>::iterator itr = AshtongueBrokenList.begin(); itr != AshtongueBrokenList.end(); ++itr)
                    {
                        if (Creature *pBroken = instance->GetCreature(*itr))
                            pBroken->setFaction(1820);
                    }
                }

                if (data == IN_PROGRESS)
                    HandleGameObject(ShadeOfAkamaDoor, false);
                else
                    HandleGameObject(ShadeOfAkamaDoor, true);

                if (Encounters[2] != DONE)
                    Encounters[2] = data;
            break;
            case EVENT_TERONGOREFIEND:
                if (data == IN_PROGRESS)
                {
                    sodList.clear();
                    HandleGameObject(TeronDoor, false);
                    HandleGameObject(CommonDoor, false);
                }
                else
                {
                    HandleGameObject(TeronDoor, true);
                    HandleGameObject(CommonDoor, true);
                }
                if(data == DONE && Encounters[2] == DONE && Encounters[4] == DONE && Encounters[5] == DONE)
                    HandleGameObject(TempleDoor, true);

                if (Encounters[3] != DONE)
                    Encounters[3] = data;
            break;
            case EVENT_GURTOGGBLOODBOIL:
                if (data == DONE)
                {
                    if(Encounters[2] == DONE && Encounters[3] == DONE && Encounters[5] == DONE)
                        HandleGameObject(TempleDoor, true);
                    HandleGameObject(GuurtogDoor, true);
                }

                if (Encounters[4] != DONE)
                    Encounters[4] = data;

            break;
            case EVENT_RELIQUARYOFSOULS:
                if (data == DONE)
                {
                    if(Encounters[2] == DONE && Encounters[3] == DONE && Encounters[4] == DONE)
                        HandleGameObject(TempleDoor, true);

                    // after RoS dies, hide all soul fragments
                    for (std::list<uint64>::iterator itr = SoulFragmentsList.begin(); itr != SoulFragmentsList.end(); ++itr)
                    {
                        if (Creature *pFragment = instance->GetCreature(*itr))
                        {
                            pFragment->setFaction(35);
                            pFragment->SetVisibility(VISIBILITY_OFF);
                        }
                    }
                }

                if (Encounters[5] != DONE)
                    Encounters[5] = data;
            break;
            case EVENT_MOTHERSHAHRAZ:
                if (data == DONE)
                    HandleGameObject(MotherDoor, true);

                if (Encounters[6] != DONE)
                    Encounters[6] = data;
            break;
            case EVENT_ILLIDARICOUNCIL:
                if (data == IN_PROGRESS)
                {
                    HandleGameObject(CouncilDoor, false);
                    HandleGameObject(SimpleDoor, false);
                }
                else
                {
                    HandleGameObject(CouncilDoor, true);
                    HandleGameObject(SimpleDoor, true);
                }

                if (Encounters[7] != DONE)
                    Encounters[7] = data;
            break;
            case EVENT_ILLIDANSTORMRAGE:
                if (data == IN_PROGRESS)
                {
                    HandleGameObject(IllidanDoor[0], false);
                    HandleGameObject(IllidanDoor[1], false);
                }
                else
                {
                    HandleGameObject(IllidanDoor[0], true);
                    HandleGameObject(IllidanDoor[1], true);
                }

                if (Encounters[8] != DONE)
                    Encounters[8] = data;

            break;
            case DATA_ENSLAVED_SOUL:
                if (data)
                    EnslavedSoulsCount++;
                else
                    EnslavedSoulsCount = 0;
            break;
            case EVENT_ILLIDARIDOOR:
                Encounters[9] = data;
            break;
        }

        if (data == DONE)
            SaveToDB();
    }


    void SetData64(uint32 type, uint64 value)
    {
        switch(type)
        {
            case DATA_SHADOWOFDEATH_APPLY:
                sodList[value] = 70000;
                break;
            case DATA_SHADOWOFDEATH_DONE:
                if(sodList.size() && GetData(EVENT_TERONGOREFIEND) == IN_PROGRESS)
                {
                    for(std::map<uint64,uint32>::iterator itr = sodList.begin(); itr != sodList.end(); itr++)
                    {
                        if(itr->first == value)
                            sodList.erase(itr);
                    }
                }
                break;
        }
    }

    uint32 GetData(uint32 type)
    {
        switch(type)
        {
            case EVENT_HIGHWARLORDNAJENTUS: return Encounters[0];
            case EVENT_SUPREMUS:            return Encounters[1];
            case EVENT_SHADEOFAKAMA:        return Encounters[2];
            case EVENT_TERONGOREFIEND:      return Encounters[3];
            case EVENT_GURTOGGBLOODBOIL:    return Encounters[4];
            case EVENT_RELIQUARYOFSOULS:    return Encounters[5];
            case EVENT_MOTHERSHAHRAZ:       return Encounters[6];
            case EVENT_ILLIDARICOUNCIL:     return Encounters[7];
            case EVENT_ILLIDANSTORMRAGE:    return Encounters[8];
            case EVENT_ILLIDARIDOOR:        return Encounters[9];

            case DATA_ENSLAVED_SOUL:          return EnslavedSoulsCount;
            case DATA_WEAPONMASTER_LIST_SIZE: return weaponmasterList.size();
        }
        return 0;
    }

    void Update(uint32 diff)
    {
        if(GetData(EVENT_TERONGOREFIEND) == IN_PROGRESS)
        {
            if(sodList.size())
            {
                for(std::map<uint64,uint32>::iterator itr = sodList.begin(); itr != sodList.end(); itr++)
                {
                    if(itr->second <= diff)
                    {
                        if(Unit *teron = instance->GetCreature(GetData64(DATA_TERONGOREFIEND)))
                            teron->CastSpell(teron, 40266, true);

                        sodList.erase(itr);
                    }
                    else
                        itr->second -= diff;
                }
            }
        }
    }

    std::string GetSaveData()
    {
        OUT_SAVE_INST_DATA;

        std::ostringstream stream;
        stream << Encounters[0] << " ";
        stream << Encounters[1] << " ";
        stream << Encounters[2] << " ";
        stream << Encounters[3] << " ";
        stream << Encounters[4] << " ";
        stream << Encounters[5] << " ";
        stream << Encounters[6] << " ";
        stream << Encounters[7] << " ";
        stream << Encounters[8] << " ";
        stream << Encounters[9];

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
        loadStream
            >> Encounters[0] >> Encounters[1] >> Encounters[2] >> Encounters[3] >> Encounters[4] >> Encounters[5] >> Encounters[6]
        >> Encounters[7] >> Encounters[8] >> Encounters[9];

        for(uint8 i = 0; i < ENCOUNTERS; ++i)
        {
            if (Encounters[i] == IN_PROGRESS)
                Encounters[i] = NOT_STARTED;
        }

        OUT_LOAD_INST_DATA_COMPLETE;
    }
};

InstanceData* GetInstanceData_instance_black_temple(Map* map)
{
    return new instance_black_temple(map);
}

void AddSC_instance_black_temple()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_black_temple";
    newscript->GetInstanceData = &GetInstanceData_instance_black_temple;
    newscript->RegisterSelf();
}

