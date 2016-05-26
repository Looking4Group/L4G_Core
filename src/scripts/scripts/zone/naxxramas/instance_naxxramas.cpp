/* ScriptData
SDName: Instance_Naxxramas
SD%Complete: 0
SDComment:
SDCategory: Naxxramas
EndScriptData */

#include "precompiled.h"
#include "def_naxxramas.h"

// This spawns 5 corpse scarabs ontop of us (most likely the player casts this on death)
#define SPELL_SELF_SPAWN_5  29105

#define GO_FOUR_HORSEMEN_CHEST 181366

#define THADDIUS_LAMENT_1   8873
#define THADDIUS_LAMENT_2   8874
#define THADDIUS_LAMENT_3   8875
#define THADDIUS_LAMENT_4   8876

struct instance_naxxramas : public ScriptedInstance
{
    instance_naxxramas(Map *map) : ScriptedInstance(map) { Initialize(); };

    uint32 Encounters[ENCOUNTERS];

    uint8 deadHorsemans;

    uint64 m_thaddiusGUID;
    uint64 m_stalaggGUID;
    uint64 m_feugenGUID;
    uint64 m_lady_blaumeuxGUID;
    uint64 m_thane_korthazzGUID;
    uint64 m_sir_zeliekGUID;
    uint64 m_highlord_mograineGUID;

    uint64 screemTimer;

    void Initialize()
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            Encounters[i] = NOT_STARTED;

        m_thaddiusGUID = 0;
        m_stalaggGUID = 0;
        m_feugenGUID = 0;
        deadHorsemans = 0;

        screemTimer = urand(3*MINUTE*IN_MILISECONDS, 5*MINUTE*IN_MILISECONDS);
    }

    bool IsEncounterInProgress() const
    {
        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounters[i] == IN_PROGRESS)
                return true;

        return false;
    }

    uint32 GetEncounterForEntry(uint32 entry)
    {
        switch (entry)
        {
            case 15956:
                return DATA_ANUB_REKHAN;
            case 15953:
                return DATA_GRAND_WIDOW_FAERLINA;
            case 15952:
                return DATA_MAEXXNA;
            case 15954:
                return DATA_NOTH_THE_PLAGUEBRINGER;
            case 15936:
                return DATA_HEIGAN_THE_UNCLEAN;
            case 16011:
                return DATA_LOATHEB;
            case 16061:
                return DATA_INSTRUCTOR_RAZUVIOUS;
            case 16060:
                return DATA_GOTHIK_THE_HARVESTER;
            case 16064:
            case 16065:
            case 16063:
            case 16062:
                return DATA_THE_FOUR_HORSEMEN;
            case 16028:
                return DATA_PATCHWERK;
            case 15931:
                return DATA_GROBBULUS;
            case 15932:
                return DATA_GLUTH;
            case 15928:
            case 15929:
            case 15930:
                return DATA_THADDIUS;
            case 15989:
                return DATA_SAPPHIRON;
            case 15990:
                return DATA_KEL_THUZAD;
            default:
                return 0;
        }
    }

    void OnCreatureCreate(Creature *creature, uint32 creature_entry)
    {
        switch (creature_entry)
        {
            case 15928:
                m_thaddiusGUID = creature->GetGUID();
                break;
            case 15929:
                m_stalaggGUID = creature->GetGUID();
                break;
            case 15930:
                m_feugenGUID = creature->GetGUID();
                break;
            default:
                break;
        }

        HandleInitCreatureState(creature);
    }

    void OnObjectCreate(GameObject* go){}

    void SetData(uint32 type, uint32 data)
    {
        switch (type)
        {
            case DATA_ANUB_REKHAN:
                if (Encounters[0] != DONE)
                    Encounters[0] = data;
                break;
            case DATA_GRAND_WIDOW_FAERLINA:
                if (Encounters[1] != DONE)
                    Encounters[1] = data;
                break;
            case DATA_MAEXXNA:
                if (Encounters[2] != DONE)
                    Encounters[2] = data;
                break;
            case DATA_NOTH_THE_PLAGUEBRINGER:
                if (Encounters[3] != DONE)
                    Encounters[3] = data;
                break;
            case DATA_HEIGAN_THE_UNCLEAN:
                if (Encounters[4] != DONE)
                    Encounters[4] = data;
                break;
            case DATA_LOATHEB:
                if (Encounters[5] != DONE)
                    Encounters[5] = data;
                break;
            case DATA_INSTRUCTOR_RAZUVIOUS:
                if (Encounters[6] != DONE)
                    Encounters[6] = data;
                break;
            case DATA_GOTHIK_THE_HARVESTER:
                if (Encounters[7] != DONE)
                    Encounters[7] = data;
                break;
            case DATA_THE_FOUR_HORSEMEN:
                switch (data)
                {
                    case DONE:
                        if ((++deadHorsemans) == 4 && Encounters[8] != DONE)
                        {
                            Encounters[8] = data;
                            if (Player *player = GetPlayer())
                                player->SummonGameObject(GO_FOUR_HORSEMEN_CHEST, 2514, -2945, 245.5, 5.48, 0, 0, 0, 0, 0);
                        }
                        break;
                    case NOT_STARTED:
                        if (Encounters[8] != DONE)
                        {
                            Encounters[8] = data;
                            deadHorsemans = 0;
                        }
                        break;
                    default:
                        if (Encounters[8] != DONE)
                            Encounters[8] = data;
                        break;
                }
                break;
            case DATA_PATCHWERK:
                if (Encounters[9] != DONE)
                    Encounters[9] = data;
                break;
            case DATA_GROBBULUS:
                if (Encounters[10] != DONE)
                    Encounters[10] = data;
                break;
            case DATA_GLUTH:
                if (Encounters[11] != DONE)
                    Encounters[11] = data;
                break;
            case DATA_THADDIUS:
                if (Encounters[12] != DONE)
                    Encounters[12] = data;
                break;
            case DATA_SAPPHIRON:
                if (Encounters[13] != DONE)
                    Encounters[13] = data;
                break;
            case DATA_KEL_THUZAD:
                if (Encounters[14] != DONE)
                    Encounters[14] = data;
                break;
        }

        if (data == DONE)
            SaveToDB();
    }

    uint32 GetData(uint32 type)
    {
        switch (type)
        {
            case DATA_ANUB_REKHAN:
                return Encounters[0];
            case DATA_GRAND_WIDOW_FAERLINA:
                return Encounters[1];
            case DATA_MAEXXNA:
                return Encounters[2];
            case DATA_NOTH_THE_PLAGUEBRINGER:
                return Encounters[3];
            case DATA_HEIGAN_THE_UNCLEAN:
                return Encounters[4];
            case DATA_LOATHEB:
                return Encounters[5];
            case DATA_INSTRUCTOR_RAZUVIOUS:
                return Encounters[6];
            case DATA_GOTHIK_THE_HARVESTER:
                return Encounters[7];
            case DATA_THE_FOUR_HORSEMEN:
                return Encounters[8];
            case DATA_PATCHWERK:
                return Encounters[9];
            case DATA_GROBBULUS:
                return Encounters[10];
            case DATA_GLUTH:
                return Encounters[11];
            case DATA_THADDIUS:
                return Encounters[12];
            case DATA_SAPPHIRON:
                return Encounters[13];
            case DATA_KEL_THUZAD:
                return Encounters[14];
            default:
                return 0;
        }
    }

    void SetData64(uint32 type, uint64 data){}

    uint64 GetData64(uint32 identifier)
    {
        switch (identifier)
        {
            case DATA_THADDIUS:
                return m_thaddiusGUID;
            case DATA_STALAGG:
                return m_stalaggGUID;
            case DATA_FEUGEN:
                return m_feugenGUID;
            default:
                return 0;
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
        stream << Encounters[9] << " ";
        stream << Encounters[10] << " ";
        stream << Encounters[11] << " ";
        stream << Encounters[12] << " ";
        stream << Encounters[13] << " ";
        stream << Encounters[14];

        OUT_SAVE_INST_DATA_COMPLETE;

        return stream.str();
    }

    void OnPlayerDeath(Player * plr)
    {
        if (GetData(DATA_ANUB_REKHAN) == IN_PROGRESS)
            plr->CastSpell(plr, SPELL_SELF_SPAWN_5, true);
    }

    void Load(const char* in)
    {
        if (!in)
        {
            OUT_LOAD_INST_DATA_FAIL;
            return;
        }

        OUT_LOAD_INST_DATA(in);
        std::istringstream stream(in);
        stream  >> Encounters[0]
                >> Encounters[1]
                >> Encounters[2]
                >> Encounters[3]
                >> Encounters[4]
                >> Encounters[5]
                >> Encounters[6]
                >> Encounters[7]
                >> Encounters[8]
                >> Encounters[9]
                >> Encounters[10]
                >> Encounters[11]
                >> Encounters[12]
                >> Encounters[13]
                >> Encounters[14];

        for (uint8 i = 0; i < ENCOUNTERS; ++i)
            if (Encounters[i] == IN_PROGRESS) // Do not load an encounter as "In Progress" - reset it instead.
                Encounters[i] = NOT_STARTED;

        OUT_LOAD_INST_DATA_COMPLETE;
    }

    Player* GetPlayer()
    {
        Map::PlayerList const &players = instance->GetPlayers();
        for(Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
        {
            if (i->getSource())
                return i->getSource();
        }
        return NULL;
    }

    void Update(uint32 diff)
    {
        if (screemTimer < diff)
        {
            if (GetData(DATA_THADDIUS) != DONE)
            {
                uint32 sound = RAND(THADDIUS_LAMENT_1, THADDIUS_LAMENT_2, THADDIUS_LAMENT_3, THADDIUS_LAMENT_4);

                Map::PlayerList const &players = instance->GetPlayers();
                for (Map::PlayerList::const_iterator i = players.begin(); i != players.end(); ++i)
                    if (Player *player = i->getSource())
                        player->SendPlaySound(sound, true);
            }

            screemTimer = urand(3*MINUTE*IN_MILISECONDS, 5*MINUTE*IN_MILISECONDS);
        }
    }
};

InstanceData* GetInstanceData_instance_naxxramas(Map* map)
{
    return new instance_naxxramas(map);
}

void AddSC_instance_naxxramas()
{
    Script *newscript;
    newscript = new Script;
    newscript->Name = "instance_naxxramas";
    newscript->GetInstanceData = &GetInstanceData_instance_naxxramas;
    newscript->RegisterSelf();
}
