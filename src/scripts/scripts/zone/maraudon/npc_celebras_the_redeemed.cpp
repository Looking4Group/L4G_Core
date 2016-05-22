#include "precompiled.h"

/*######
## npc_celebras_the_redeemed
######*/

enum Enums
{
    QUEST_THE_SCEPTER_OF_CELEBRAS = 7046,
    SPELL_REJUVATION_VISUAL = 32994,
    GO_BLUE_AURA = 310001,
    GO_STAFF_STONE = 178560,

    SAY_1 = -1586001,
    SAY_2 = -1586002,
    SAY_3 = -1586003,
    SAY_4 = -1586004,
    SAY_5 = -1586005,
    SAY_6 = -1586006,
    SAY_7 = -1586007
};

static float P[10][4] =
{
    { 656.20f, 86.48f, -86.83f, 4.40f  },
    { 657.56f, 78.27f, -86.83f, 4.56f  },
    { 657.17f, 73.47f, -86.83f, 3.024f },
    { 654.07f, 73.83f, -86.12, 3.024f  },
    { 657.17f, 73.47f, -86.83f, 3.024f },
    { 655.28f, 66.52f, -86.83f, 4.55f  },
    { 649.58f, 65.97f, -86.73f, 0.61f  },
    { 655.28f, 66.52f, -86.83f, 1.41f  },
    { 657.56f, 78.27f, -86.83f, 4.56f  },
    { 654.13f, 84.50f, -86.83f, 5.718f },
};

struct npc_celebras_the_redeemedAI : public ScriptedAI
{
    npc_celebras_the_redeemedAI(Creature *c) : ScriptedAI(c) {}

    uint32 waitTimer;
    uint8 currentPhase;
    bool isMoving;
    Player* pInvoker;
    GameObject* gAura;

    void Reset()
    {
        waitTimer = 0;
        currentPhase = 0;
        isMoving = false;
        pInvoker = NULL;
        gAura = NULL;
    };

    void StartEvent(Player* _pInvoker)
    {
        me->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

        DoScriptText(SAY_1, me);
        currentPhase = 1;
        pInvoker = _pInvoker;
    }

    void FinishEvent()
    {
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_QUESTGIVER);

        if (pInvoker)
        {
            if (Group *pGroup = CAST_PLR(pInvoker)->GetGroup())
            {
                for (GroupReference *itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                {
                    Player *pGroupMember = itr->getSource();

                    // for any leave or dead (with not released body) group member at appropriate distance
                    if (pGroupMember && pGroupMember->IsAtGroupRewardDistance(me) && pGroupMember->GetQuestStatus(QUEST_THE_SCEPTER_OF_CELEBRAS) == QUEST_STATUS_INCOMPLETE)
                        pGroupMember->CompleteQuest(QUEST_THE_SCEPTER_OF_CELEBRAS);
                }
            }
            else if (CAST_PLR(pInvoker)->GetQuestStatus(QUEST_THE_SCEPTER_OF_CELEBRAS) == QUEST_STATUS_INCOMPLETE)
                CAST_PLR(pInvoker)->CompleteQuest(QUEST_THE_SCEPTER_OF_CELEBRAS);
        }
    }

    void UpdateAI(const uint32 diff)
    {
        if (isMoving)
            return;

        if (waitTimer)
        {
            if (waitTimer <= diff)
            {
                waitTimer = 0;
                ++currentPhase;
            }
            else
            {
                waitTimer -= diff;
                return;
            }
        }

        if (currentPhase)
        {
            switch (currentPhase)
            {
                case 1:
                {
                    MovePoint(0, P[0][0], P[0][1], P[0][2]);
                    break;
                }
                case 2:
                {
                    waitTimer = 2000;
                    me->AddUnitMovementFlag(MOVEFLAG_WALK_MODE);
                    break;
                }
                case 3:
                {
                    waitTimer = 5000;
                    DoScriptText(SAY_2, me);
                    break;
                }
                case 4:
                {
                    MovePoint(1, P[1][0], P[1][1], P[1][2]);
                    break;
                }
                case 5:
                {
                    DoScriptText(SAY_3, me);
                    MovePoint(2, P[2][0], P[2][1], P[2][2]);
                    break;
                }
                case 6:
                {
                    waitTimer = 5000;
                    break;
                }
                case 7:
                {
                    waitTimer = 5000;
                    DoScriptText(SAY_4, me);
                    DoCast(me, SPELL_REJUVATION_VISUAL);
                    break;
                }
                case 8:
                {
                    waitTimer = 5000;
                    DoScriptText(SAY_5, me);
                    break;
                }
                case 9:
                {
                    DoScriptText(SAY_6, me);
                    MovePoint(3, P[3][0], P[3][1], P[3][2]);
                    gAura = me->SummonGameObject(GO_BLUE_AURA, 651.0f, 74.46f, -86.87f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0);
                    break;
                }
                case 10:
                {
                    waitTimer = 3000;
                    break;
                }
                case 11:
                {
                    MovePoint(4, P[4][0], P[4][1], P[4][2]);
                    break;
                }
                case 12:
                {
                    DoScriptText(SAY_7, me);
                    MovePoint(5, P[5][0], P[5][1], P[5][2]);
                    break;
                }
                case 13:
                {
                    if (GameObject* gStone = FindGameObject(GO_STAFF_STONE, 10.0f, me))
                        gStone->Use(me);

                    if (gAura)
                        gAura->RemoveFromWorld();

                    MovePoint(6, P[6][0], P[6][1], P[6][2]);
                    break;
                }
                case 14:
                {
                    waitTimer = 3000;
                    break;
                }
                case 15:
                {
                    MovePoint(7, P[7][0], P[7][1], P[7][2]);
                    break;
                }
                case 16:
                {
                    MovePoint(8, P[8][0], P[8][1], P[8][2]);
                    break;
                }
                case 17:
                {
                    MovePoint(9, P[9][0], P[9][1], P[9][2]);
                    break;
                }
                case 18:
                {
                    FinishEvent();
                    break;
                }
                default:
                    break;
            }
        }
    }

    void MovePoint(uint32 id, float x, float y, float z)
    {
        isMoving = true;
        me->GetMotionMaster()->MovePoint(id, x, y, z);
    }

    void MovementInform(uint32 uiType, uint32 uiId)
    {
        if (uiType != POINT_MOTION_TYPE)
            return;

        me->SetOrientation(P[uiId][3]);
        ++currentPhase;
        isMoving = false;
    }
};

bool QuestAccept_npc_celebras_the_redeemed(Player* player, Creature* creature, Quest const* pQuest)
{
    if (pQuest->GetQuestId() == QUEST_THE_SCEPTER_OF_CELEBRAS)
        CAST_AI(npc_celebras_the_redeemedAI, creature->AI())->StartEvent(player);

    return true;
}

CreatureAI* GetAI_npc_celebras_the_redeemed(Creature* creature)
{
    return new npc_celebras_the_redeemedAI(creature);
}

void AddSC_npc_celebras_the_redeemed()
{
    Script* newscript;
    newscript = new Script;
    newscript->Name = "npc_celebras_the_redeemed";
    newscript->GetAI = &GetAI_npc_celebras_the_redeemed;
    newscript->pQuestAcceptNPC = &QuestAccept_npc_celebras_the_redeemed;
    newscript->RegisterSelf();
}