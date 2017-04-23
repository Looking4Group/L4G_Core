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
SDName: Azuremyst_Isle
SD%Complete: 75
SDComment: Quest support: 9283, 9528, 9537, 9544, 9582, 9554, 9531, 9303(special flight path, proper model for mount missing). Injured Draenei cosmetic only, 9582
SDCategory: Azuremyst Isle
EndScriptData */

/* ContentData
npc_draenei_survivor
npc_engineer_spark_overgrind
npc_injured_draenei
npc_magwin
npc_susurrus
npc_geezle
mob_nestlewood_owlkin
mob_siltfin_murloc
npc_stillpine_capitive
go_bristlelimb_cage
go_ravager_cage
npc_death_ravager
EndContentData */

#include "precompiled.h"
#include "escort_ai.h"
#include <cmath>

/*######
## npc_draenei_survivor
######*/

#define SAY_HEAL1    -1000248
#define SAY_HEAL2    -1000249
#define SAY_HEAL3    -1000250
#define SAY_HEAL4    -1000251

#define HELP1        -1000252
#define HELP2        -1000253
#define HELP3        -1000254
#define HELP4        -1000255

#define SPELL_IRRIDATION    35046
#define SPELL_STUNNED       28630

struct npc_draenei_survivorAI : public ScriptedAI
{
    npc_draenei_survivorAI(Creature *c) : ScriptedAI(c) {}

    uint64 pCaster;
    uint32 SayThanksTimer;
    uint32 RunAwayTimer;
    uint32 SayHelpTimer;

    bool CanSayHelp;

    void Reset()
    {
        pCaster = 0;
        SayThanksTimer = 0;
        RunAwayTimer = 0;
        SayHelpTimer = 10000;

        CanSayHelp = true;

        me->CastSpell(me, SPELL_IRRIDATION, true);
        me->SetHealth(int(me->GetMaxHealth()*.1));
        me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_SLEEP);
    }

    void EnterCombat(Unit *who) {}

    void MoveInLineOfSight(Unit *who)
    {
        if (CanSayHelp && who->GetTypeId() == TYPEID_PLAYER && me->IsFriendlyTo(who) && me->IsWithinDistInMap(who, 25.0f))
        {
            DoScriptText(RAND(HELP1, HELP2, HELP3, HELP4), me);

            SayHelpTimer = 20000;
            CanSayHelp = false;
        }
    }

    void SpellHit(Unit *Caster, const SpellEntry *Spell)
    {
        if(Spell->Id == 28880)
        {
            me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_PVP_ATTACKABLE);
            me->SetUInt32Value(UNIT_FIELD_BYTES_1, PLAYER_STATE_NONE);
            me->CastSpell(me, SPELL_STUNNED, true);

            pCaster = Caster->GetGUID();

            SayThanksTimer = 5000;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (SayThanksTimer)
        {
            if(SayThanksTimer <= diff)
            {
                me->RemoveAurasDueToSpell(SPELL_IRRIDATION);

                if (Player *pPlayer = (Player*)Unit::GetUnit(*me,pCaster))
                {
                    if (pPlayer->GetTypeId() != TYPEID_PLAYER)
                        return;

                    DoScriptText(RAND(SAY_HEAL1, SAY_HEAL2, SAY_HEAL3, SAY_HEAL4), me, pPlayer);

                    pPlayer->TalkedToCreature(me->GetEntry(),me->GetGUID());
                }

                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MovePoint(0, -4115.053711f, -13754.831055f, 73.508949f);
                RunAwayTimer = 10000;
                SayThanksTimer = 0;

            }
            else
                SayThanksTimer -= diff;

            return;
        }

        if(RunAwayTimer)
        {
            if(RunAwayTimer <= diff)
            {
                me->RemoveAllAuras();
                me->GetMotionMaster()->Clear();
                me->GetMotionMaster()->MoveIdle();
                me->setDeathState(JUST_DIED);
                me->SetHealth(0);
                me->CombatStop();
                me->DeleteThreatList();
                me->RemoveCorpse();
            }
            else
                RunAwayTimer -= diff;

            return;
        }

        if (SayHelpTimer < diff)
        {
            CanSayHelp = true;
            SayHelpTimer = 20000;
        }
        else
            SayHelpTimer -= diff;
    }
};

CreatureAI* GetAI_npc_draenei_survivor(Creature *_Creature)
{
    return new npc_draenei_survivorAI (_Creature);
}

/*######
## npc_sethir_the_ancient
######*/

#define EMOTE_SOUND_DIE                  -1069090

struct npc_sethir_the_ancientAI : public ScriptedAI
{
    npc_sethir_the_ancientAI(Creature *c) : ScriptedAI(c) {}

    uint32 Timer;       // Do not spawn all mobs immediately
    uint32 temp;
    bool pause_say;     // wait some time until say sentence again

    void Reset()
    {
       Timer = 1000;
       pause_say = false;
    }

    void EnterCombat(Unit *who)
    {
        DoScriptText(EMOTE_SOUND_DIE, me);
    }

    void SummonedCreatureDespawn(Creature*)
    {
        EnterEvadeMode();   // evade after 3 seconds if summons do not aggro someone
    }

    void MoveInLineOfSight(Unit *who)
    {
        if (!me->isInCombat() && !pause_say && me->IsWithinDistInMap(who, 30) && me->IsHostileTo(who) && who->HasAuraType(SPELL_AURA_MOD_STEALTH))
        {
            me->Say("I know you are there, rogue. Leave my home or join the others at the bottom of the World Tree!", LANG_UNIVERSAL, 0);
            pause_say = true;
            temp = 60000;
        }
        //if (!me->isInCombat() && me->IsWithinDistInMap(who, 30) && me->IsHostileTo(who)) AttackStart(who);
        ScriptedAI::MoveInLineOfSight(who);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if(temp <= diff)      // after 1 minute he can say it again
        {
            pause_say = false;
            temp = 60000;
        }
        else
            temp -= diff;

        if (Timer)
        {
            if (Timer <= diff)
            {
                Position pos;
                me->GetPosition(pos);

                for (int i=1; i<=6; i++)
                {
                    Creature * tmpC = me->SummonCreature(6911, pos.x, pos.y, pos.z, pos.o, TEMPSUMMON_TIMED_OR_DEAD_DESPAWN, 3000);
                    tmpC->AI()->AttackStart(me->getVictim());
                }

                Timer = 0;
            }
            else
                Timer -= diff;
        }

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_sethir_the_ancient(Creature *_Creature)
{
    return new npc_sethir_the_ancientAI (_Creature);
}

/*######
## npc_engineer_spark_overgrind
######*/

#define SAY_TEXT        -1000256
#define SAY_EMOTE       -1000257
#define ATTACK_YELL     -1000258

#define GOSSIP_FIGHT    "Traitor! You will be brought to justice!"

#define SPELL_DYNAMITE  7978

struct npc_engineer_spark_overgrindAI : public ScriptedAI
{
    npc_engineer_spark_overgrindAI(Creature *c) : ScriptedAI(c) {}

    uint32 Dynamite_Timer;
    uint32 Emote_Timer;

    void Reset()
    {
        Dynamite_Timer = 8000;
        Emote_Timer = 120000 + rand()%30000;
        me->setFaction(875);
    }

    void EnterCombat(Unit *who) { }

    void UpdateAI(const uint32 diff)
    {
        if( !me->isInCombat() )
        {
            if (Emote_Timer < diff)
            {
                DoScriptText(SAY_TEXT, me);
                DoScriptText(SAY_EMOTE, me);
                Emote_Timer = 120000 + rand()%30000;
            }
            else
                Emote_Timer -= diff;
        }

        if(!UpdateVictim())
            return;

        if (Dynamite_Timer < diff)
        {
            DoCast(me->getVictim(), SPELL_DYNAMITE);
            Dynamite_Timer = 8000;
        }
        else
            Dynamite_Timer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_engineer_spark_overgrind(Creature *_Creature)
{
    return new npc_engineer_spark_overgrindAI (_Creature);
}

bool GossipHello_npc_engineer_spark_overgrind(Player *player, Creature *_Creature)
{
    if( player->GetQuestStatus(9537) == QUEST_STATUS_INCOMPLETE )
        player->ADD_GOSSIP_ITEM(0, GOSSIP_FIGHT, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());
    return true;
}

bool GossipSelect_npc_engineer_spark_overgrind(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if( action == GOSSIP_ACTION_INFO_DEF )
    {
        player->CLOSE_GOSSIP_MENU();
        _Creature->setFaction(14);
        DoScriptText(ATTACK_YELL, _Creature, player);
        ((npc_engineer_spark_overgrindAI*)_Creature->AI())->AttackStart(player);
    }
    return true;
}

/*######
## npc_injured_draenei
######*/

struct npc_injured_draeneiAI : public ScriptedAI
{
    npc_injured_draeneiAI(Creature *c) : ScriptedAI(c) {}

    void Reset()
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
        me->SetHealth(int(me->GetMaxHealth()*.15));

        me->SetUInt32Value(UNIT_FIELD_BYTES_1, RAND(PLAYER_STATE_SIT, PLAYER_STATE_SLEEP));
    }

    void EnterCombat(Unit *who) {}

    void MoveInLineOfSight(Unit *who)
    {
        return;                                             //ignore everyone around them (won't aggro anything)
    }

    void UpdateAI(const uint32 diff)
    {
        return;
    }

};
CreatureAI* GetAI_npc_injured_draenei(Creature *_Creature)
{
    return new npc_injured_draeneiAI (_Creature);
}

/*######
## npc_magwin
######*/

enum eMagwin
{
    SAY_START                   = -1000111,
    SAY_AGGRO                   = -1000112,
    SAY_PROGRESS                = -1000113,
    SAY_END1                    = -1000114,
    SAY_END2                    = -1000115,
    EMOTE_HUG                   = -1000116,

    QUEST_A_CRY_FOR_SAY_HELP    = 9528
};

struct npc_magwinAI : public npc_escortAI
{
    npc_magwinAI(Creature *c) : npc_escortAI(c) {}

    void WaypointReached(uint32 i)
    {
        Player* pPlayer = GetPlayerForEscort();

         if (!pPlayer)
            return;

        switch(i)
        {
        case 0:
            DoScriptText(SAY_START, me, pPlayer);
            break;
        case 17:
            DoScriptText(SAY_PROGRESS, me, pPlayer);
            break;
        case 28:
            DoScriptText(SAY_END1, me, pPlayer);
            break;
        case 29:
            DoScriptText(EMOTE_HUG, me, pPlayer);
            DoScriptText(SAY_END2, me, pPlayer);
            pPlayer->GroupEventHappens(QUEST_A_CRY_FOR_SAY_HELP,me);
            break;
        }
    }

    void EnterCombat(Unit* who)
    {
        DoScriptText(SAY_AGGRO, me, who);
    }

    void Reset() { }
};

bool QuestAccept_npc_magwin(Player* pPlayer, Creature* pCreature, Quest const* quest)
{
    if (quest->GetQuestId() == QUEST_A_CRY_FOR_SAY_HELP)
    {
        pCreature->setFaction(113);
        if (npc_escortAI* pEscortAI = CAST_AI(npc_escortAI, pCreature->AI()))
            pEscortAI->Start(true, false, pPlayer->GetGUID());
    }
    return true;
}

CreatureAI* GetAI_npc_magwinAI(Creature *_Creature)
{
    npc_magwinAI* magwinAI = new npc_magwinAI(_Creature);

    magwinAI->AddWaypoint(0, -4784.532227, -11051.060547, 3.484263);
    magwinAI->AddWaypoint(1, -4805.509277, -11037.293945, 3.043942);
    magwinAI->AddWaypoint(2, -4827.826172, -11034.398438, 1.741959);
    magwinAI->AddWaypoint(3, -4852.630859, -11033.695313, 2.208656);
    magwinAI->AddWaypoint(4, -4876.791992, -11034.517578, 3.175228);
    magwinAI->AddWaypoint(5, -4895.486816, -11038.306641, 9.390890);
    magwinAI->AddWaypoint(6, -4915.464844, -11048.402344, 12.369793);
    magwinAI->AddWaypoint(7, -4937.288086, -11067.041992, 13.857983);
    magwinAI->AddWaypoint(8, -4966.577637, -11067.507813, 15.754786);
    magwinAI->AddWaypoint(9, -4993.799805, -11056.544922, 19.175295);
    magwinAI->AddWaypoint(10, -5017.836426, -11052.569336, 22.476587);
    magwinAI->AddWaypoint(11, -5039.706543, -11058.459961, 25.831593);
    magwinAI->AddWaypoint(12, -5057.289063, -11045.474609, 26.972496);
    magwinAI->AddWaypoint(13, -5078.828125, -11037.601563, 29.053417);
    magwinAI->AddWaypoint(14, -5104.158691, -11039.195313, 29.440195);
    magwinAI->AddWaypoint(15, -5120.780273, -11039.518555, 30.142139);
    magwinAI->AddWaypoint(16, -5140.833008, -11039.810547, 28.788074);
    magwinAI->AddWaypoint(17, -5161.201660, -11040.050781, 27.879545, 4000);
    magwinAI->AddWaypoint(18, -5171.842285, -11046.803711, 27.183821);
    magwinAI->AddWaypoint(19, -5185.995117, -11056.359375, 20.234867);
    magwinAI->AddWaypoint(20, -5198.485840, -11065.065430, 18.872593);
    magwinAI->AddWaypoint(21, -5214.062500, -11074.653320, 19.215731);
    magwinAI->AddWaypoint(22, -5220.157227, -11088.377930, 19.818476);
    magwinAI->AddWaypoint(23, -5233.652832, -11098.846680, 18.349432);
    magwinAI->AddWaypoint(24, -5250.163086, -11111.653320, 16.438959);
    magwinAI->AddWaypoint(25, -5268.194336, -11125.639648, 12.668313);
    magwinAI->AddWaypoint(26, -5286.270508, -11130.669922, 6.912246);
    magwinAI->AddWaypoint(27, -5317.449707, -11137.392578, 4.963446);
    magwinAI->AddWaypoint(28, -5334.854492, -11154.384766, 6.742664);
    magwinAI->AddWaypoint(29, -5353.874512, -11171.595703, 6.903912, 20000);
    magwinAI->AddWaypoint(30, -5354.240000, -11171.940000, 6.890000);

    return (CreatureAI*)magwinAI;
}

/*######
## npc_susurrus
######*/

bool GossipHello_npc_susurrus(Player *player, Creature *_Creature)
{
    if (_Creature->isQuestGiver())
        player->PrepareQuestMenu( _Creature->GetGUID() );

    if (player->HasItemCount(23843,1,true))
        player->ADD_GOSSIP_ITEM(0, "I am ready.", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);

    player->SEND_GOSSIP_MENU(_Creature->GetNpcTextId(), _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_susurrus(Player *player, Creature *_Creature, uint32 sender, uint32 action )
{
    if (action == GOSSIP_ACTION_INFO_DEF)
    {
        player->CLOSE_GOSSIP_MENU();
        player->CastSpell(player,32474,true);               //apparently correct spell, possible not correct place to cast, or correct caster

        std::vector<uint32> nodes;

        nodes.resize(2);
        nodes[0] = 92;                                      //from susurrus
        nodes[1] = 91;                                      //end at exodar
        player->ActivateTaxiPathTo(nodes,11686);            //TaxiPath 506. Using invisible model, possible Trinity must allow 0(from dbc) for cases like this.
    }
    return true;
}

/*######
## npc_geezle
######*/

#define GEEZLE_SAY_1    -1000259
#define SPARK_SAY_2     -1000260
#define SPARK_SAY_3     -1000261
#define GEEZLE_SAY_4    -1000262
#define SPARK_SAY_5     -1000263
#define SPARK_SAY_6     -1000264
#define GEEZLE_SAY_7    -1000265

#define EMOTE_SPARK     -1000266

#define MOB_SPARK       17243
#define GO_NAGA_FLAG    181694

static float SparkPos[3] = {-5030.95, -11291.99, 7.97};

struct npc_geezleAI : public ScriptedAI
{
    npc_geezleAI(Creature *c) : ScriptedAI(c) {}

    std::list<GameObject*> FlagList;

    uint64 SparkGUID;

    uint32 Step;
    uint32 SayTimer;

    bool EventStarted;

    void Reset()
    {
        SparkGUID = 0;
        Step = 0;
        StartEvent();
    }

    void StartEvent()
    {
        Step = 1;
        EventStarted = true;
        Creature* Spark = me->SummonCreature(MOB_SPARK, SparkPos[0], SparkPos[1], SparkPos[2], 0, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 1000);
        if(Spark)
        {
            SparkGUID = Spark->GetGUID();
            Spark->setActive(true);
            Spark->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
            Spark->GetMotionMaster()->MovePoint(0, -5080.70, -11253.61, 0.56);
        }
        me->GetMotionMaster()->MovePoint(0, -5092.26, -11252, 0.71);
        SayTimer = 23000;
    }

    uint32 NextStep(uint32 Step)
    {
        Unit* Spark = Unit::GetUnit((*me), SparkGUID);

        switch(Step)
        {
        case 0: return 99999;
        case 1:
            //DespawnNagaFlag(true);
            DoScriptText(EMOTE_SPARK, Spark);
            return 1000;
        case 2:
            DoScriptText(GEEZLE_SAY_1, me, Spark);
            if(Spark)
            {
                Spark->SetInFront(me);
                me->SetInFront(Spark);
            }
            return 5000;
        case 3: DoScriptText(SPARK_SAY_2, Spark); return 7000;
        case 4: DoScriptText(SPARK_SAY_3, Spark); return 8000;
        case 5: DoScriptText(GEEZLE_SAY_4, me, Spark); return 8000;
        case 6: DoScriptText(SPARK_SAY_5, Spark); return 9000;
        case 7: DoScriptText(SPARK_SAY_6, Spark); return 8000;
        case 8: DoScriptText(GEEZLE_SAY_7, me, Spark); return 2000;
        case 9:
            me->GetMotionMaster()->MoveTargetedHome();
            if(Spark)
                Spark->GetMotionMaster()->MovePoint(0, -5030.95, -11291.99, 7.97);
            return 20000;
        case 10:
            if(Spark)
                Spark->DealDamage(Spark,Spark->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            //DespawnNagaFlag(false);
            me->SetVisibility(VISIBILITY_OFF);
        default: return 99999999;
        }
    }

    void DespawnNagaFlag(bool despawn)
    {
        Looking4group::AllGameObjectsWithEntryInGrid go_check(GO_NAGA_FLAG);
        Looking4group::ObjectListSearcher<GameObject, Looking4group::AllGameObjectsWithEntryInGrid> go_search(FlagList, go_check);
        Cell::VisitGridObjects(me, go_search, me->GetMap()->GetVisibilityDistance());

        Player* player = NULL;
        if (!FlagList.empty())
        {
            for(std::list<GameObject*>::iterator itr = FlagList.begin(); itr != FlagList.end(); ++itr)
            {
                //TODO: Found how to despawn and respawn
                if(despawn)
                    (*itr)->RemoveFromWorld();
                else
                    (*itr)->Respawn();
            }
        }
        else
            error_log("SD2 ERROR: FlagList is empty!");
    }

    void UpdateAI(const uint32 diff)
    {
        if(SayTimer < diff)
        {
            if(EventStarted)
            {
                SayTimer = NextStep(++Step);
            }
        }
        else
            SayTimer -= diff;
    }
};

CreatureAI* GetAI_npc_geezleAI(Creature *_Creature)
{
    return new npc_geezleAI(_Creature);
}

/*######
## mob_nestlewood_owlkin
######*/

#define INOCULATION_CHANNEL 29528
#define INOCULATED_OWLKIN   16534

struct mob_nestlewood_owlkinAI : public ScriptedAI
{
    mob_nestlewood_owlkinAI(Creature *c) : ScriptedAI(c) {}

    uint32 ChannelTimer;
    bool Channeled;
    bool Hitted;

    void Reset()
    {
        ChannelTimer = 0;
        Channeled = false;
        Hitted = false;
    }

    void EnterCombat(Unit *who){}

    void SpellHit(Unit* caster, const SpellEntry* spell)
    {
        if(!caster)
            return;

        if(caster->GetTypeId() == TYPEID_PLAYER && spell->Id == INOCULATION_CHANNEL)
        {
            ChannelTimer = 3000;
            Hitted = true;
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if(ChannelTimer < diff && !Channeled && Hitted)
        {
            me->DealDamage(me, me->GetHealth(), DIRECT_DAMAGE, SPELL_SCHOOL_MASK_NORMAL, NULL, false);
            me->RemoveCorpse();
            me->SummonCreature(INOCULATED_OWLKIN, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN, 180000);
            Channeled = true;
        }
        else
            ChannelTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_mob_nestlewood_owlkinAI(Creature *_Creature)
{
    return new mob_nestlewood_owlkinAI (_Creature);
}

/*######
## mob_siltfin_murloc
######*/

struct mob_siltfin_murlocAI : public ScriptedAI
{
    mob_siltfin_murlocAI(Creature *c) : ScriptedAI(c) {}

    void EnterCombat(Unit *who){}

    void JustDied(Unit *player)
    {
        player = player->GetCharmerOrOwnerPlayerOrPlayerItself();

        if(roll_chance_i(20) && player)
        {
            if(((Player*)player)->GetQuestStatus(9595) == QUEST_STATUS_INCOMPLETE)
            {
                 Unit* summon = me->SummonCreature(17612, me->GetPositionX(), me->GetPositionY(), me->GetPositionZ(), 0.0f, TEMPSUMMON_TIMED_DESPAWN_OUT_OF_COMBAT, 30000);
                 player->CastSpell(summon, 30790, false);
            }
        }
     }

};

CreatureAI* GetAI_mob_siltfin_murlocAI(Creature *_Creature)
{
    return new mob_siltfin_murlocAI (_Creature);
}

/*######
## npc_death_ravager
######*/

enum eRavegerCage
{
    NPC_DEATH_RAVAGER       = 17556,

    SPELL_REND              = 13443,
    SPELL_ENRAGING_BITE     = 30736,

    QUEST_STRENGTH_ONE      = 9582
};

bool go_ravager_cage(Player* pPlayer, GameObject* pGo)
{

    if (pPlayer->GetQuestStatus(QUEST_STRENGTH_ONE) == QUEST_STATUS_INCOMPLETE)
    {
        if (Creature* ravager = GetClosestCreatureWithEntry(pGo, NPC_DEATH_RAVAGER, 5.0f))
        {
            ravager->RemoveFlag(UNIT_FIELD_FLAGS,UNIT_FLAG_NON_ATTACKABLE);
            ravager->SetReactState(REACT_AGGRESSIVE);
            ravager->AI()->AttackStart(pPlayer);
        }
    }
    return true ;
}

struct npc_death_ravagerAI : public ScriptedAI
{
    npc_death_ravagerAI(Creature *c) : ScriptedAI(c){}

    uint32 RendTimer;
    uint32 EnragingBiteTimer;

    void Reset()
    {
        RendTimer = 30000;
        EnragingBiteTimer = 20000;

        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        me->SetReactState(REACT_PASSIVE);
    }

    void UpdateAI(const uint32 diff)
    {
        if (!UpdateVictim())
            return;

        if (RendTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_REND);
            RendTimer = 30000;
        }
        else RendTimer -= diff;

        if (EnragingBiteTimer <= diff)
        {
            DoCast(me->getVictim(), SPELL_ENRAGING_BITE);
            EnragingBiteTimer = 15000;
        }
        else EnragingBiteTimer -= diff;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_death_ravagerAI(Creature* pCreature)
{
    return new npc_death_ravagerAI(pCreature);
}

/*########
## Quest: The Prophecy of Akida
########*/

enum BristlelimbCage
{
    CAPITIVE_SAY_1                      = -1600474,
    CAPITIVE_SAY_2                      = -1600475,
    CAPITIVE_SAY_3                      = -1600476,

    QUEST_THE_PROPHECY_OF_AKIDA         = 9544,
    NPC_STILLPINE_CAPITIVE              = 17375,
    GO_BRISTELIMB_CAGE                  = 181714

};


struct npc_stillpine_capitiveAI : public ScriptedAI
{
    npc_stillpine_capitiveAI(Creature *c) : ScriptedAI(c){}

    uint32 FleeTimer;

    void Reset()
    {
        FleeTimer = 0;
        GameObject* cage = FindGameObject(GO_BRISTELIMB_CAGE, 5.0f, me);
        if(cage)
            cage->ResetDoorOrButton();
    }

    void UpdateAI(const uint32 diff)
    {
    }
};

CreatureAI* GetAI_npc_stillpine_capitiveAI(Creature* pCreature)
{
    return new npc_stillpine_capitiveAI(pCreature);
}

bool go_bristlelimb_cage(Player* pPlayer, GameObject* pGo)
{
    if(pPlayer->GetQuestStatus(QUEST_THE_PROPHECY_OF_AKIDA) == QUEST_STATUS_INCOMPLETE)
    {
        Creature* pCreature = GetClosestCreatureWithEntry(pGo, NPC_STILLPINE_CAPITIVE, 5.0f);
        if(pCreature)
        {
            DoScriptText(RAND(CAPITIVE_SAY_1, CAPITIVE_SAY_2, CAPITIVE_SAY_3), pCreature, pPlayer);
            pCreature->GetMotionMaster()->MoveFleeing(pPlayer, 3500);
            pPlayer->KilledMonster(pCreature->GetEntry(), pCreature->GetGUID());
            pCreature->ForcedDespawn(3500);
            return false;
        }
    }
    return true;
}

/*######
## Quest: Matis the Cruel
######*/

#define NPC_MATIS    17664
#define SAY_1        -1900255
#define SAY_2        -1900256

struct npc_trackerAI : public ScriptedAI
{
    npc_trackerAI(Creature* creature) : ScriptedAI(creature) {}

    TimeTrackerSmall CheckTimer;

    void Reset()
    {
        CheckTimer.Reset(2000);
        DoScriptText(SAY_1, me);
        me->setFaction(1700);
        if (Creature* Matis = GetClosestCreatureWithEntry(me, NPC_MATIS, 35.0f))
            me->AI()->AttackStart(Matis);
    }

    void Credit()
    { 
        Map* map = me->GetMap();
        Map::PlayerList const &PlayerList = map->GetPlayers();

        for (Map::PlayerList::const_iterator itr = PlayerList.begin(); itr != PlayerList.end(); ++itr)
        {
            if (Player* player = itr->getSource())
            {
                if (me->IsWithinDistInMap(player, 35.0f) && (player->GetQuestStatus(9711) == QUEST_STATUS_INCOMPLETE))
                    player->GroupEventHappens(9711, me);
            }
        }
    }

    void EnterEvadeMode()
    {
        me->DeleteThreatList();
        me->CombatStop(true);
    }

    void UpdateAI(const uint32 diff)
    {
        CheckTimer.Update(diff);

        if (CheckTimer.Passed())
        {
            if (Creature* Matis = GetClosestCreatureWithEntry(me, NPC_MATIS, 35.0f))
            {
                if ((Matis->GetHealth())*100 / Matis->GetMaxHealth() < 25)
                {
                    me->AI()->EnterEvadeMode();
                    Matis->setFaction(35);
                    Matis->CombatStop();
                    Matis->DeleteThreatList();
                    Matis->SetHealth(Matis->GetMaxHealth());
                    Matis->SetStandState(UNIT_STAND_STATE_KNEEL);
                    DoScriptText(SAY_2, me);
                    Credit();
                    Matis->ForcedDespawn(30000);
                    me->ForcedDespawn(35000);
                }
            }
            else
               {
                   if (Creature* Matis = GetClosestCreatureWithEntry(me, NPC_MATIS, 55.0f, false))
                       Matis->setFaction(1701);
               }

            CheckTimer.Reset(1000);
        }

        if (!UpdateVictim())
            return;

        DoMeleeAttackIfReady();
    }
};

CreatureAI* GetAI_npc_tracker(Creature* creature)
{
    return new npc_trackerAI (creature);
}

void AddSC_azuremyst_isle()
{
    Script *newscript;

    newscript = new Script;
    newscript->Name="npc_sethir_the_ancient";
    newscript->GetAI = &GetAI_npc_sethir_the_ancient;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_draenei_survivor";
    newscript->GetAI = &GetAI_npc_draenei_survivor;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_engineer_spark_overgrind";
    newscript->GetAI = &GetAI_npc_engineer_spark_overgrind;
    newscript->pGossipHello =  &GossipHello_npc_engineer_spark_overgrind;
    newscript->pGossipSelect = &GossipSelect_npc_engineer_spark_overgrind;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_injured_draenei";
    newscript->GetAI = &GetAI_npc_injured_draenei;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_magwin";
    newscript->GetAI = &GetAI_npc_magwinAI;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_magwin;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_susurrus";
    newscript->pGossipHello =  &GossipHello_npc_susurrus;
    newscript->pGossipSelect = &GossipSelect_npc_susurrus;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_geezle";
    newscript->GetAI = &GetAI_npc_geezleAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_nestlewood_owlkin";
    newscript->GetAI = &GetAI_mob_nestlewood_owlkinAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="mob_siltfin_murloc";
    newscript->GetAI = &GetAI_mob_siltfin_murlocAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_death_ravager";
    newscript->GetAI = &GetAI_npc_death_ravagerAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_ravager_cage";
    newscript->pGOUse = &go_ravager_cage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_stillpine_capitive";
    newscript->GetAI = &GetAI_npc_stillpine_capitiveAI;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="go_bristlelimb_cage";
    newscript->pGOUse = &go_bristlelimb_cage;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name="npc_tracker";
    newscript->GetAI = &GetAI_npc_tracker;
    newscript->RegisterSelf();
}
