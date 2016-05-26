#ifndef DEF_MECHANAR_H
#define DEF_MECHANAR_H

#define DATA_NETHERMANCER_EVENT     1
#define DATA_IRONHAND_EVENT         2
#define DATA_GYROKILL_EVENT         3
#define DATA_CACHE_OF_LEGION_EVENT  4
#define DATA_MECHANO_LORD_EVENT     5
#define DATA_BRIDGE_EVENT           6

#define GET_CHARGE_ID(p) ( (p)->HasAura(39088, 0) ? (1) : ( (p)->HasAura(39091, 0) ? (-1) : (0) ))

#endif

