/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
* This program is free software licensed under GPL version 2
* Please see the included DOCS/LICENSE.TXT for more information */
#ifndef DEF_ZULAMAN_H
#define DEF_ZULAMAN_H

#define AKILZON         "Akil'zon"
#define HEXLORD         "Hex Lord Malacrass"
#define NALORAKK        "Nalorakk"

enum InstanceZA
{
    MAX_ENCOUNTER = 7,
    MAX_VENDOR = 2,

    SAY_INST_RELEASE = -1568067,
    SAY_INST_BEGIN = -1568068,
    SAY_INST_PROGRESS_1 = -1568069,
    SAY_INST_PROGRESS_2 = -1568070,
    SAY_INST_PROGRESS_3 = -1568071,
    SAY_INST_WARN_1 = -1568072,
    SAY_INST_WARN_2 = -1568073,
    SAY_INST_WARN_3 = -1568074,
    SAY_INST_WARN_4 = -1568075,
    SAY_INST_SACRIF1 = -1568076,
    SAY_INST_SACRIF2 = -1568077,
    SAY_INST_COMPLETE = -1568078,
    SAY_INST_PROGRESS_4 = -1568014,
    SAY_INST_PROGRESS_5 = -1568015,

    WORLD_STATE_ID = 3104,
    WORLD_STATE_COUNTER = 3106,

    TYPE_EVENT_RUN = 1,
    TYPE_AKILZON = 2,
    TYPE_NALORAKK = 3,
    TYPE_JANALAI = 4,
    TYPE_HALAZZI = 5,
    TYPE_MALACRASS = 6,
    TYPE_ZULJIN = 7,

    TYPE_RAND_VENDOR_1 = 8,
    TYPE_RAND_VENDOR_2 = 9,

    DATA_AKILZONEVENT = 10,
    DATA_NALORAKKEVENT = 11,
    DATA_JANALAIEVENT = 12,
    DATA_HALAZZIEVENT = 13,
    DATA_HEXLORDEVENT = 14,
    DATA_ZULJINEVENT = 15,
    DATA_HARRISON = 16,
    DATA_SPIRIT_LYNX = 17,
    DATA_CHESTLOOTED = 18,

    DATA_J_EGGS_RIGHT = 19,
    DATA_J_EGGS_LEFT = 20,

    DATA_GO_GONG = 21,
    DATA_GO_MALACRASS_GATE = 22,
    DATA_GO_ENTRANCE = 23,
    DATA_AKILZONGAUNTLET = 24,

    DATA_HOSTAGE_0_STATE = 25,
    DATA_HOSTAGE_TANZAR_STATE = 25,
    DATA_HOSTAGE_HARKOR_STATE = 26,
    DATA_HOSTAGE_KRAZ_STATE = 27,
    DATA_HOSTAGE_ASHLI_STATE = 28,

    DATA_CHEST_0 = 29,
    DATA_CHEST_TANZAR = 29,
    DATA_CHEST_HARKOR = 30,
    DATA_CHEST_KRAZ = 31,
    DATA_CHEST_ASHLI = 32,

    DATA_CHEST_TANZAR_REWARD = 30,
    DATA_CHEST_HARKOR_REWARD = 31,
    DATA_CHEST_KRAZ_REWARD = 32,
    DATA_CHEST_ASHLI_REWARD = 33,

    DATA_ZJ_EVENT = 34,

    NPC_EGG = 23817,
    NPC_SPIRIT_LYNX = 24143
};

enum HostageState
{
    // we can't use data == 3, because it will mess with boss killed number
    HOSTAGE_NOT_SAVED = 0,          // default

    HOSTAGE_REWARD_0 = 1,           // random piece of armor
    HOSTAGE_REWARD_1 = 2,           // random weapon
    HOSTAGE_REWARD_2 = 3,           // random ring
    HOSTAGE_REWARD_3 = 4,           // mount

    HOSTAGE_SAVED = 0x10,             // after killing boss
    HOSTAGE_FREED = 0x20,             // after opening cage
    HOSTAGE_CHEST_UNLOCKED = 0x40,    // after talking to hostage
    HOSTAGE_CHEST_LOOTED = 0x80       // after opening chest
};

struct SHostageInfo
{
    uint32 npc, deadnpc;
    uint32 cage;
    uint32 go;
    float x, y, z, o;
};


extern SHostageInfo HostageInfo[4];
uint8 GetHostageIndex(uint32 entry);

#endif