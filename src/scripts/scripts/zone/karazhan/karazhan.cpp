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
SDName: Karazhan
SD%Complete: 100
SDComment: Support for Berthold (Doorman), Support for Quest 9645.
SDCategory: Karazhan
EndScriptData */

/* ContentData
npc_berthold
npc_image_of_medivh
EndContentData */

#include "precompiled.h"
#include "def_karazhan.h"

/*###
# npc_berthold
####*/

#define SPELL_TELEPORT           39567

#define GOSSIP_ITEM_PLACE        "What is this place?"
#define GOSSIP_ITEM_MEDIVH       "Where is Medivh?"
#define GOSSIP_ITEM_TOWER        "How do you navigate the tower?"
#define GOSSIP_ITEM_TELEPORT     "Please transport me to the Guardian's Library."

bool GossipHello_npc_berthold(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = (_Creature->GetInstanceData());
                                                            // Check if Shade of Aran is dead or not
    bool aranDone = false;
    if(pInstance && (pInstance->GetData(DATA_SHADEOFARAN_EVENT) >= DONE))
        aranDone = true;

    _Creature->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
    
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_PLACE, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_MEDIVH, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TOWER, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 3);
    if (aranDone)
        player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_TELEPORT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 4);

    if (aranDone)
        player->SEND_GOSSIP_MENU(25044, _Creature->GetGUID());
    else
        player->SEND_GOSSIP_MENU(25035, _Creature->GetGUID());
    
    return true;
}

bool GossipSelect_npc_berthold(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    _Creature->HandleEmoteCommand(EMOTE_ONESHOT_TALK);

    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(25036, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(25037, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 3:
            player->SEND_GOSSIP_MENU(25038, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 4:
            player->CastSpell(player, SPELL_TELEPORT, true);
            player->CLOSE_GOSSIP_MENU();
            break;
    }
    return true;
}


/*###
# npc_calliard
####*/

#define GOSSIP_ITEM_MIDNIGHT    "Who is Midnight?"

#define CALLIARD_SAY1           "Who goes there?"
#define CALLIARD_SAY2           "All quiet."
#define CALLIARD_SAY3           "Am I hearing things?"

struct npc_calliardAI : public ScriptedAI
{
    npc_calliardAI(Creature* c) : ScriptedAI(c) {}

    uint32 Timer;

    void Reset()
    {
        Timer = 60000;
    }

    void UpdateAI(const uint32 diff)
    {
        if (Timer < diff)
        {
            me->Say(RAND<const char*>(CALLIARD_SAY1, CALLIARD_SAY2, CALLIARD_SAY3), 0, 0);
            Timer = urand(60000, 180000);
        } 
        else
            Timer -= diff;

    }    
};

CreatureAI* GetAI_npc_calliard(Creature *_Creature)
{
    return new npc_calliardAI(_Creature);
}

bool GossipHello_npc_calliard(Player* player, Creature* _Creature)
{
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_MIDNIGHT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
    player->SEND_GOSSIP_MENU(25042, _Creature->GetGUID());
    
    return true;
}

bool GossipSelect_npc_calliard(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->SEND_GOSSIP_MENU(25043, _Creature->GetGUID());
            break;
    }
    return true;
}

/*###
# npc_hastings
####*/

#define GOSSIP_ITEM_HELP    "Help you with what situation?"
#define GOSSIP_ITEM_BIG     "Big ones?"

bool GossipHello_npc_hastings(Player* player, Creature* _Creature)
{
    player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_HELP, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
    player->SEND_GOSSIP_MENU(25039, _Creature->GetGUID());
    
    return true;
}

bool GossipSelect_npc_hastings(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    switch (action)
    {
        case GOSSIP_ACTION_INFO_DEF + 1:
            player->ADD_GOSSIP_ITEM(0, GOSSIP_ITEM_BIG, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 2);
            player->SEND_GOSSIP_MENU(25040, _Creature->GetGUID());
            break;
        case GOSSIP_ACTION_INFO_DEF + 2:
            player->SEND_GOSSIP_MENU(25041, _Creature->GetGUID());
            break;
    }
    return true;
}




/*###
# npc_image_of_medivh
####*/

#define SAY_DIALOG_MEDIVH_1         "You've got my attention, dragon. You'll find I'm not as easily scared as the villagers below."
#define SAY_DIALOG_ARCANAGOS_2      "Your dabbling in the arcane has gone too far, Medivh. You've attracted the attention of powers beyond your understanding. You must leave Karazhan at once!"
#define SAY_DIALOG_MEDIVH_3         "You dare challenge me at my own dwelling? Your arrogance is astounding, even for a dragon!"
#define SAY_DIALOG_ARCANAGOS_4      "A dark power seeks to use you, Medivh! If you stay, dire days will follow. You must hurry, we don't have much time!"
#define SAY_DIALOG_MEDIVH_5         "I do not know what you speak of, dragon... but I will not be bullied by this display of insolence. I'll leave Karazhan when it suits me!"
#define SAY_DIALOG_ARCANAGOS_6      "You leave me no alternative. I will stop you by force if you won't listen to reason!"
#define EMOTE_DIALOG_MEDIVH_7       "begins to cast a spell of great power, weaving his own essence into the magic."
#define SAY_DIALOG_ARCANAGOS_8      "What have you done, wizard? This cannot be! I'm burning from... within!"
#define SAY_DIALOG_MEDIVH_9         "He should not have angered me. I must go... recover my strength now..."

#define MOB_ARCANAGOS               17652
#define SPELL_FIRE_BALL             30967
#define SPELL_UBER_FIREBALL         30971
#define SPELL_CONFLAGRATION_BLAST   30977
#define SPELL_MANA_SHIELD           31635

static float MedivPos[4] = {-11161.49,-1902.24,91.48,1.94};
static float ArcanagosPos[4] = {-11169.75,-1881.48,95.39,4.83};

struct npc_image_of_medivhAI : public ScriptedAI
{
    npc_image_of_medivhAI(Creature* c) : ScriptedAI(c)
    {
        pInstance = (c->GetInstanceData());
    }

    ScriptedInstance *pInstance;

    uint64 ArcanagosGUID;

    uint32 YellTimer;
    uint32 Step;
    uint32 FireMedivhTimer;
    uint32 FireArcanagosTimer;

    bool EventStarted;

    void Reset()
    {
        ArcanagosGUID = 0;

        if(pInstance && pInstance->GetData64(DATA_IMAGE_OF_MEDIVH) == 0)
        {
            pInstance->SetData64(DATA_IMAGE_OF_MEDIVH, m_creature->GetGUID());
            (*m_creature).GetMotionMaster()->MovePoint(1,MedivPos[0],MedivPos[1],MedivPos[2]);
            Step = 0;
        }else
        {
            m_creature->DealDamage(m_creature,m_creature->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            m_creature->RemoveCorpse();
        }
    }
    void Aggro(Unit* who){}

    void MovementInform(uint32 type, uint32 id)
    {
        if(type != POINT_MOTION_TYPE)
            return;
        if(id == 1)
        {
            StartEvent();
            m_creature->SetOrientation(MedivPos[3]);
            m_creature->SetOrientation(MedivPos[3]);
        }
    }

    void StartEvent()
    {
        Step = 1;
        EventStarted = true;
        Creature* Arcanagos = m_creature->SummonCreature(MOB_ARCANAGOS,ArcanagosPos[0],ArcanagosPos[1],ArcanagosPos[2],0,TEMPSUMMON_CORPSE_TIMED_DESPAWN,20000);
        if(!Arcanagos)
            return;
        ArcanagosGUID = Arcanagos->GetGUID();
        Arcanagos->SetLevitate(true);
        (*Arcanagos).GetMotionMaster()->MovePoint(0,ArcanagosPos[0],ArcanagosPos[1],ArcanagosPos[2]);
        Arcanagos->SetOrientation(ArcanagosPos[3]);
        m_creature->SetOrientation(MedivPos[3]);
        YellTimer = 10000;
    }


    uint32 NextStep(uint32 Step)
    {
        Unit* arca = Unit::GetUnit((*m_creature),ArcanagosGUID);
        Map *map = m_creature->GetMap();
        switch(Step)
        {
            case 0: return 9999999;
            case 1:
                m_creature->Yell(SAY_DIALOG_MEDIVH_1, LANG_UNIVERSAL, 0);
                return 10000;
            case 2:
                if(arca)
                    ((Creature*)arca)->Yell(SAY_DIALOG_ARCANAGOS_2, LANG_UNIVERSAL, 0);
                return 20000;
            case 3:
                m_creature->Yell(SAY_DIALOG_MEDIVH_3,LANG_UNIVERSAL,0);
                return 10000;
            case 4:
                if(arca)
                    ((Creature*)arca)->Yell(SAY_DIALOG_ARCANAGOS_4, LANG_UNIVERSAL, 0);
                return 20000;
            case 5:
                m_creature->Yell(SAY_DIALOG_MEDIVH_5, LANG_UNIVERSAL, 0);
                return 20000;
            case 6:
                if(arca)
                    ((Creature*)arca)->Yell(SAY_DIALOG_ARCANAGOS_6, LANG_UNIVERSAL, 0);
                return 10000;
            case 7:
                FireArcanagosTimer = 500;
                return 5000;
            case 8:
                FireMedivhTimer = 500;
                DoCast(m_creature, SPELL_MANA_SHIELD);
                return 10000;
            case 9:
                m_creature->TextEmote(EMOTE_DIALOG_MEDIVH_7, 0, false);
                return 10000;
            case 10:
                if(arca)
                    m_creature->CastSpell(arca, SPELL_CONFLAGRATION_BLAST, false);
                return 1000;
            case 11:
                if(arca)
                    ((Creature*)arca)->Yell(SAY_DIALOG_ARCANAGOS_8, LANG_UNIVERSAL, 0);
                return 5000;
            case 12:
                arca->GetMotionMaster()->MovePoint(0, -11010.82,-1761.18, 156.47);
                arca->setActive(true);
                arca->InterruptNonMeleeSpells(true);
                arca->SetSpeed(MOVE_FLIGHT, 2.0f);
                return 10000;
            case 13:
                m_creature->Yell(SAY_DIALOG_MEDIVH_9, LANG_UNIVERSAL, 0);
                return 10000;
            case 14:
                m_creature->SetVisibility(VISIBILITY_OFF);
                m_creature->ClearInCombat();

                if(map->IsDungeon())
                {
                    InstanceMap::PlayerList const &PlayerList = ((InstanceMap*)map)->GetPlayers();
                    for (InstanceMap::PlayerList::const_iterator i = PlayerList.begin(); i != PlayerList.end(); ++i)
                    {
                        if(i->getSource()->isAlive())
                        {
                            if(i->getSource()->GetQuestStatus(9645) == QUEST_STATUS_INCOMPLETE)
                                i->getSource()->CompleteQuest(9645);
                        }
                    }
                }
                return 50000;
            case 15:
                arca->DealDamage(arca,arca->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
                return 5000;
            default : return 9999999;
        }

    }

    void UpdateAI(const uint32 diff)
    {

        if(YellTimer < diff)
        {
            if(EventStarted)
            {
                YellTimer = NextStep(Step++);
            }
        }else YellTimer -= diff;

        if(Step >= 7 && Step <= 12 )
        {
            Unit* arca = Unit::GetUnit((*m_creature),ArcanagosGUID);

            if(FireArcanagosTimer < diff)
            {
                if(arca)
                    arca->CastSpell(m_creature, SPELL_FIRE_BALL, false);
                FireArcanagosTimer = 6000;
            }else FireArcanagosTimer -= diff;

            if(FireMedivhTimer < diff)
            {
                if(arca)
                    DoCast(arca, SPELL_FIRE_BALL);
                FireMedivhTimer = 5000;
            }else FireMedivhTimer -= diff;

        }
    }
};

CreatureAI* GetAI_npc_image_of_medivh(Creature *_Creature)
{
    return new npc_image_of_medivhAI(_Creature);
}

void AddSC_karazhan()
{
    Script* newscript;

    newscript = new Script;
    newscript->Name = "npc_berthold";
    newscript->pGossipHello = &GossipHello_npc_berthold;
    newscript->pGossipSelect = &GossipSelect_npc_berthold;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_calliard";
    newscript->GetAI = &GetAI_npc_calliard;
    newscript->pGossipHello = &GossipHello_npc_calliard;
    newscript->pGossipSelect = &GossipSelect_npc_calliard;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_hastings";
    newscript->pGossipHello = &GossipHello_npc_hastings;
    newscript->pGossipSelect = &GossipSelect_npc_hastings;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_image_of_medivh";
    newscript->GetAI = &GetAI_npc_image_of_medivh;
    newscript->RegisterSelf();
}
