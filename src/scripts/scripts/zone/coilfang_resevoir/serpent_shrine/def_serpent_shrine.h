/* Copyright (C) 2006 - 2008 ScriptDev2 <https://scriptdev2.svn.sourceforge.net/>
 * This program is free software licensed under GPL version 2
 * Please see the included DOCS/LICENSE.TXT for more information */

#ifndef DEF_SERPENT_SHRINE_H
#define DEF_SERPENT_SHRINE_H

#define MAX_ENCOUNTER 6
#define LURKER_FISHING_INTERNAL_COOLDOWN 7000
#define MOB_GREYHEART_TECHNICIAN 21263
#define SPELL_SCALDINGWATER 37284
#define MOB_COILFANG_FRENZY 21508
#define WATER_Z -19.9f

enum WaterEventState
{
    WATERSTATE_NONE     = 0,
    WATERSTATE_FRENZY   = 1,
    WATERSTATE_SCALDING = 2
};

enum DataTypes
{        
    /* Encounters */
    DATA_HYDROSS_EVENT              = 1,
    DATA_LURKER_EVENT               = 2,
    DATA_LEOTHERAS_EVENT            = 3,
    DATA_KARATHRESS_EVENT           = 4,
    DATA_MOROGRIM_EVENT             = 5,
    DATA_VASHJ_EVENT                = 6,

    /* Creatures */
    DATA_HYDROSS                    = 7,
    DATA_LURKER                     = 8,
    DATA_LEOTHERAS                  = 9,
    DATA_KARATHRESS                 = 10,
    DATA_MOROGRIM                   = 11,
    DATA_VASHJ                      = 12,
    DATA_SHARKKIS                   = 13,
    DATA_TIDALVESS                  = 14,
    DATA_CARIBDIS                   = 15,
    DATA_SHARKKIS_PET               = 16,
    DATA_LEOTHERAS_EVENT_STARTER    = 17,
    DATA_KARATHRESS_EVENT_STARTER   = 18,
    
    /* Misc */
    DATA_BRIDGE_CONSOLE             = 43,
    DATA_LURKER_FISHING_EVENT       = 44,
    DATA_SHIELD_GENERATOR_ONE       = 45,
    DATA_SHIELD_GENERATOR_TWO       = 46,
    DATA_SHIELD_GENERATOR_THREE     = 47,
    DATA_SHIELD_GENERATOR_FOUR      = 48,
    DATA_CAN_START_PHASE_3          = 49,
    DATA_WATER                      = 50,
};

#endif

