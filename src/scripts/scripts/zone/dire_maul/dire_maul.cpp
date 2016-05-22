/* ScriptData
SDName: Dire_Maul
SD%Complete: ?
SDComment: Quest support: 7481, 7482
SDCategory: Dire_Maul
EndScriptData */

/* ContentData
go_kariel_remains
EndContentData */

#include "precompiled.h"

#define QUEST_ELVEN_LEGENDS_HORDE 7481
#define QUEST_ELVEN_LEGENDS_ALLY 7482
bool GOUse_go_kariel_remains(Player *player, GameObject* _GO)
{
    player->AreaExploredOrEventHappens(QUEST_ELVEN_LEGENDS_ALLY);
    player->AreaExploredOrEventHappens(QUEST_ELVEN_LEGENDS_HORDE);
    return true;
}

void AddSC_dire_maul()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name="go_kariel_remains";
    newscript->pGOUse =  &GOUse_go_kariel_remains;
    newscript->RegisterSelf();
}