//add here most rarely modified headers to speed up debug build compilation
#include "WorldSocket.h"                                    // must be first to make ACE happy with ACE includes in it
#include "Common.h"

#include "MapManager.h"
#include "Log.h"
#include "ObjectAccessor.h"
#include "ObjectGuid.h"
#include "SQLStorage.h"
#include "Opcodes.h"
#include "SharedDefines.h"
#include "ObjectMgr.h"
#include "ScriptMgr.h"
