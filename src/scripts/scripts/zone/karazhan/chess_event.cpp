#include "precompiled.h"
#include "chess_event.h"


//trigger AI
move_triggerAI::move_triggerAI(Creature *c) : ScriptedAI(c)
{
    pInstance = ((ScriptedInstance*)m_creature->GetInstanceData());
    m_creature->GetPosition(wLoc);
}

void move_triggerAI::Reset()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie move_triggerAI::Reset()");
#endif
    moveTimer   = 3000;
    pieceStance = PIECE_NONE;
    unitToMove = 0;
    MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);
}

void move_triggerAI::SpellHit(Unit *caster,const SpellEntry *spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpellHit(Unit *caster = %i,const SpellEntry *spell = %i)", caster ? 1 : 0, spell ? 1 : 0);
#endif
    if (!MedivhGUID)
        MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);
#ifdef CHESS_DEBUG_INFO
    printf("\nmove_triggerAI:SpellHit(...): stance: %i, medivh: %u, id: %i\n", pieceStance, MedivhGUID, spell->Id);
#endif
    if (pieceStance != PIECE_NONE || !MedivhGUID)
        return;

    switch (spell->Id)
    {
        case SPELL_MOVE_1:
        case SPELL_MOVE_2:
        case SPELL_MOVE_3:
        case SPELL_MOVE_4:
        case SPELL_MOVE_5:
        case SPELL_MOVE_6:
        case SPELL_MOVE_7:
        case SPELL_CHANGE_FACING:
        {
            boss_MedivhAI * medivh = (boss_MedivhAI*)(m_creature->GetCreature(MedivhGUID)->AI());
            if (medivh)
            {
                if (spell->Id == SPELL_CHANGE_FACING || medivh->CanMoveTo(m_creature->GetGUID(), caster->GetGUID()))
                {
                    medivh->AddTriggerToMove(m_creature->GetGUID(), caster->GetGUID(), caster->GetCharmerOrOwnerPlayerOrPlayerItself() ? true : false);

                    me->CastSpell(m_creature, SPELL_MOVE_PREVISUAL, false);

                    unitToMove = caster->GetGUID();

                    if (spell->Id == SPELL_CHANGE_FACING)
                        pieceStance = PIECE_CHANGE_FACING;
                    else
                        pieceStance = PIECE_MOVE;
                }
                else
                    m_creature->Say("You can't move to me", LANG_UNIVERSAL, caster->GetGUID());
            }
            else
                me->Say("Medivh not found ... you can't move", LANG_UNIVERSAL, 0);

            break;
        }
        default:
            break;
    }
}

void move_triggerAI::MakeMove()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie MakeMove()");
#endif
    ChessPiecesStances tmpStance = pieceStance;

    moveTimer = 3000;
    pieceStance = PIECE_NONE;
    Creature * temp = m_creature->GetCreature(unitToMove);
    Creature * temp2 = m_creature->GetCreature(MedivhGUID);

    if (!temp || !temp->isAlive())
    {
        unitToMove = 0;
        return;
    }

    switch (tmpStance)
    {
        case PIECE_MOVE:
            me->CastSpell(m_creature, SPELL_MOVE_MARKER, false);
            temp->GetMotionMaster()->MovePoint(0, wLoc.coord_x, wLoc.coord_y, wLoc.coord_z);

            if (temp2)
            {
                ((boss_MedivhAI*)temp2->AI())->ChangePlaceInBoard(unitToMove, me->GetGUID());
                ((boss_MedivhAI*)temp2->AI())->RemoveFromMoveList(me->GetGUID());
            }
            break;
        case PIECE_CHANGE_FACING:
            if (temp2)
            {
                ((boss_MedivhAI*)temp2->AI())->ChangePieceFacing(temp, me);
                ((boss_MedivhAI*)temp2->AI())->RemoveFromMoveList(me->GetGUID());
            }
            break;
        default:
            break;
    }

    unitToMove = 0;
}

void move_triggerAI::RemoveFromMove(uint64 piece)
{
    if (unitToMove == piece)
    {
        pieceStance = PIECE_NONE;
        unitToMove = 0;
        moveTimer = 3000;
    }
}

void move_triggerAI::UpdateAI(const uint32 diff)
{
    if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS)
        return;

    if (pieceStance)
    {
        if (moveTimer < diff)
            MakeMove();
        else
            moveTimer -= diff;
    }
}

//Chesspieces AI

npc_chesspieceAI::npc_chesspieceAI(Creature *c) : Scripted_NoMovementAI(c)
{
    pInstance = ((ScriptedInstance*)m_creature->GetInstanceData());

    SpellEntry *TempSpell = (SpellEntry*)GetSpellStore()->LookupEntry(SPELL_POSSES_CHESSPIECE);

    m_creature->setActive(true);
}

void npc_chesspieceAI::EnterEvadeMode()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie EnterEvadeMode()");
#endif

    return;
}

void npc_chesspieceAI::SetSpellsAndCooldowns()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SetSpellsAndCooldowns()");
#endif
    switch(m_creature->GetEntry())
    {
        case NPC_KING_A:
            ability1ID = SPELL_KING_A_1;
            ability1Timer = CD_KING_1;
            ability1Cooldown = CD_KING_1;

            ability2ID = SPELL_KING_A_2;
            ability2Timer = CD_KING_2;
            ability2Cooldown = CD_KING_2;

            moveID = SPELL_MOVE_5;
            break;

        case NPC_KING_H:
            ability1ID = SPELL_KING_H_1 ;
            ability1Timer = CD_KING_1;
            ability1Cooldown = CD_KING_1;

            ability2ID = SPELL_KING_H_2;
            ability2Timer = CD_KING_2;
            ability2Cooldown = CD_KING_2;

            moveID = SPELL_MOVE_5;
            break;

        case NPC_QUEEN_A:
            ability1ID = SPELL_QUEEN_A_1 ;
            ability1Timer = CD_QUEEN_1;
            ability1Cooldown = CD_QUEEN_1;

            ability2ID = SPELL_QUEEN_A_2;
            ability2Timer = CD_QUEEN_2;
            ability2Cooldown = CD_QUEEN_2;

            moveID = SPELL_MOVE_4;
            break;

        case NPC_QUEEN_H:
            ability1ID = SPELL_QUEEN_H_1 ;
            ability1Timer = CD_QUEEN_1;
            ability1Cooldown = CD_QUEEN_1;

            ability2ID = SPELL_QUEEN_H_2;
            ability2Timer = CD_QUEEN_2;
            ability2Cooldown = CD_QUEEN_2;

            moveID = SPELL_MOVE_4;
            break;

        case NPC_BISHOP_A:
            ability1ID = SPELL_BISHOP_A_1 ;
            ability1Timer = CD_BISHOP_1;
            ability1Cooldown = CD_BISHOP_1;

            ability2ID = SPELL_BISHOP_A_2;
            ability2Timer = CD_BISHOP_2;
            ability2Cooldown = CD_BISHOP_2;

            moveID = SPELL_MOVE_6;
            break;

        case NPC_BISHOP_H:
            ability1ID = SPELL_BISHOP_H_1 ;
            ability1Timer = CD_BISHOP_1;
            ability1Cooldown = CD_BISHOP_1;

            ability2ID = SPELL_BISHOP_H_2;
            ability2Timer = CD_BISHOP_2;
            ability2Cooldown = CD_BISHOP_2;

            moveID = SPELL_MOVE_6;
            break;

        case NPC_KNIGHT_A:
            ability1ID = SPELL_KNIGHT_A_1 ;
            ability1Timer = CD_KNIGHT_1;
            ability1Cooldown = CD_KNIGHT_1;

            ability2ID = SPELL_KNIGHT_A_2;
            ability2Timer = CD_KNIGHT_2;
            ability2Cooldown = CD_KNIGHT_2;

            moveID = SPELL_MOVE_3;
            break;

        case NPC_KNIGHT_H:
            ability1ID = SPELL_KNIGHT_H_1 ;
            ability1Timer = CD_KNIGHT_1;
            ability1Cooldown = CD_KNIGHT_1;

            ability2ID = SPELL_KNIGHT_H_2;
            ability2Timer = CD_KNIGHT_2;
            ability2Cooldown = CD_KNIGHT_2;

            moveID = SPELL_MOVE_3;
            break;

        case NPC_ROOK_A:
            ability1ID = SPELL_ROOK_A_1 ;
            ability1Timer = CD_ROOK_1;
            ability1Cooldown = CD_ROOK_1;

            ability2ID = SPELL_ROOK_A_2;
            ability2Timer = CD_ROOK_2;
            ability2Cooldown = CD_ROOK_2;

            moveID = SPELL_MOVE_7;
            break;

        case NPC_ROOK_H:
            ability1ID = SPELL_ROOK_H_1 ;
            ability1Timer = CD_ROOK_1;
            ability1Cooldown = CD_ROOK_1;

            ability2ID = SPELL_ROOK_H_2;
            ability2Timer = CD_ROOK_2;
            ability2Cooldown = CD_ROOK_2;

            moveID = SPELL_MOVE_7;
            break;

        case NPC_PAWN_A:
            ability1ID = SPELL_PAWN_A_1 ;
            ability1Timer = CD_PAWN_1;
            ability1Cooldown = CD_PAWN_1;

            ability2ID = SPELL_PAWN_H_2;
            ability2Timer = CD_PAWN_2;
            ability2Cooldown = CD_PAWN_2;

            moveID = SPELL_MOVE_1;
            break;

        case NPC_PAWN_H:
            ability1ID = SPELL_PAWN_H_1 ;
            ability1Timer = CD_PAWN_1;
            ability1Cooldown = CD_PAWN_1;

            ability2ID = SPELL_PAWN_H_2;
            ability2Timer = CD_PAWN_2;
            ability2Cooldown = CD_PAWN_2;

            moveID = SPELL_MOVE_1;
            break;
        default:
            break;
    }

    attackTimer = attackCooldown;
}

bool npc_chesspieceAI::IsOnSelfSpell(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie npc_chesspieceAI::IsOnSelfSpell(uint32 spell = %u)", spell);
#endif

    switch (spell)
    {
        case SPELL_KING_H_2:
        case SPELL_KING_A_2:
        case SPELL_ROOK_H_2:
        case SPELL_ROOK_A_2:
        case SPELL_PAWN_H_2:
        case SPELL_PAWN_A_2:
            return true;

        default:
            return false;
    }

    return false;
}

bool npc_chesspieceAI::IsHealingSpell(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsHealingSpell(uint32 spell = %u)", spell);
#endif

    switch (spell)
    {
        case SPELL_BISHOP_A_1:
        case SPELL_BISHOP_H_1:
            return true;

        default:
            return false;
    }

    return false;
}

bool npc_chesspieceAI::IsNullTargetSpell(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsHealingSpell(uint32 spell = %u)", spell);
#endif

    switch (spell)
    {
        case SPELL_KING_H_1:
        case SPELL_KING_A_1:
        case SPELL_KNIGHT_H_1:
        case SPELL_KNIGHT_A_1:
        case SPELL_ROOK_H_1:
        case SPELL_ROOK_A_1:
        case SPELL_PAWN_H_1:
        case SPELL_PAWN_A_1:
        case SPELL_KING_H_2:
        case SPELL_KING_A_2:
        case SPELL_BISHOP_H_2:
        case SPELL_BISHOP_A_2:
        case SPELL_KNIGHT_H_2:
        case SPELL_KNIGHT_A_2:
        case SPELL_ROOK_H_2:
        case SPELL_ROOK_A_2:
            return true;

        default:
            return false;
    }

    return false;
}

void npc_chesspieceAI::Reset()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie npc_chesspieceAI::Reset()");
#endif
    ReturnToHome = true;
    InGame = true;
    CanMove = false;
    m_creature->setActive(true);

    SetSpellsAndCooldowns();

    MedivhGUID = pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH);

    ability1Chance = urand(ABILITY_1_CHANCE_MIN, ABILITY_1_CHANCE_MAX);
    ability2Chance = urand(ABILITY_2_CHANCE_MIN, ABILITY_2_CHANCE_MAX);

    me->RemoveFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);

    nextTryTimer = urand(500, 5000);

    changeFacingTimer = urand (3000, 7500);
}

void npc_chesspieceAI::MovementInform(uint32 type, uint32 data)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie MovementInform(uint32 type = %u, uint32 data = %u)", type, data);
#endif
    if (type != POINT_MOTION_TYPE)
        return;

    npc_medivh = m_creature->GetCreature(MedivhGUID);
    if (npc_medivh)
        ((boss_MedivhAI*)npc_medivh->AI())->SetOrientation(m_creature->GetGUID());
}

void npc_chesspieceAI::JustRespawned()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie JustRespawned()");
#endif

    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
}

void npc_chesspieceAI::OnCharmed(bool apply)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie OnCharmed(bool apply = %i)", apply);
#endif

    m_creature->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
    // set proper faction after charm
    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
        m_creature->setFaction(A_FACTION);
    else
        m_creature->setFaction(H_FACTION);

    if (!apply)
        if (Creature * medivh = me->GetCreature(MedivhGUID))
            ((boss_MedivhAI*)medivh->AI())->SetOrientation(me->GetGUID());
}

void npc_chesspieceAI::SpellHit(Unit * caster, const SpellEntry * spell)
{
    if (spell->Id == SPELL_MOVE_MARKER)
    {
        me->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
        ((Creature*)me)->HandleEmoteCommand(EMOTE_ONESHOT_ATTACK1H);
        me->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }
}

void npc_chesspieceAI::SpellHitTarget(Unit * caster, const SpellEntry * spell)
{
    if (spell->Id == moveID)
        ((Creature*)me)->HandleEmoteCommand(EMOTE_ONESHOT_BOW);
}

void npc_chesspieceAI::DamageTaken(Unit * done_by, uint32& damage)
{
    Player * tmpPl = done_by->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (done_by->GetTypeId() == TYPEID_UNIT && tmpPl && tmpPl->GetTeam() == pInstance->GetData(CHESS_EVENT_TEAM))
        pInstance->SetData(DATA_CHESS_DAMAGE, pInstance->GetData(DATA_CHESS_DAMAGE) + damage);
}

void npc_chesspieceAI::UpdateAI(const uint32 diff)
{
    if (pInstance->GetData(DATA_CHESS_EVENT) == DONE || pInstance->GetData(DATA_CHESS_EVENT) == FAIL)
    {
        if (m_creature->isInCombat())
            m_creature->CombatStop();

        if (m_creature->isPossessed())
            m_creature->RemoveCharmedOrPossessedBy(m_creature->GetCharmer());

        if (m_creature->HasFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE))
            m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    }

    if (pInstance->GetData(DATA_CHESS_EVENT) != IN_PROGRESS)
        return;

    if (!InGame)
        return;

    if ((me->getFaction() == A_FACTION && pInstance->GetData(CHESS_EVENT_TEAM) == HORDE) ||
       (me->getFaction() == H_FACTION && pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE))
    {
#ifndef CHESS_EVENT_DISSABLE_MEDIVH_PIECES_SPELLS
        uint64 ab1 = 0;
        bool ab1Self = false;
        uint64 ab2 = 0;
        bool ab2Self = false;

        if (ability1Timer <= diff)
        {
            Creature * medivh = m_creature->GetCreature(MedivhGUID);
            if (medivh && urand(0, ABILITY_CHANCE_MAX) < ability1Chance)
            {
                if (IsOnSelfSpell(ability1ID))
                {
                    ab1 = me->GetGUID();
                    ab1Self = true;
                }
                else
                    ab1 = ((boss_MedivhAI*)medivh->AI())->GetSpellTarget(me->GetGUID(), ability1ID);
            }
            else
                ability1Timer = urand(500, 5000);
        }
        else
            ability1Timer -= diff;

        if (ability2Timer <= diff)
        {
            Creature * medivh = m_creature->GetCreature(MedivhGUID);
            if (medivh && urand(0, ABILITY_CHANCE_MAX) < ability2Chance)
            {
                if (IsOnSelfSpell(ability2ID))
                {
                    ab2 = me->GetGUID();
                    ab2Self = true;
                }
                else
                    ab2 = ((boss_MedivhAI*)medivh->AI())->GetSpellTarget(me->GetGUID(), ability2ID);
            }
            else
                ability2Timer = urand(500, 5000);
        }
        else
            ability2Timer -= diff;


        if (ab1 && ab2)
        {
            if (urand(0, ABILITY_CHANCE_MAX) < (IsHealingSpell(ab1) ? HEALING_ABILITY_CHANCE : NORMAL_ABILITY_CHANCE))
                ab2 = 0;
            else
                ab1 = 0;
        }

        if (ab1)
        {
            if (IsNullTargetSpell(ability1ID))
                AddSpellToCast(ability1ID, CAST_NULL);
            else
            {
                Unit * victim = me->GetUnit(ab1);
                if (victim)
                    AddSpellToCast(victim, ability1ID);
            }

            ability1Timer = ability1Cooldown;
            ability2Timer = SHARED_COOLDOWN;
        }
        else if (ab2)
        {
            if (IsNullTargetSpell(ability2ID))
                AddSpellToCast(ability2ID, CAST_NULL);
            else
            {
                Unit * victim = me->GetUnit(ab2);
                if (victim)
                    AddSpellToCast(victim, ability2ID);
            }

            ability2Timer = ability1Cooldown;
            ability1Timer = SHARED_COOLDOWN;
        }
#endif

#ifndef CHESS_EVENT_DISSABLE_FACING
        if (changeFacingTimer <= diff)
        {
            changeFacingTimer = urand(3000, 7500);

            Creature * medivh = m_creature->GetCreature(MedivhGUID);

            if (!medivh)
                return;

            ((boss_MedivhAI*)medivh->AI())->CheckChangeFacing(me->GetGUID());
        }
        else
            changeFacingTimer -= diff;
#endif
    }

    CastNextSpellIfAnyAndReady();

#ifndef CHESS_EVENT_DISSABLE_MELEE
    if (attackTimer <= diff)
    {
        attackTimer = attackCooldown;
        Creature * medivh = m_creature->GetCreature(MedivhGUID);

        if (!medivh)
            return;

        Unit * uVictim = m_creature->GetUnit(((boss_MedivhAI*)medivh->AI())->GetMeleeTarget(m_creature->GetGUID()));
        if (uVictim)
        {
            m_creature->AttackerStateUpdate(uVictim);

#ifdef CHESS_DEBUG_INFO
            m_creature->Say("Atakujem sobiem muahahahaha", LANG_UNIVERSAL, NULL);
            printf("\nAtak %u -> %u", me->GetGUID(), uVictim->GetGUID());
#endif
        }
    }
    else
        attackTimer -= diff;
#endif
}

void npc_chesspieceAI::JustDied(Unit * killer)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie JustDied(Unit * killer = %i)", killer ? 1 : 0);
#endif

    Player * tmpP = me->GetCharmerOrOwnerPlayerOrPlayerItself();
    if (tmpP)
        tmpP->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE);

    m_creature->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE);

    if (pInstance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
    {
        npc_medivh = m_creature->GetCreature(MedivhGUID);
        if (npc_medivh)
            ((boss_MedivhAI*)npc_medivh->AI())->RemoveChessPieceFromBoard(m_creature);
        else
            me->Say("I'm dying ... but Medivh not found ...", LANG_UNIVERSAL, 0);
    }
}

//Medivh AI

boss_MedivhAI::boss_MedivhAI(Creature *c) : ScriptedAI(c)
{
    pInstance = ((instance_karazhan*)m_creature->GetInstanceData());
    m_creature->GetPosition(wLoc);
    tpLoc.coord_x = -11108.2;
    tpLoc.coord_y = -1841.56;
    tpLoc.coord_z = 229.625;
    tpLoc.orientation = 5.39745;

    this->chanceToMove = urand(MIN_MOVE_CHANCE, MAX_MOVE_CHANCE);

    chanceToSelfMove = urand(MIN_SELF_MOVE_CHANCE, MAX_SELF_MOVE_CHANCE);

    /*
                   j

          0  1  2  3  4  5  6  7
        0 H  H  H  H  H  H  H  H
        1 H  H  H  H  H  H  H  H
        2 E  E  E  E  E  E  E  E
    i   3 E  E  E  E  E  E  E  E
        4 E  E  E  E  E  E  E  E
        5 E  E  E  E  E  E  E  E
        6 A  A  A  A  A  A  A  A
        7 A  A  A  A  A  A  A  A
    */

    // calc positions:

    for (uint8 i = 0; i < 8; ++i)
    {
        for (uint8 j = 0; j < 8; ++j)
        {
            chessBoard[i][j].position.coord_x = -11077.66 + 3.48 * j - 4.32 * i ;
            chessBoard[i][j].position.coord_y = -1849.02 - 4.365 * j - 3.41 * i;
            chessBoard[i][j].position.coord_z = 221.1;
            chessBoard[i][j].position.mapid = me->GetMapId();
        }
    }
    int j = 15;
    for (int i = 0; i < 16; ++i)
    {
        allianceSideDeadWP[0][i] = (i < 8 ? ALLIANCE_DEAD_X2 : ALLIANCE_DEAD_X1) - 2.2 * 0.75 * (j < 8 ? j : j - 8);
        allianceSideDeadWP[1][i] = (i < 8 ? ALLIANCE_DEAD_Y2 : ALLIANCE_DEAD_Y1) - 1.7 * 0.75 * (j < 8 ? j : j - 8);
        hordeSideDeadWP[0][i] = (i < 8 ? HORDE_DEAD_X2 : HORDE_DEAD_X1) + 2.2 * 0.75 * (j < 8 ? j : j - 8);
        hordeSideDeadWP[1][i] = (i < 8 ? HORDE_DEAD_Y2 : HORDE_DEAD_Y1) + 1.7 * 0.75 * (j < 8 ? j : j - 8);
        j--;
    }
}

int boss_MedivhAI::GetMoveRange(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetMoveRange(uint64 piece = %u)", piece);
#endif
    return (GetMoveRange(m_creature->GetUnit(*m_creature, piece)));
}

int boss_MedivhAI::GetMoveRange(Unit * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetMoveRange(Unit * piece = %i)", piece ? 1 : 0);
#endif
    if (!piece)
        return 0;

    switch (piece->GetEntry())
    {
        case NPC_PAWN_A:
        case NPC_PAWN_H:
        case NPC_KING_A:
        case NPC_KING_H:
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
        case NPC_ROOK_A:
        case NPC_ROOK_H:
            return 8;

        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
            return 15;

        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
            return 20;

        default:
            break;
    }

    return 0;
}

bool boss_MedivhAI::Enemy(uint64 piece1, uint64 piece2)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie Enemy(uint64 piece1 = %u, uint64 piece2 = %u)", piece1, piece2);
#endif
    Creature * tmp1, * tmp2;

    if (!piece1 || !piece2)
        return false;

    tmp1 = me->GetCreature(piece1);
    tmp2 = me->GetCreature(piece2);

    if (!tmp1 || !tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\npiece1: %u, %i  | piece2: %u, %i", piece1, tmp1 ? 1 : 0, piece2 , tmp2 ? 1 : 0);
#endif
        me->Say("Cosik pionkow 2 nie znalazlem do sprawdzenia", LANG_UNIVERSAL, 0);
        return false;
    }

    return tmp1->getFaction() != tmp2->getFaction();
}

int boss_MedivhAI::GetCountOfEnemyInMelee(uint64 piece, bool strafe)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetCountOfEnemyInMelee(uint64 piece = %u)", piece);
#endif

    int tmpCount = 0, tmpI = -1, tmpJ = -1, tmpOffsetI, tmpOffsetJ;

    //search for position in tab of piece

    if (!FindPlaceInBoard(piece, tmpI, tmpJ))
        return 0;

    if (strafe)
    {
        for (int i = 0; i < OFFSET8COUNT; ++i)
        {
            tmpOffsetI = tmpI + offsetTab8[i][0];
            tmpOffsetJ = tmpJ + offsetTab8[i][1];
            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                Enemy(piece, chessBoard[tmpOffsetI][tmpOffsetJ].piece))
                ++tmpCount;
        }
    }
    else
    {
        for (int i = 0; i < OFFSETMELEECOUNT; ++i)
        {
            tmpOffsetI = tmpI + offsetTabMelee[i][0];
            tmpOffsetJ = tmpJ + offsetTabMelee[i][1];
            if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                Enemy(piece, chessBoard[tmpOffsetI][tmpOffsetJ].piece))
                ++tmpCount;
        }
    }

    return tmpCount;
}

int boss_MedivhAI::GetCountOfPiecesInRange(uint64 trigger, int range, bool friendly)
{
    int count = 0;

    int tmpI, tmpJ, i, tmpOffsetI, tmpOffsetJ;
    uint64 tmpGUID;

    if (!FindPlaceInBoard(trigger, tmpI, tmpJ))
        return 0;

    switch (range)
    {
        case 25:
            for (i = 0; i < OFFSET25COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab25[i][0];
                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                {
                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                    if (friendly)
                    {
                        if (tmpGUID && IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                    else
                    {
                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                }
            }
        case 20:
            for (i = 0; i < OFFSET20COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab20[i][0];
                tmpOffsetJ = tmpJ + offsetTab20[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                {
                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                    if (friendly)
                    {
                        if (tmpGUID && IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                    else
                    {
                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                }
            }
        case 15:
            for (i = 0; i < OFFSET15COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab15[i][0];
                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                {
                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                    if (friendly)
                    {
                        if (tmpGUID && IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                    else
                    {
                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                }
            }
        case 8:
        default:
            for (i = 0; i < OFFSET8COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab8[i][0];
                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                {
                    tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                    if (friendly)
                    {
                        if (tmpGUID && IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                    else
                    {
                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            ++count;
                    }
                }
            break;
            }
    }

    return count;
}

int boss_MedivhAI::GetLifePriority(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetLifePriority(uint64 piece = %u)", piece);
#endif

    Unit * uPiece = m_creature->GetUnit(*m_creature, piece);

    if (!uPiece)
        return 0;

    int tmpPriority = 0;

    switch (uPiece->GetEntry())
    {
        case NPC_PAWN_A:
        case NPC_PAWN_H:
            tmpPriority += 10;
            break;
        case NPC_KING_A:
        case NPC_KING_H:
            tmpPriority += 50;
            break;
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
            tmpPriority += 50;
            break;
        case NPC_ROOK_A:
        case NPC_ROOK_H:
            tmpPriority += 20;
            break;
        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
            tmpPriority += 30;
            break;
        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
            tmpPriority += 40;
            break;
        default:
            break;
    }

    tmpPriority += tmpPriority * (1- (uPiece->GetHealth()/uPiece->GetMaxHealth()));

    return tmpPriority;
}

int boss_MedivhAI::GetAttackPriority(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetAttackPriority(uint64 piece = %u)", piece);
#endif

    Unit * uPiece = m_creature->GetUnit(piece);

    if (!uPiece)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nGetAttackPriority: piece not found Oo : guid: %u", piece);
#endif
        return 0;
    }

    int tmpPriority = START_PRIORITY;

    switch (uPiece->GetEntry())
    {
        case NPC_PAWN_A:
        case NPC_PAWN_H:
            tmpPriority += 5;
            break;
        case NPC_KING_A:
        case NPC_KING_H:
            tmpPriority += 15;
            break;
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
            tmpPriority += 15;
            break;
        case NPC_ROOK_A:
        case NPC_ROOK_H:
            tmpPriority += 5;
            break;
        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
            tmpPriority += 5;
            break;
        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
            tmpPriority += 10;
            break;
        default:
            break;
    }

    tmpPriority += tmpPriority * (1 - (uPiece->GetHealth()/(double)uPiece->GetMaxHealth()));

    return tmpPriority;
}

bool boss_MedivhAI::IsEmptySquareInRange(uint64 piece, int range)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsEmptySquareInRange(uint64 piece = %u, int range = %i)", piece, range);
#endif

    if (!piece || !range)
        return false;

    int tmpI = -1, tmpJ = -1, tmpOffsetI, tmpOffsetJ;
    int i;

    //search for position in tab of piece

    if (!FindPlaceInBoard(piece, tmpI, tmpJ))
    {
        Creature * uPiece = m_creature->GetCreature(piece);

        if (uPiece)
            uPiece->Say("IsEmptySquareInRange(..) : Nie znaleziono mnie na planszy !!", LANG_UNIVERSAL, 0);
        else
            me->Say("IsEmptySquareInRange(..) : Nie znalazlem pionka !!", LANG_UNIVERSAL, 0);
        return false;
    }

    switch (range)
    {
        case 25:
            for (i = 0; i < OFFSET25COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab25[i][0];
                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                        return true;
            }
        case 20:
            for (i = 0; i < OFFSET20COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab20[i][0];
                tmpOffsetJ = tmpJ + offsetTab20[i][1];
                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                        return true;
            }
        case 15:
            for (i = 0; i < OFFSET15COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab15[i][0];
                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                        return true;
            }
        case 8:
            for (i = 0; i < OFFSET8COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab8[i][0];
                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (!chessBoard[tmpOffsetI][tmpOffsetJ].piece)
                        return true;
            }
            break;
        default:
            break;
    }

    return false;
}

bool boss_MedivhAI::IsPositive(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsPositive(uint32 spell = %u)", spell);
#endif

    switch (spell)
    {
        case SPELL_PAWN_A_2:
        case SPELL_PAWN_H_2:
        case SPELL_ROOK_A_2:
        case SPELL_ROOK_H_2:
        case SPELL_KING_A_2:
        case SPELL_KING_H_2:
        case SPELL_BISHOP_A_1:
        case SPELL_BISHOP_H_1:
            return true;

        default:
            return false;
    }

    return false;
}

int boss_MedivhAI::GetAbilityRange(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetAbilityRange(uint32 spell = %u)", spell);
#endif

    /*returns:
    0   - spell needs check if there are any target in melee range, if yes then casts spell on self
    5   - spell needs target in front of caster
    6   - spell needs target in 1 -> 3 targets in front (clave/swipe)
    20  - long range (7x7 - 5 squares) - normal check
    25  - long range (7x7 - 1 squares) - normal check

    0                   - caster;
    1 + 2 + 3           - return 0
    2                   - return 5
    3 + 2               - return 6
    4 + 1 + 2 + 3       - return 20
    5 + 4 + 1 + 2 + 3   - return 25

     5 4 4 4 4 4 5
     4 4 4 4 4 4 4
     4 4 3 2 3 4 4
     4 4 1 0 1 4 4
     4 4 1 1 1 4 4
     4 4 4 4 4 4 4
     5 4 4 4 4 4 5

    ranges for spells can be wrong !
    */

    switch (spell)
    {
        case SPELL_KING_H_1:
        case SPELL_KING_A_1:
            return 6;

        case SPELL_QUEEN_H_1:
        case SPELL_QUEEN_A_1:
        case SPELL_QUEEN_A_2:
        case SPELL_QUEEN_H_2:
            return 25;

        case SPELL_BISHOP_A_1:
        case SPELL_BISHOP_H_1:
            return 20;

        case SPELL_PAWN_H_1:
        case SPELL_PAWN_A_1:
        case SPELL_KNIGHT_H_1:
        case SPELL_KNIGHT_A_1:
            return 5;

        default:
            return 0;
    }

    return 0;
}

bool boss_MedivhAI::IsHealingSpell(uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsHealingSpell(uint32 spell = %u)", spell);
#endif

    switch (spell)
    {
        case SPELL_BISHOP_A_1:
        case SPELL_BISHOP_H_1:
            return true;

        default:
            return false;
    }

    return false;
}

bool boss_MedivhAI::Heal(uint32 spell, uint64 guid)
{
    if (!IsHealingSpell(spell))
        return true;

    Creature * tmpC = me->GetCreature(guid);

    if (!tmpC)
        return false;

    return tmpC->GetHealth() != tmpC->GetMaxHealth();
}

uint64 boss_MedivhAI::GetSpellTarget(uint64 caster, uint32 spell)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetSpellTarget(uint64 caster = %u, uint32 spell = %u)", caster, spell);
#endif

    int tmpI = -1, tmpJ = -1, i, tmpOffsetI, tmpOffsetJ;

    if (!FindPlaceInBoard(caster, tmpI, tmpJ))
    {
        Creature * uCaster = m_creature->GetCreature(caster);
        if (uCaster)
            uCaster->Say("GetSpellTarget(..) : Nie znaleziono mnie na planszy !!", LANG_UNIVERSAL, 0);
        return 0;
    }

    int priority = START_PRIORITY, prevPriority = 0;

    std::list<Priority> tmpList;
    std::list<uint64> tmpPossibleTargetsList;
    uint64 tmpGUID;

    if (IsPositive(spell))
    {
        //create possible target list

        switch (GetAbilityRange(spell))
        {
            case 25:
                for (i = 0; i < OFFSET25COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab25[i][0];
                    tmpOffsetJ = tmpJ + offsetTab25[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 20:
                for (i = 0; i < OFFSET20COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab20[i][0];
                    tmpOffsetJ = tmpJ + offsetTab20[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 15:
                for (i = 0; i < OFFSET15COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab15[i][0];
                    tmpOffsetJ = tmpJ + offsetTab15[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 8:
                for (i = 0; i < OFFSET8COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab8[i][0];
                    tmpOffsetJ = tmpJ + offsetTab8[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && IsMedivhsPiece(tmpGUID) && Heal(spell, tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
                break;
            case 6: // 3 targets in front
                switch (chessBoard[tmpI][tmpJ].ori)
                {
                    case CHESS_ORI_E:
                        if (tmpJ + 1 >= 0)
                        {
                            if (!Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                return caster;

                            if (tmpI - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                return caster;

                            if (tmpI + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_N:
                        if (tmpI - 1 >= 0)
                        {
                            if (!Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                return caster;

                            if (tmpJ - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpJ + 1 < 8 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_S:
                        if (tmpI + 1 >= 0)
                        {
                            if (!Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                return caster;

                            if (tmpJ - 1 >= 0 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpJ + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_W:
                        if (tmpJ - 1 >= 0)
                        {
                            if (!Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                return caster;

                            if (tmpI - 1 >= 0 && !Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpI + 1 < 8 && !Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                return caster;
                        }
                        break;
                    default:
                        break;
                }
                break;
            case 5: // 1 target in front
                switch (chessBoard[tmpI][tmpJ].ori)
                {
                    case CHESS_ORI_E:
                        if (tmpJ + 1 >= 0)
                            if (!Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                return chessBoard[tmpI][tmpJ + 1].piece;
                        break;
                    case CHESS_ORI_N:
                        if (tmpI - 1 >= 0)
                            if (!Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                return chessBoard[tmpI - 1][tmpJ].piece;
                        break;
                    case CHESS_ORI_S:
                        if (tmpI + 1 >= 0)
                            if (!Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                return chessBoard[tmpI + 1][tmpJ].piece;
                        break;
                    case CHESS_ORI_W:
                        if (tmpJ - 1 >= 0)
                            if (!Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                return chessBoard[tmpI][tmpJ - 1].piece;
                        break;
                    default:
                        break;
                }
                break;
            case 0: // check if is any piece in melee
                for (i = 0; i < OFFSET8COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab8[i][0];
                    tmpOffsetJ = tmpJ + offsetTab8[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && IsMedivhsPiece(tmpGUID))
                            return caster;
                    }
                }
                break;
            default:
                break;
        }

        if (tmpPossibleTargetsList.empty())
            return 0;

        // calculate and add priority

        int prioritySum = 0;

        for (std::list<uint64>::iterator i = tmpPossibleTargetsList.begin(); i != tmpPossibleTargetsList.end(); ++i)
        {
            Priority tempPriority;
            tempPriority.prior = START_PRIORITY;
            tempPriority.GUIDfrom = *i;

            tempPriority.prior += GetCountOfEnemyInMelee(*i) * MELEE_PRIORITY + urand(0, RAND_PRIORITY) + GetLifePriority(*i);

            prioritySum += tempPriority.prior;
            tmpList.push_back(tempPriority);
        }

        switch (rand()%2)
        {
            case 0:
            {
                int chosen = urand(0, prioritySum), prevPrior = 0;

                for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                {
                    if (prevPrior < chosen && (*i).prior >= chosen)
                        return (*i).GUIDfrom;
                    prevPrior = (*i).prior;
                }
                break;
            }
            case 1:
            default:
            {
                Priority best;
                std::list<Priority> bestList;
                best = tmpList.front();

                for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                {
                    if (best.prior < (*i).prior)
                    {
                        best = *i;
                        bestList.clear();
                        bestList.push_back(*i);
                    }
                    else if (best.prior == (*i).prior)
                        bestList.push_back(*i);
                }

                if (bestList.empty())
                    return 0;

                std::list<Priority>::iterator tmpItr = bestList.begin();

                advance(tmpItr, urand(0, bestList.size() - 1));

                return (*tmpItr).GUIDfrom;

                break;
            }
        }
    }
    else        //if !positive
    {
        //create possible targets list

        switch (GetAbilityRange(spell))
        {
            case 25:
                for (i = 0; i < OFFSET25COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab25[i][0];
                    tmpOffsetJ = tmpJ + offsetTab25[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 20:
                for (i = 0; i < OFFSET20COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab20[i][0];
                    tmpOffsetJ = tmpJ + offsetTab20[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 15:
                for (i = 0; i < OFFSET15COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab15[i][0];
                    tmpOffsetJ = tmpJ + offsetTab15[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
            case 8:
                for (i = 0; i < OFFSET8COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab8[i][0];
                    tmpOffsetJ = tmpJ + offsetTab8[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            tmpPossibleTargetsList.push_back(tmpGUID);
                    }
                }
                break;
            case 6: // 3 targets in front
                switch (chessBoard[tmpI][tmpJ].ori)
                {
                    case CHESS_ORI_E:
                        if (tmpJ + 1 >= 0)
                        {
                            if (Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                return caster;

                            if (tmpI - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                return caster;

                            if (tmpI + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_N:
                        if (tmpI - 1 >= 0)
                        {
                            if (Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                return caster;

                            if (tmpJ - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpJ + 1 < 8 && Enemy(caster, chessBoard[tmpI - 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_S:
                        if (tmpI + 1 >= 0)
                        {
                            if (Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                return caster;

                            if (tmpJ - 1 >= 0 && Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpJ + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ + 1].piece))
                                return caster;
                        }
                        break;
                    case CHESS_ORI_W:
                        if (tmpJ - 1 >= 0)
                        {
                            if (Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                return caster;

                            if (tmpI - 1 >= 0 && Enemy(caster, chessBoard[tmpI - 1][tmpJ - 1].piece))
                                return caster;

                            if (tmpI + 1 < 8 && Enemy(caster, chessBoard[tmpI + 1][tmpJ - 1].piece))
                                return caster;
                        }
                        break;
                    default:
                        break;
                }
                break;
            case 5: // 1 target in front
                switch (chessBoard[tmpI][tmpJ].ori)
                {
                    case CHESS_ORI_E:
                        if (tmpJ + 1 >= 0)
                            if (Enemy(caster, chessBoard[tmpI][tmpJ + 1].piece))
                                return chessBoard[tmpI][tmpJ + 1].piece;
                        break;
                    case CHESS_ORI_N:
                        if (tmpI - 1 >= 0)
                            if (Enemy(caster, chessBoard[tmpI - 1][tmpJ].piece))
                                return chessBoard[tmpI - 1][tmpJ].piece;
                        break;
                    case CHESS_ORI_S:
                        if (tmpI + 1 >= 0)
                            if (Enemy(caster, chessBoard[tmpI + 1][tmpJ].piece))
                                return chessBoard[tmpI + 1][tmpJ].piece;
                        break;
                    case CHESS_ORI_W:
                        if (tmpJ - 1 >= 0)
                            if (Enemy(caster, chessBoard[tmpI][tmpJ - 1].piece))
                                return chessBoard[tmpI][tmpJ - 1].piece;
                        break;
                    default:
                        break;
                }
                break;
            case 0: // check if is any piece in melee
                for (i = 0; i < OFFSET8COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab8[i][0];
                    tmpOffsetJ = tmpJ + offsetTab8[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    {
                        tmpGUID = chessBoard[tmpOffsetI][tmpOffsetJ].piece;

                        if (tmpGUID && !IsMedivhsPiece(tmpGUID))
                            return caster;
                    }
                }
                break;
            default:
                break;
        }

        // calculate and add priority

        int prioritySum = 0;

        for (std::list<uint64>::iterator i = tmpPossibleTargetsList.begin(); i != tmpPossibleTargetsList.end(); ++i)
        {
            Priority tempPriority;
            tempPriority.prior = START_PRIORITY;
            tempPriority.GUIDfrom = *i;

            tempPriority.prior += GetCountOfEnemyInMelee(*i) * MELEE_PRIORITY + urand(0, RAND_PRIORITY) + GetAttackPriority(*i);

            prioritySum += tempPriority.prior;
            tmpList.push_back(tempPriority);
        }

        switch (rand()%2)
        {
            case 0:
            {
                int chosen = urand(0, prioritySum), prevPrior = 0;

                for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                {
                    if (prevPrior < chosen && (*i).prior >= chosen)
                        return (*i).GUIDfrom;
                    prevPrior = (*i).prior;
                }
                break;
            }
            case 1:
            default:
            {
                Priority best;
                std::list<Priority> bestList;
                best = tmpList.front();

                for (std::list<Priority>::iterator i = tmpList.begin(); i!= tmpList.end(); ++i)
                {
                    if (best.prior < (*i).prior)
                    {
                        best = *i;
                        bestList.clear();
                        bestList.push_back(*i);
                    }
                    else if (best.prior == (*i).prior)
                        bestList.push_back(*i);
                }

                if (bestList.empty())
                    return 0;

                std::list<Priority>::iterator tmpItr = bestList.begin();

                advance(tmpItr, urand(0, bestList.size() - 1));

                return (*tmpItr).GUIDfrom;
            }
        }
    }

    return 0;
}

uint64 boss_MedivhAI::GetMeleeTarget(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetMeleeTarget(uint64 piece = %u)", piece);
#endif
    int tmpi, tmpj;    //temporary piece position

    if (!FindPlaceInBoard(piece, tmpi, tmpj))
        return 0;

    switch (chessBoard[tmpi][tmpj].ori)
    {
        case CHESS_ORI_N:
            if (tmpi > 0)
            {
                //front
                if (Enemy(piece, chessBoard[tmpi - 1][tmpj].piece))
                    return chessBoard[tmpi - 1][tmpj].piece;

                //strafe
                if (tmpj < 7 && Enemy(piece, chessBoard[tmpi - 1][tmpj + 1].piece))
                    return chessBoard[tmpi - 1][tmpj + 1].piece;

                if (tmpj > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj - 1].piece))
                    return chessBoard[tmpi - 1][tmpj - 1].piece;
            }
            break;
        case CHESS_ORI_E:
            if (tmpj < 7)
            {
                //front
                if (Enemy(piece, chessBoard[tmpi][tmpj + 1].piece))
                    return chessBoard[tmpi][tmpj + 1].piece;

                //strafe
                if (tmpi < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj + 1].piece))
                    return chessBoard[tmpi + 1][tmpj + 1].piece;

                if (tmpi > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj + 1].piece))
                    return chessBoard[tmpi - 1][tmpj + 1].piece;
            }
            break;
        case CHESS_ORI_S:
            if (tmpi < 7)
            {
                //front
                if (Enemy(piece, chessBoard[tmpi + 1][tmpj].piece))
                    return chessBoard[tmpi + 1][tmpj].piece;

                //strafe
                if (tmpj < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj + 1].piece))
                    return chessBoard[tmpi + 1][tmpj + 1].piece;

                if (tmpj > 0 && Enemy(piece, chessBoard[tmpi + 1][tmpj - 1].piece))
                    return chessBoard[tmpi + 1][tmpj - 1].piece;
            }
            break;
        case CHESS_ORI_W:
            if (tmpj > 0)
            {
                //front
                if (Enemy(piece, chessBoard[tmpi][tmpj - 1].piece))
                    return chessBoard[tmpi][tmpj - 1].piece;

                //strafe
                if (tmpi < 7 && Enemy(piece, chessBoard[tmpi + 1][tmpj - 1].piece))
                    return chessBoard[tmpi + 1][tmpj - 1].piece;

                if (tmpi > 0 && Enemy(piece, chessBoard[tmpi - 1][tmpj - 1].piece))
                    return chessBoard[tmpi - 1][tmpj - 1].piece;
            }
            break;
        default:
            break;
    }

    return 0;
}


bool boss_MedivhAI::IsChessPiece(Unit * unit)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsChessPiece(Unit * unit = %i)", unit ? 1 : 0);
#endif

    switch (unit->GetEntry())
    {
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
        case NPC_KING_A:
        case NPC_KING_H:
        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
        case NPC_PAWN_A:
        case NPC_PAWN_H:
        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
        case NPC_ROOK_A:
        case NPC_ROOK_H:
            return true;
        default:
            return false;
    }

    return false;
}

bool boss_MedivhAI::IsKing(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsKing(uint64 piece = %u)", piece);
#endif
    return IsKing(me->GetCreature(piece));
}

bool boss_MedivhAI::IsHealer(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsHealer(uint64 piece = %u)", piece);
#endif
    return IsHealer(me->GetCreature(piece));
}

bool boss_MedivhAI::IsKing(Creature * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsKing(Creature * piece = %i)", piece ? 1 : 0);
#endif

    if (!piece)
        return false;

    switch (piece->GetEntry())
    {
        case NPC_KING_H:
        case NPC_KING_A:
            return true;

        default:
            return false;
    }

    return false;
}

bool boss_MedivhAI::IsHealer(Creature * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsHealer(Creature * piece = %i)", piece ? 1 : 0);
#endif

    if (!piece)
        return false;

    switch (piece->GetEntry())
    {
        case NPC_BISHOP_H:
        case NPC_BISHOP_A:
            return true;

        default:
            return false;
    }

    return false;
}

bool boss_MedivhAI::IsMedivhsPiece(Unit * unit)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsMedivhsPiece(Unit * unit = %i)", unit ? 1 : 0);
#endif

    if (unit)
    {
        switch (pInstance->GetData(CHESS_EVENT_TEAM))
        {
            case ALLIANCE:
                if (unit->getFaction() == H_FACTION)
                    return true;
                break;
            case HORDE:
                if (unit->getFaction() == A_FACTION)
                    return true;
                break;
        }
    }
    else
        me->Say("IsMedivhsPiece: Cos unita niema", LANG_UNIVERSAL, 0);

    return false;
}

bool boss_MedivhAI::IsMedivhsPiece(uint64 unit)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsMedivhsPiece(uint64 unit = %u)", unit);
#endif

    for (std::list<uint64>::iterator i = medivhSidePieces.begin(); i != medivhSidePieces.end(); ++i)
        if ((*i) == unit)
            return true;

    return false;
}

bool boss_MedivhAI::IsInMoveList(uint64 unit, bool trigger)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsInMoveList(uint64 unit = %u, bool trigger = %i)", unit, trigger);
#endif

    if (!trigger)
    {
        for (std::list<ChessTile>::iterator i = moveList.begin(); i != moveList.end(); ++i)
            if ((*i).piece == unit)
                return true;
    }
    else
    {
        for (std::list<ChessTile>::iterator i = moveList.begin(); i != moveList.end(); ++i)
            if ((*i).trigger == unit)
                return true;
    }

    return false;
}

bool boss_MedivhAI::IsInMoveRange(uint64 from, uint64 to, int range)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie IsInMoveRange(uint64 from = %u, uint64 to = %u, int range = %i)", from, to, range);
#endif

    if (!from || !to || !range)
        return false;

    int tmpI = -1, tmpJ = -1, i, tmpOffsetI, tmpOffsetJ;

    if (!FindPlaceInBoard(from, tmpI, tmpJ))
    {
        Creature * uFrom = m_creature->GetCreature(from);
        if (uFrom)
            uFrom->Say("GetSpellTarget(..) : Nie znaleziono mnie na planszy !!", LANG_UNIVERSAL, 0);
        else
            me->Say("GetSpellTarget(..) : uFrom sie zapodzial", LANG_UNIVERSAL, 0);
        return false;
    }

    switch (range)
    {
        case 25:
            for (i = 0; i < OFFSET25COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab25[i][0];
                tmpOffsetJ = tmpJ + offsetTab25[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                        chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                        return true;
            }
        case 20:
            for (i = 0; i < OFFSET20COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab20[i][0];
                tmpOffsetJ = tmpJ + offsetTab20[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                        chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                        return true;
            }
        case 15:
            for (i = 0; i < OFFSET15COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab15[i][0];
                tmpOffsetJ = tmpJ + offsetTab15[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                        chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                        return true;
            }
        case 8:
            for (i = 0; i < OFFSET8COUNT; i++)
            {
                tmpOffsetI = tmpI + offsetTab8[i][0];
                tmpOffsetJ = tmpJ + offsetTab8[i][1];

                if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                    tmpOffsetJ >= 0 && tmpOffsetJ < 8)
                    if (chessBoard[tmpOffsetI][tmpOffsetJ].piece == to ||
                        chessBoard[tmpOffsetI][tmpOffsetJ].trigger == to)
                        return true;
            }
            break;
        default:
            me->Say("Jakis dziwaczny range", LANG_UNIVERSAL, 0);
            break;
    }

    return false;
}

void boss_MedivhAI::Reset()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie boss_MedivhAI::Reset()");
#endif

    eventStarted = false;
    miniEventState = MINI_EVENT_NONE;
    miniEventTimer = 5000;
    endGameEventState = GAMEEND_NONE;
    endEventTimer = 2500;
    hordePieces = 16;
    alliancePieces = 16;
    moveTimer = 60000;
    medivhSidePieces.clear();
    tpList.clear();
    moveList.clear();

    chestGUID = 0;

    m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
    m_creature->RemoveFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
    m_creature->SetFlag(UNIT_NPC_FLAGS, UNIT_NPC_FLAG_GOSSIP);
}

void boss_MedivhAI::SayChessPieceDied(Unit * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SayChessPieceDied(Unit * piece)");
#endif

    if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE)
    {
        switch(piece->GetEntry())
        {
            case NPC_ROOK_H:
                DoScriptText(SCRIPTTEXT_LOSE_ROOK_P, m_creature);
                break;
            case NPC_ROOK_A:
                DoScriptText(SCRIPTTEXT_LOSE_ROOK_M, m_creature);
                break;
            case NPC_QUEEN_H:
                DoScriptText(SCRIPTTEXT_LOSE_QUEEN_P, m_creature);
                break;
            case NPC_QUEEN_A:
                DoScriptText(SCRIPTTEXT_LOSE_QUEEN_M, m_creature);
                break;
            case NPC_BISHOP_H:
                DoScriptText(SCRIPTTEXT_LOSE_BISHOP_P, m_creature);
                break;
            case NPC_BISHOP_A:
                DoScriptText(SCRIPTTEXT_LOSE_BISHOP_M, m_creature);
                break;
            case NPC_KNIGHT_H:
                DoScriptText(SCRIPTTEXT_LOSE_KNIGHT_P, m_creature);
                break;
            case NPC_KNIGHT_A:
                DoScriptText(SCRIPTTEXT_LOSE_KNIGHT_M, m_creature);
                break;
            case NPC_PAWN_H:

                DoScriptText(RAND(SCRIPTTEXT_LOSE_PAWN_P_1, SCRIPTTEXT_LOSE_PAWN_P_2, SCRIPTTEXT_LOSE_PAWN_P_3), m_creature);
                break;

            case NPC_PAWN_A:

                DoScriptText(RAND(SCRIPTTEXT_LOSE_PAWN_M_1, SCRIPTTEXT_LOSE_PAWN_M_2), m_creature);
                break;

            case NPC_KING_H:

                DoScriptText(SCRIPTTEXT_MEDIVH_WIN, m_creature);
                pInstance->SetData(DATA_CHESS_EVENT, FAIL);
                endGameEventState = GAMEEND_MEDIVH_WIN;
                endEventTimer = 2500;
                endEventCount = 0;
                break;

            case NPC_KING_A:

                if (pInstance->GetData(DATA_DUST_COVERED_CHEST) != DONE)
                    chestGUID = m_creature->SummonGameObject(DUST_COVERED_CHEST, DUST_COVERED_CHEST_LOCATION, 0, 0, 0, 0, 7200000)->GetGUID();
                //    me->Say("Teraz powinna sie skrzynka pojawic", LANG_UNIVERSAL, NULL); // temporary

                DoScriptText(SCRIPTTEXT_PLAYER_WIN, m_creature);
                pInstance->SetData(DATA_CHESS_EVENT, DONE);
                endGameEventState = GAMEEND_MEDIVH_LOSE;
                endEventTimer = 2500;
                endEventCount = 0;
                break;

            default:
                break;
        }
    }
    else
    {
        switch(piece->GetEntry())
        {
            case NPC_ROOK_A:
                DoScriptText(SCRIPTTEXT_LOSE_ROOK_P, m_creature);
                break;
            case NPC_ROOK_H:
                DoScriptText(SCRIPTTEXT_LOSE_ROOK_M, m_creature);
                break;
            case NPC_QUEEN_A:
                DoScriptText(SCRIPTTEXT_LOSE_QUEEN_P, m_creature);
                break;
            case NPC_QUEEN_H:
                DoScriptText(SCRIPTTEXT_LOSE_QUEEN_M, m_creature);
                break;
            case NPC_BISHOP_A:
                DoScriptText(SCRIPTTEXT_LOSE_BISHOP_P, m_creature);
                break;
            case NPC_BISHOP_H:
                DoScriptText(SCRIPTTEXT_LOSE_BISHOP_M, m_creature);
                break;
            case NPC_KNIGHT_A:
                DoScriptText(SCRIPTTEXT_LOSE_KNIGHT_P, m_creature);
                break;
            case NPC_KNIGHT_H:
                DoScriptText(SCRIPTTEXT_LOSE_KNIGHT_M, m_creature);
                break;
            case NPC_PAWN_A:

                DoScriptText(RAND(SCRIPTTEXT_LOSE_PAWN_P_1, SCRIPTTEXT_LOSE_PAWN_P_2, SCRIPTTEXT_LOSE_PAWN_P_3), m_creature);
                break;

            case NPC_PAWN_H:

                DoScriptText(RAND(SCRIPTTEXT_LOSE_PAWN_M_1, SCRIPTTEXT_LOSE_PAWN_M_2), m_creature);
                break;

            case NPC_KING_A:

                DoScriptText(SCRIPTTEXT_MEDIVH_WIN, m_creature);
                pInstance->SetData(DATA_CHESS_EVENT, FAIL);
                endGameEventState = GAMEEND_MEDIVH_WIN;
                endEventTimer = 2500;
                endEventCount = 0;
                break;

            case NPC_KING_H:

                if (pInstance->GetData(DATA_DUST_COVERED_CHEST) != DONE)
                    chestGUID = m_creature->SummonGameObject(DUST_COVERED_CHEST, DUST_COVERED_CHEST_LOCATION, 0, 0, 0, 0, 7200000)->GetGUID();
                //    me->Say("Teraz powinna sie skrzynka pojawic", LANG_UNIVERSAL, NULL); // temporary

                DoScriptText(SCRIPTTEXT_PLAYER_WIN, m_creature);
                pInstance->SetData(DATA_CHESS_EVENT, DONE);
                endGameEventState = GAMEEND_MEDIVH_LOSE;
                endEventTimer = 2500;
                endEventCount = 0;
                break;

            default:
                break;
        }
    }
}

void boss_MedivhAI::RemoveChessPieceFromBoard(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie RemoveChessPieceFromBoard(uint64 piece = %u)", piece);
#endif

    RemoveChessPieceFromBoard(m_creature->GetCreature(piece));
}

void boss_MedivhAI::RemoveChessPieceFromBoard(Creature * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie RemoveChessPieceFromBoard(Unit * piece = %i)", piece ? 1 : 0);
#endif

    if (!piece)
    {
        me->Say("RemoveChesPieceFromBoard(..) : pionka wcielo", LANG_UNIVERSAL, 0);
        return;
    }

    Creature * tmpC;
    uint32 tmpEntry = GetDeadEntryForPiece(piece->GetEntry());

#ifdef CHESS_DEBUG_INFO
    printf("\ntmpEntry: %u", tmpEntry);
#endif
    if (piece->getFaction() == A_FACTION)
    {
        --alliancePieces;
        tmpC = me->SummonCreature(tmpEntry, allianceSideDeadWP[0][alliancePieces], allianceSideDeadWP[1][alliancePieces], POSITION_Z + 1, ORI_E, TEMPSUMMON_CORPSE_DESPAWN, 0);
    }
    else
    {
        --hordePieces;
        tmpC = me->SummonCreature(tmpEntry, hordeSideDeadWP[0][hordePieces], hordeSideDeadWP[1][hordePieces], POSITION_Z + 1, ORI_W, TEMPSUMMON_CORPSE_DESPAWN, 0);
    }

    if (tmpC)
    {
        tmpC->CombatStop();
        tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NOT_SELECTABLE);
        tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_NON_ATTACKABLE);
        tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_DISABLE_MOVE);
    }

    int tmpI = -1, tmpJ = -1;
    uint64 tmpGUID = piece->GetGUID();

    RemoveFromMoveList(tmpGUID);

    if (FindPlaceInBoard(tmpGUID, tmpI, tmpJ))
        chessBoard[tmpI][tmpJ].piece = 0;

    bool medivhPiece = false;

    for (std::list<uint64>::iterator itr = medivhSidePieces.begin(); itr != medivhSidePieces.end();)
    {
        std::list<uint64>::iterator tmpItr = itr;
        ++itr;

        if ((*tmpItr) == tmpGUID)
        {
            medivhSidePieces.erase(tmpItr);
            medivhPiece = true;
            if (tmpC)
                unusedMedivhPieces.push_back(tmpC->GetGUID());
            break;
        }
    }

    if (!medivhPiece && tmpC)
        unusedPlayerPieces.push_back(tmpC->GetGUID());

    SayChessPieceDied(piece);
}

void boss_MedivhAI::SpawnPawns()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnPawns()");
#endif

    Creature * tmp[2][8];

    for (int i = 0; i < 8; i++)
    {
        tmp[0][i] = m_creature->SummonCreature(NPC_PAWN_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        tmp[1][i] = m_creature->SummonCreature(NPC_PAWN_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);
        if (tmp[0][i])
        {
#ifdef CHESS_DEBUG_INFO
            printf("\nPawns [0][%i] : %u ",i, tmp[0][i]->GetGUID());
#endif
            chessBoard[6][i].piece = tmp[0][i]->GetGUID();
            tmp[0][i]->SetReactState(REACT_PASSIVE);
            tmp[0][i]->GetMotionMaster()->MovePoint(0, chessBoard[6][i].position.coord_x, chessBoard[6][i].position.coord_y, chessBoard[6][i].position.coord_z);
        }
        chessBoard[6][i].ori = CHESS_ORI_N;
        if (tmp[1][i])
        {
#ifdef CHESS_DEBUG_INFO
            printf("\nPawns [1][%i] : %u ",i, tmp[0][i]->GetGUID());
#endif
            chessBoard[1][i].piece = tmp[1][i]->GetGUID();
            tmp[1][i]->SetReactState(REACT_PASSIVE);
            tmp[1][i]->GetMotionMaster()->MovePoint(0, chessBoard[1][i].position.coord_x, chessBoard[1][i].position.coord_y, chessBoard[1][i].position.coord_z);
        }
        chessBoard[1][i].ori = CHESS_ORI_S;
    }

    if (pInstance)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
            for (int i = 0; i < 8; i++)
                medivhSidePieces.push_back(tmp[1][i]->GetGUID());
        else
            for (int i = 0; i < 8; i++)
                medivhSidePieces.push_back(tmp[0][i]->GetGUID());
    }

    miniEventTimer = 10000;
}

void boss_MedivhAI::SpawnRooks()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnRooks()");
#endif
    Creature * tmp1, * tmp2, * tmp3, * tmp4;

    tmp1 = m_creature->SummonCreature(NPC_ROOK_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp1)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nRooks [0] : %u ", tmp1->GetGUID());
#endif
        chessBoard[7][0].piece = tmp1->GetGUID();
        chessBoard[7][0].ori = CHESS_ORI_N;
        tmp1->SetReactState(REACT_PASSIVE);
        tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][0].position.coord_x, chessBoard[7][0].position.coord_y, chessBoard[7][0].position.coord_z);
    }

    tmp2 = m_creature->SummonCreature(NPC_ROOK_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nRooks [1] : %u ", tmp2->GetGUID());
#endif
        chessBoard[7][7].piece = tmp2->GetGUID();
        chessBoard[7][7].ori = CHESS_ORI_N;
        tmp2->SetReactState(REACT_PASSIVE);
        tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][7].position.coord_x, chessBoard[7][7].position.coord_y, chessBoard[7][7].position.coord_z);
    }


    tmp3 = m_creature->SummonCreature(NPC_ROOK_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp3)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nRooks [2] : %u ", tmp3->GetGUID());
#endif
        chessBoard[0][0].piece = tmp3->GetGUID();
        chessBoard[0][0].ori = CHESS_ORI_S;
        tmp3->SetReactState(REACT_PASSIVE);
        tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][0].position.coord_x, chessBoard[0][0].position.coord_y, chessBoard[0][0].position.coord_z);
    }

    tmp4 = m_creature->SummonCreature(NPC_ROOK_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp4)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nRooks [3] : %u ", tmp4->GetGUID());
#endif
        chessBoard[0][7].piece = tmp4->GetGUID();
        chessBoard[0][7].ori = CHESS_ORI_S;
        tmp4->SetReactState(REACT_PASSIVE);
        tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][7].position.coord_x, chessBoard[0][7].position.coord_y, chessBoard[0][7].position.coord_z);
    }

    if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
        {
            medivhSidePieces.push_back(tmp3->GetGUID());
            medivhSidePieces.push_back(tmp4->GetGUID());
        }
        else
        {
            medivhSidePieces.push_back(tmp1->GetGUID());
            medivhSidePieces.push_back(tmp2->GetGUID());
        }
    }
    miniEventTimer = 5000;
}

void boss_MedivhAI::SpawnKnights()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnKnights()");
#endif
    Creature * tmp1, * tmp2, * tmp3, * tmp4;

    tmp1 = m_creature->SummonCreature(NPC_KNIGHT_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp1)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKnights [0] : %u ", tmp1->GetGUID());
#endif
        chessBoard[7][1].piece = tmp1->GetGUID();
        chessBoard[7][1].ori = CHESS_ORI_N;
        tmp1->SetReactState(REACT_PASSIVE);
        tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][1].position.coord_x, chessBoard[7][1].position.coord_y, chessBoard[7][1].position.coord_z);
    }

    tmp2 = m_creature->SummonCreature(NPC_KNIGHT_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKnights [1] : %u ", tmp2->GetGUID());
#endif
        chessBoard[7][6].piece = tmp2->GetGUID();
        chessBoard[7][6].ori = CHESS_ORI_N;
        tmp2->SetReactState(REACT_PASSIVE);
        tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][6].position.coord_x, chessBoard[7][6].position.coord_y, chessBoard[7][6].position.coord_z);
    }


    tmp3 = m_creature->SummonCreature(NPC_KNIGHT_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp3)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKnights [2] : %u ", tmp3->GetGUID());
#endif
        chessBoard[0][1].piece = tmp3->GetGUID();
        chessBoard[0][1].ori = CHESS_ORI_S;
        tmp3->SetReactState(REACT_PASSIVE);
        tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][1].position.coord_x, chessBoard[0][1].position.coord_y, chessBoard[0][1].position.coord_z);
    }

    tmp4 = m_creature->SummonCreature(NPC_KNIGHT_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp4)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKnights [3] : %u ", tmp4->GetGUID());
#endif
        chessBoard[0][6].piece = tmp4->GetGUID();
        chessBoard[0][6].ori = CHESS_ORI_S;
        tmp4->SetReactState(REACT_PASSIVE);
        tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][6].position.coord_x, chessBoard[0][6].position.coord_y, chessBoard[0][6].position.coord_z);
    }

    if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
        {
            medivhSidePieces.push_back(tmp3->GetGUID());
            medivhSidePieces.push_back(tmp4->GetGUID());
        }
        else
        {
            medivhSidePieces.push_back(tmp1->GetGUID());
            medivhSidePieces.push_back(tmp2->GetGUID());
        }
    }
    miniEventTimer = 5000;
}

void boss_MedivhAI::SpawnBishops()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnBishops()");
#endif
    Creature * tmp1, * tmp2, * tmp3, * tmp4;

    tmp1 = m_creature->SummonCreature(NPC_BISHOP_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp1)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nBishops [0] : %u ", tmp1->GetGUID());
#endif
        chessBoard[7][2].piece = tmp1->GetGUID();
        chessBoard[7][2].ori = CHESS_ORI_N;
        tmp1->SetReactState(REACT_PASSIVE);
        tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][2].position.coord_x, chessBoard[7][2].position.coord_y, chessBoard[7][2].position.coord_z);
    }

    tmp2 = m_creature->SummonCreature(NPC_BISHOP_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nBishops [1] : %u ", tmp2->GetGUID());
#endif
        chessBoard[7][5].piece = tmp2->GetGUID();
        chessBoard[7][5].ori = CHESS_ORI_N;
        tmp2->SetReactState(REACT_PASSIVE);
        tmp2->GetMotionMaster()->MovePoint(0, chessBoard[7][5].position.coord_x, chessBoard[7][5].position.coord_y, chessBoard[7][5].position.coord_z);
    }


    tmp3 = m_creature->SummonCreature(NPC_BISHOP_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp3)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nBishops [2] : %u ", tmp3->GetGUID());
#endif
        chessBoard[0][2].piece = tmp3->GetGUID();
        chessBoard[0][2].ori = CHESS_ORI_S;
        tmp3->SetReactState(REACT_PASSIVE);
        tmp3->GetMotionMaster()->MovePoint(0, chessBoard[0][2].position.coord_x, chessBoard[0][2].position.coord_y, chessBoard[0][2].position.coord_z);
    }

    tmp4 = m_creature->SummonCreature(NPC_BISHOP_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp4)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nBishops [3] : %u ", tmp4->GetGUID());
#endif
        chessBoard[0][5].piece = tmp4->GetGUID();
        chessBoard[0][5].ori = CHESS_ORI_S;
        tmp4->SetReactState(REACT_PASSIVE);
        tmp4->GetMotionMaster()->MovePoint(0, chessBoard[0][5].position.coord_x, chessBoard[0][5].position.coord_y, chessBoard[0][5].position.coord_z);
    }

    if (pInstance && tmp1 && tmp2 && tmp3 && tmp4)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
        {
            medivhSidePieces.push_back(tmp3->GetGUID());
            medivhSidePieces.push_back(tmp4->GetGUID());
        }
        else
        {
            medivhSidePieces.push_back(tmp1->GetGUID());
            medivhSidePieces.push_back(tmp2->GetGUID());
        }
    }

    miniEventTimer = 5000;
}

void boss_MedivhAI::SpawnQueens()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnQueens()");
#endif
    Creature * tmp1, * tmp2;

    tmp1 = m_creature->SummonCreature(NPC_QUEEN_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp1)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nQuens [0] : %u ", tmp1->GetGUID());
#endif
        chessBoard[7][3].piece = tmp1->GetGUID();
        chessBoard[7][3].ori = CHESS_ORI_N;
        tmp1->SetReactState(REACT_PASSIVE);
        tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][3].position.coord_x, chessBoard[7][3].position.coord_y, chessBoard[7][3].position.coord_z);
    }

    tmp2 = m_creature->SummonCreature(NPC_QUEEN_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nQuens [1] : %u ", tmp2->GetGUID());
#endif
        chessBoard[0][3].piece = tmp2->GetGUID();
        chessBoard[0][3].ori = CHESS_ORI_S;
        tmp2->SetReactState(REACT_PASSIVE);
        tmp2->GetMotionMaster()->MovePoint(0, chessBoard[0][3].position.coord_x, chessBoard[0][3].position.coord_y, chessBoard[0][3].position.coord_z);
    }

    if (pInstance && tmp1 && tmp2)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
            medivhSidePieces.push_back(tmp2->GetGUID());
        else
            medivhSidePieces.push_back(tmp1->GetGUID());
    }
    miniEventTimer = 5000;
}

void boss_MedivhAI::SpawnKings()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnKings()");
#endif
    Creature * tmp1, * tmp2;

    tmp1 = m_creature->SummonCreature(NPC_KING_A, SPAWN_POS, ORI_N, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp1)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKings [0] : %u", tmp1->GetGUID());
#endif
        chessBoard[7][4].piece = tmp1->GetGUID();
        chessBoard[7][4].ori = CHESS_ORI_N;
        tmp1->SetReactState(REACT_PASSIVE);
        tmp1->GetMotionMaster()->MovePoint(0, chessBoard[7][4].position.coord_x, chessBoard[7][4].position.coord_y, chessBoard[7][4].position.coord_z);
    }

    tmp2 = m_creature->SummonCreature(NPC_KING_H, SPAWN_POS, ORI_S, TEMPSUMMON_CORPSE_TIMED_DESPAWN, 5000);

    if (tmp2)
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nKings [1] : %u ", tmp2->GetGUID());
#endif
        chessBoard[0][4].piece = tmp2->GetGUID();
        chessBoard[0][4].ori = CHESS_ORI_S;
        tmp2->SetReactState(REACT_PASSIVE);
        tmp2->GetMotionMaster()->MovePoint(0, chessBoard[0][4].position.coord_x, chessBoard[0][4].position.coord_y, chessBoard[0][4].position.coord_z);
    }

    if (pInstance && tmp1 && tmp2)
    {
        if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)
            medivhSidePieces.push_back(tmp2->GetGUID());
        else
            medivhSidePieces.push_back(tmp1->GetGUID());
    }
    miniEventTimer = 5000;
}

void boss_MedivhAI::SpawnTriggers()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SpawnTriggers()");
#endif
    Creature * tmp = NULL;

    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            tmp = m_creature->SummonCreature(TRIGGER_ID, chessBoard[i][j].position.coord_x, chessBoard[i][j].position.coord_y, chessBoard[i][j].position.coord_z, ORI_W, TEMPSUMMON_DEAD_DESPAWN, 0);
            if (tmp)
            {
#ifdef CHESS_DEBUG_INFO
                printf("\nTriggers [%i][%i] : %u ", i, j, tmp->GetGUID());
#endif
                chessBoard[i][j].trigger = tmp->GetGUID();
                if (i > 1 && i < 6)
                {
                    chessBoard[i][j].piece = 0;
                    chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
                }
                tmp->SetReactState(REACT_PASSIVE);
            }
        }
    }
}

void boss_MedivhAI::ClearBoard()
{
    Creature * tmpC;
    for (int i = 0; i < 8; ++i)
    {
        for (int j = 0; j < 8; ++j)
        {
            if (tmpC = me->GetCreature(chessBoard[i][j].piece))
            {
                tmpC->SetVisibility(VISIBILITY_OFF);
                tmpC->DestroyForNearbyPlayers();
                tmpC->Kill(tmpC, false);
                tmpC->RemoveCorpse();
            }

            if (tmpC = me->GetCreature(chessBoard[i][j].trigger))
            {
                tmpC->SetVisibility(VISIBILITY_OFF);
                tmpC->DestroyForNearbyPlayers();
                tmpC->Kill(tmpC, false);
                tmpC->RemoveCorpse();
            }

            chessBoard[i][j].piece = 0;
            chessBoard[i][j].trigger = 0;
            chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
        }
    }

    for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
    {
        if (tmpC = me->GetCreature(*itr))
        {
            tmpC->SetVisibility(VISIBILITY_OFF);
            tmpC->DestroyForNearbyPlayers();
            tmpC->Kill(tmpC, false);
            tmpC->RemoveCorpse();
        }
    }

    for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
    {
        if (tmpC = me->GetCreature(*itr))
        {
            tmpC->SetVisibility(VISIBILITY_OFF);
            tmpC->DestroyForNearbyPlayers();
            tmpC->Kill(tmpC, false);
            tmpC->RemoveCorpse();
        }
    }

    unusedMedivhPieces.clear();
    unusedPlayerPieces.clear();
    medivhSidePieces.clear();

    Map::PlayerList const &plList = me->GetMap()->GetPlayers();
    for (Map::PlayerList::const_iterator itr = plList.begin(); itr != plList.end(); ++itr)
        if (Player * plr = itr->getSource())
            plr->RemoveAurasDueToSpell(SPELL_POSSES_CHESSPIECE);
}

void boss_MedivhAI::PrepareBoardForEvent()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie PrepareBoardForEvent()");
#endif

    SpawnTriggers();
    SpawnKings();

    firstCheatTimer = urand(FIRST_CHEAT_TIMER_MIN, FIRST_CHEAT_TIMER_MAX);
    secondCheatTimer = urand(SECOND_CHEAT_TIMER_MIN, SECOND_CHEAT_TIMER_MAX);
    thirdCheatTimer = urand(THIRD_CHEAT_TIMER_MIN, THIRD_CHEAT_TIMER_MAX);
    firstCheatDamageReq = urand(FIRST_CHEAT_HP_MIN*1000, FIRST_CHEAT_HP_MAX*1000)/1000.0;
    secondCheatDamageReq = urand(SECOND_CHEAT_HP_MIN*1000, SECOND_CHEAT_HP_MAX*1000)/1000.0;
    thirdCheatDamagereq = urand(THIRD_CHEAT_HP_MIN*1000, THIRD_CHEAT_HP_MAX*1000)/1000.0;
    pInstance->SetData(DATA_CHESS_DAMAGE, 0);
}

void boss_MedivhAI::StartMiniEvent()
{
    ClearBoard();

    if (chestGUID)
        return;

    miniEventState = MINI_EVENT_KING;

    pInstance->SetData(DATA_DUST_COVERED_CHEST, IN_PROGRESS);
}

void boss_MedivhAI::StartEvent()
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie StartEvent()");
#endif

    DoZoneInCombat();
    eventStarted = true;
    addPieceToMoveCheckTimer = 10000;
}

void boss_MedivhAI::DeleteChest()
{
    if (chestGUID)
    {
        GameObject * tmpObj = me->GetMap()->GetGameObject(chestGUID);
        if (tmpObj)
            tmpObj->Delete();

        chestGUID = 0;
    }
}

void boss_MedivhAI::UpdateAI(const uint32 diff)
{
    if (miniEventState)
    {
        if (miniEventTimer < diff)
        {
            switch(miniEventState)
            {
                case MINI_EVENT_KING:
                    PrepareBoardForEvent();
                    miniEventState = MINI_EVENT_QUEEN;
                    break;
                case MINI_EVENT_QUEEN:
                    SpawnQueens();
                    miniEventState = MINI_EVENT_BISHOP;
                    break;
                case MINI_EVENT_BISHOP:
                    SpawnBishops();
                    miniEventState = MINI_EVENT_KNIGHT;
                    break;
                case MINI_EVENT_KNIGHT:
                    SpawnKnights();
                    miniEventState = MINI_EVENT_ROOK;
                    break;
                case MINI_EVENT_ROOK:
                    SpawnRooks();
                    miniEventState = MINI_EVENT_PAWN;
                    break;
                case MINI_EVENT_PAWN:
                    SpawnPawns();
                    miniEventState = MINI_EVENT_END;
                    break;
                default:
                    miniEventState = MINI_EVENT_NONE;
#ifdef CHESS_DEBUG_INFO
                    printf("\nTablica:");
#endif
                    Creature * tmpC;
                    for (int i = 0; i < 8; i++)
                    {
                        for (int j = 0; j < 8; j++)
                        {
                            ChangePieceFacing(chessBoard[i][j].piece, chessBoard[4][j].trigger);
#ifdef CHESS_DEBUG_INFO
                            printf("\ni: %i, j: %i, piece: %u, trigger: %u", i, j, chessBoard[i][j].piece, chessBoard[i][j].trigger);
#endif
                            if (tmpC = me->GetCreature(chessBoard[i][j].piece))
                            {
                                tmpC->CastSpell(tmpC, SPELL_MOVE_MARKER, false);
                                tmpC->SetFlag(UNIT_FIELD_FLAGS, UNIT_FLAG_IN_COMBAT);
                            }
                        }
                    }
                    moveTimer = 10000;
                    break;
            }
        }
        else
            miniEventTimer -= diff;
        return;
    }

    if (endGameEventState)
    {
        if (endEventTimer < diff)
        {
            Creature * tmpC;
            endEventTimer = 2500;
            switch (endGameEventState)
            {
                case GAMEEND_MEDIVH_WIN:
                    for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
                        if (tmpC = me->GetCreature(*itr))
                            tmpC->HandleEmoteCommand(RAND(EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_APPLAUD));

                    for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
                        if (tmpC = me->GetCreature(*itr))
                            tmpC->HandleEmoteCommand(EMOTE_ONESHOT_CRY);

                    if (endEventCount >= 5)
                        endGameEventState = GAMEEND_CLEAR_BOARD;
                    break;
                case GAMEEND_MEDIVH_LOSE:
                    for (std::list<uint64>::iterator itr = unusedPlayerPieces.begin(); itr != unusedPlayerPieces.end(); ++itr)
                        if (tmpC = me->GetCreature(*itr))
                            tmpC->HandleEmoteCommand(RAND(EMOTE_ONESHOT_CHEER, EMOTE_ONESHOT_APPLAUD));

                    for (std::list<uint64>::iterator itr = unusedMedivhPieces.begin(); itr != unusedMedivhPieces.end(); ++itr)
                        if (tmpC = me->GetCreature(*itr))
                            tmpC->HandleEmoteCommand(EMOTE_ONESHOT_CRY);

                    if (endEventCount >= 5)
                        endGameEventState = GAMEEND_CLEAR_BOARD;
                    break;
                case GAMEEND_CLEAR_BOARD:
                    ClearBoard();
                    endGameEventState = GAMEEND_DESPAWN_CHEST;

                    if (chestGUID)
                        endEventTimer = 180000;
                    break;
                case GAMEEND_DESPAWN_CHEST:
                    DeleteChest();
                    EnterEvadeMode();
                    return;
            }
            endEventCount++;
        }
        else
            endEventTimer -= diff;

        /*if (endEventLightningTimer < diff)
        {
            Creature * tmpC;
            int count = rand()%5;

            for (int i = 0; i < count; ++i)
                if (tmpC = me->GetCreature(chessBoard[rand()%8][rand()%8].trigger))
                    me->CastSpell(tmpC, SPELL_GAME_OVER, true);
            endEventLightningTimer = urand(100, 1000);
        }
        else
            endEventLightningTimer -= diff;*/

        return;
    }

    if (!eventStarted)
        return;

    if (addPieceToMoveCheckTimer <= diff)
    {
        if (urand(0, 100) < chanceToSelfMove)
            ChoosePieceToMove();

        addPieceToMoveCheckTimer = ADD_PIECE_TO_MOVE_TIMER;
    }
    else
        addPieceToMoveCheckTimer -= diff;

    if (firstCheatTimer <= diff)
    {
        if (firstCheatDamageReq < pInstance->GetData(DATA_CHESS_DAMAGE))
        {
            std::list<ChessTile> tmpList;

            for (int i = 0; i < 8; ++i)
                for (int j = 0; j < 8; ++j)
                    if (chessBoard[i][j].piece && !IsMedivhsPiece(chessBoard[i][j].piece))
                        tmpList.push_back(ChessTile(chessBoard[i][j]));

            int tmp = 3;
            if (tmpList.size() < 3)
                tmp = tmpList.size();

            for (int i = 0; i < tmp; ++i)
            {
                std::list<ChessTile>::iterator itr = tmpList.begin();
                advance(itr, urand(0, tmpList.size()-1));

                if (Creature * tmpC = me->GetCreature((*itr).trigger))
                    tmpC->CastSpell(tmpC, SPELL_FURY_OF_MEDIVH, false);

                DoScriptText(SCRIPTTEXT_MEDIVH_CHEAT_1, m_creature);

                tmpList.erase(itr);
            }

            firstCheatTimer = urand(FIRST_CHEAT_TIMER_MIN, FIRST_CHEAT_TIMER_MAX)/2;
        }
        else
            firstCheatTimer = 5000; // next check in 5 seconds
    }
    else
        firstCheatTimer -= diff;

    if (secondCheatTimer <= diff)
    {
        if (secondCheatDamageReq < pInstance->GetData(DATA_CHESS_DAMAGE))
        {
            std::list<ChessTile> tmpList;

            for (int i = 0; i < 8; ++i)
                for (int j = 0; j < 8; ++j)
                    if (chessBoard[i][j].piece && IsMedivhsPiece(chessBoard[i][j].piece))
                        tmpList.push_back(ChessTile(chessBoard[i][j]));

            int tmp = 3;
            if (tmpList.size() < 3)
                tmp = tmpList.size();

            for (int i = 0; i < tmp; ++i)
            {
                std::list<ChessTile>::iterator itr = tmpList.begin();
                advance(itr, urand(0, tmpList.size()-1));

                if (Creature * tmpC = me->GetCreature((*itr).trigger))
                    tmpC->CastSpell(tmpC, SPELL_HAND_OF_MEDIVH, false);

                DoScriptText(SCRIPTTEXT_MEDIVH_CHEAT_2, m_creature);

                tmpList.erase(itr);
            }

            secondCheatTimer = urand(SECOND_CHEAT_TIMER_MIN, SECOND_CHEAT_TIMER_MAX)/2;
        }
        else
            secondCheatTimer = 5000; // next check in 5 seconds
    }
    else
        secondCheatTimer -= diff;

    if (thirdCheatTimer <= diff)
    {
        if (thirdCheatDamagereq < pInstance->GetData(DATA_CHESS_DAMAGE))
        {
            for (std::list<uint64>::iterator itr = medivhSidePieces.begin(); itr != medivhSidePieces.end(); ++itr)
                if (Creature * tmpC = me->GetCreature(*itr))
                    tmpC->SetHealth(tmpC->GetMaxHealth());

            DoScriptText(SCRIPTTEXT_MEDIVH_CHEAT_3, m_creature);

            thirdCheatTimer = urand(THIRD_CHEAT_TIMER_MIN, THIRD_CHEAT_TIMER_MAX)/2;
        }
        else
            thirdCheatTimer = 5000; // next check in 5 seconds
    }
    else
        thirdCheatTimer -= diff;
}

void boss_MedivhAI::SetOrientation(uint64 piece, ChessOrientation ori)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie SetOrientation(uint64 piece = %u, ChessOrientation ori = %i)", piece, ori);
#endif
    int tmpi = -1, tmpj = -1;    //temp piece location in array

    if (!FindPlaceInBoard(piece, tmpi, tmpj))
        return;

    if (ori == CHESS_ORI_CHOOSE)
    {
        float tmpN = 99, tmpS = 99, tmpE = 99, tmpW = 99;
        float pieceOri;

        Creature * tmpPiece = m_creature->GetCreature(piece);
        if (tmpPiece)
        {
            pieceOri = tmpPiece->GetOrientation();
            if (pieceOri <0)
                pieceOri += 2* M_PI;
            if (pieceOri > ORI_N && pieceOri <= ORI_W)
            {
                tmpN = pieceOri - ORI_N;
                tmpW = ORI_W - pieceOri;

                if (tmpN < tmpW)
                    ori = CHESS_ORI_N;
                else
                    ori = CHESS_ORI_W;
            }
            else if (pieceOri > ORI_W && pieceOri <= ORI_S)
            {
                tmpW = pieceOri - ORI_W;
                tmpS = ORI_S - pieceOri;

                if (tmpW < tmpS)
                    ori = CHESS_ORI_W;
                else
                    ori = CHESS_ORI_S;
            }
            else if (pieceOri > ORI_S && pieceOri <= ORI_E)
            {
                tmpS = pieceOri - ORI_S;
                tmpE = ORI_E - pieceOri;

                if (tmpS < tmpE)
                    ori = CHESS_ORI_S;
                else
                    ori = CHESS_ORI_E;
            }
            else if (pieceOri > ORI_E)
            {
                tmpE = pieceOri - ORI_E;
                tmpN = 6.28 + ORI_N - pieceOri;

                if (tmpE < tmpN)
                    ori = CHESS_ORI_E;
                else
                    ori = CHESS_ORI_N;
            }
            else if (pieceOri <= ORI_N)
            {
                tmpW = 6.28 + pieceOri - ORI_E;
                tmpN = ORI_N - pieceOri;

                if (tmpE < tmpN)
                    ori = CHESS_ORI_E;
                else
                    ori = CHESS_ORI_N;
            }
        }
#ifdef CHESS_DEBUG_INFO
        printf("\npieceori: %f, tmpW: %f, tmpE: %f, tmpN: %f, tmpS: %f", pieceOri, tmpW, tmpE, tmpN, tmpS);
#endif
    }

#ifdef CHESS_DEBUG_INFO
    printf("\nori: %i", ori);
#endif

    chessBoard[tmpi][tmpj].ori = ori;

    Creature * cPiece = m_creature->GetMap()->GetCreature(piece);
    if (cPiece)
    {
        switch (ori)
        {
            case CHESS_ORI_N:
                cPiece->SetOrientation(ORI_N);
                break;
            case CHESS_ORI_E:
                cPiece->SetOrientation(ORI_E);
                break;
            case CHESS_ORI_S:
                cPiece->SetOrientation(ORI_S);
                break;
            case CHESS_ORI_W:
                cPiece->SetOrientation(ORI_W);
                break;
            default:
                break;
        }

        cPiece->SendHeartBeat();
/*
        me->GetMap()->CreatureRelocation(cPiece, chessBoard[tmpi][tmpj].position.coord_x, chessBoard[tmpi][tmpj].position.coord_y, chessBoard[tmpi][tmpj].position.coord_z, cPiece->GetOrientation());

        Map::PlayerList const& players = m_creature->GetMap()->GetPlayers();

        if (!players.isEmpty())
            for(Map::PlayerList::const_iterator itr = players.begin(); itr != players.end(); ++itr)
                if (Player* plr = itr->getSource())
                    cPiece->NearTeleportTo(chessBoard[tmpi][tmpj].position.coord_x, chessBoard[tmpi][tmpj].position.coord_y, chessBoard[tmpi][tmpj].position.coord_z, 0);
*/
    }
}

uint64 boss_MedivhAI::FindTriggerGUID(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie FindTriggerGUID(uint64 piece = %u)", piece);
#endif
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            if (chessBoard[i][j].piece == piece)
                return chessBoard[i][j].trigger;
        }
    }

    return 0;
}

Creature * boss_MedivhAI::FindTrigger(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie FindTrigger(uint64 piece = %u)", piece);
#endif
    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            if (chessBoard[i][j].piece == piece)
                return m_creature->GetCreature(chessBoard[i][j].trigger);
        }
    }

    return NULL;
}

bool boss_MedivhAI::ChessSquareIsEmpty(uint64 trigger)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChessSquareIsEmpty(uint64 trigger = %u)", trigger);
#endif
    if (IsInMoveList(trigger, true))
        return false;

    for (int i = 0; i < 8; i++)
    {
        for (int j = 0; j < 8; j++)
        {
            if (chessBoard[i][j].trigger == trigger)
            {
                if (chessBoard[i][j].piece)
                    return false;
                else
                    return true;
            }
        }
    }

    return false;
}

bool boss_MedivhAI::ChessSquareIsEmpty(int i, int j)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChessSquareIsEmpty(int i = %i, int j = %i)", i, j);
#endif
    if (IsInMoveList(chessBoard[i][j].trigger))
        return false;

    if (chessBoard[i][j].piece)
        return false;

    return true;
}

bool boss_MedivhAI::CanMoveTo(uint64 trigger, uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie CanMoveTo(uint64 trigger = %u, uint64 piece = %u)", trigger, piece);
#endif
    if (!trigger || !piece)
        return false;

    int moveRange = GetMoveRange(piece);
    bool inRange = IsInMoveRange(piece, trigger, moveRange);
    bool isEmpty = ChessSquareIsEmpty(trigger);
#ifdef CHESS_DEBUG_INFO
    printf("\nCanMoveTo: moveRange %i, isInRange %i, isEmpty %i", moveRange, inRange, isEmpty);
#endif
    return inRange && isEmpty;
}

void boss_MedivhAI::AddTriggerToMove(uint64 trigger, uint64 piece, bool player)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie AddTriggerToMove(uint64 trigger = %u, uint64 piece = %u, bool player = %i)", trigger, piece, player);
#endif
    RemoveFromMoveList(piece);
    ChessTile tmp;
    tmp.piece = piece;
    tmp.trigger = trigger;

    moveList.push_back(tmp);

    uint16 tmpChance = urand(0, 100);

    //check, if tmpChance is higher than chanceToMove then medivh also can move one of his pieces
    if (player && tmpChance < chanceToMove)
        ChoosePieceToMove();
}

void boss_MedivhAI::RemoveFromMoveList(uint64 unit)
{
    for (std::list<ChessTile>::iterator itr = moveList.begin(); itr != moveList.end();)
    {
        std::list<ChessTile>::iterator tmpItr = itr;
        ++itr;
        if ((*tmpItr).piece == unit || (*tmpItr).trigger == unit)
        {
            if (Creature * tmpC = me->GetCreature((*tmpItr).trigger))
                ((move_triggerAI*)tmpC->AI())->RemoveFromMove((*tmpItr).piece);

            moveList.erase(tmpItr);
            return;
        }
    }
}

void boss_MedivhAI::ChangePlaceInBoard(uint64 piece, uint64 destTrigger)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChangePlaceInBoard(uint64 piece = %u, uint64 destTrigger = %u)", piece, destTrigger);
#endif
    for (int i = 0; i < 8; ++i)
    {
        for (int j = 0; j < 8; ++j)
        {
            if (chessBoard[i][j].piece == piece && chessBoard[i][j].trigger != destTrigger)
            {
                chessBoard[i][j].piece = 0;
                chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
            }

            if (chessBoard[i][j].trigger == destTrigger)
            {
                chessBoard[i][j].piece = piece;
                chessBoard[i][j].ori = CHESS_ORI_CHOOSE;
            }
        }
    }

}

void boss_MedivhAI::ChangePieceFacing(uint64 piece, uint64 destTrigger)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChangePieceFacing(uint64 piece = %u, uint64 destTrigger = %u)", piece, destTrigger);
#endif
    ChangePieceFacing(me->GetCreature(piece), me->GetCreature(destTrigger));
}

void boss_MedivhAI::ChangePieceFacing(Creature * piece, Creature * destTrigger)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChangePieceFacing(Creature * piece = %i, Creature * destTrigger = %i)", piece ? 1 : 0, destTrigger ? 1 : 0);
#endif

    if (!piece || !destTrigger)
        return;

    piece->SetInFront(destTrigger);
    SetOrientation(piece->GetGUID());
/*
    int tmpI = -1, tmpJ = -1;

    if (!FindPlaceInBoard(piece->GetGUID(), tmpI, tmpJ))
        return;

    Creature * tmpC = NULL;
    switch (chessBoard[tmpI][tmpJ].ori)
    {
        case CHESS_ORI_N:
            tmpC = me->GetCreature(chessBoard[tmpI - 1][tmpJ].trigger);
            break;
        case CHESS_ORI_E:
            tmpC = me->GetCreature(chessBoard[tmpI][tmpJ + 1].trigger);
            break;
        case CHESS_ORI_S:
            tmpC = me->GetCreature(chessBoard[tmpI + 1][tmpJ].trigger);
            break;
        case CHESS_ORI_W:
            tmpC = me->GetCreature(chessBoard[tmpI][tmpJ - 1].trigger);
            break;
    }

    if (tmpC)
        piece->SetFacingToObject(tmpC);
*/
}

uint32 boss_MedivhAI::GetMoveSpell(uint64 piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetMoveSpell(uint64 piece = %u)", piece);
#endif
    return GetMoveSpell(me->GetCreature(piece));
}

uint32 boss_MedivhAI::GetMoveSpell(Creature * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetMoveSpell(Creature * piece = %i)", piece ? 1 : 0);
#endif
    if (!piece)
        return 0;

    switch (piece->GetEntry())
    {
        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
            return SPELL_MOVE_4;
        case NPC_KING_A:
        case NPC_KING_H:
            return SPELL_MOVE_5;
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
            return SPELL_MOVE_6;
        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
            return SPELL_MOVE_3;
        case NPC_ROOK_A:
        case NPC_ROOK_H:
            return SPELL_MOVE_7;
        case NPC_PAWN_A:
        case NPC_PAWN_H:
            return SPELL_MOVE_1;
    }

    return 0;
}

bool boss_MedivhAI::FindPlaceInBoard(uint64 unit, int & i, int & j)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie: FindPlaceInBoard(uint64 unit = %u, int & i = %i, int & j = %i)", unit, i, j);
#endif
    for (int x = 0; x < 8; ++x)
    {
        for (int y = 0; y < 8; ++y)
        {
            if (chessBoard[x][y].piece == unit || chessBoard[x][y].trigger == unit)
            {
                i = x;
                j = y;
                return true;
            }
        }
    }
    return false;
}

/*
pseudocode:

    for each medivh piece:
        calculate actual square priority
        for each square in range:
            if square is empty and isn't in move list then:
                calculate priority
                if priority is > 0
                    add square info (priority) to list
                    sum priority
        if square info list in not empty
            choose random priority from 0 to priority sum
            search for square for randomed priority
            if chosen position is better than actual position (rand(0, chosen+actual) > actual)
                add possible move to list

    sum square move priorities
    choose random (or best ?) move from list

    make move to chosen

Calculate Priority:
    set base priority for square
    modify priority based on count of enemies in melee
    modify priority based on way were we want to move
*/

int boss_MedivhAI::CalculatePriority(uint64 piece, uint64 trigger)
{
    // set base priority for square
    int tmpPrior = START_PRIORITY;
    int pieceId = GetEntry(piece);

    // modify priority based on count of enemies in melee

    int meleeCount = GetCountOfEnemyInMelee(piece, true);

    switch (pieceId)
    {
        case NPC_PAWN_A:
        case NPC_PAWN_H:
            switch (meleeCount)
            {
                case 0:
                    tmpPrior += MELEE_PRIORITY_1_0;
                    break;
                case 1:
                    tmpPrior += MELEE_PRIORITY_1_1;
                    break;
                case 2:
                    tmpPrior += MELEE_PRIORITY_1_2;
                    break;
                case 3:
                    tmpPrior += MELEE_PRIORITY_1_3;
                    break;
                default:
                    tmpPrior += MELEE_PRIORITY_1_4;
                    break;
            }
            break;

        case NPC_ROOK_A:
        case NPC_ROOK_H:
        case NPC_KNIGHT_A:
        case NPC_KNIGHT_H:
            switch (meleeCount)
            {
                case 0:
                    tmpPrior += MELEE_PRIORITY_2_0;
                    break;
                case 1:
                    tmpPrior += MELEE_PRIORITY_2_1;
                    break;
                case 2:
                    tmpPrior += MELEE_PRIORITY_2_2;
                    break;
                case 3:
                    tmpPrior += MELEE_PRIORITY_2_3;
                    break;
                default:
                    tmpPrior += MELEE_PRIORITY_2_4;
                    break;
            }
            break;

        case NPC_KING_A:
        case NPC_KING_H:
            switch (meleeCount)
            {
                case 0:
                    tmpPrior += MELEE_PRIORITY_3_0;
                    break;
                case 1:
                    tmpPrior += MELEE_PRIORITY_3_1;
                    break;
                case 2:
                    tmpPrior += MELEE_PRIORITY_3_2;
                    break;
                case 3:
                    tmpPrior += MELEE_PRIORITY_3_3;
                    break;
                default:
                    tmpPrior += MELEE_PRIORITY_3_4;
                    break;
            }
            break;

        case NPC_QUEEN_A:
        case NPC_QUEEN_H:
        case NPC_BISHOP_A:
        case NPC_BISHOP_H:
            switch (meleeCount)
            {
                case 0:
                    tmpPrior += MELEE_PRIORITY_4_0;
                    break;
                case 1:
                    tmpPrior += MELEE_PRIORITY_4_1;
                    break;
                case 2:
                    tmpPrior += MELEE_PRIORITY_4_2;
                    break;
                case 3:
                    tmpPrior += MELEE_PRIORITY_4_3;
                    break;
                default:
                    tmpPrior += MELEE_PRIORITY_4_4;
                    break;
            }
            break;
    }

    // modify priority based on way were we want to move

    int tmpIP, tmpJP, tmpIT, tmpJT;

    if (FindPlaceInBoard(piece, tmpIP, tmpJP) && FindPlaceInBoard(trigger, tmpIT, tmpJT))
    {
        if (tmpIP == tmpIT && tmpJP == tmpJT)
            tmpPrior += STAY_IN_PLACE_PRIOR_MOD;
        else
        {
            if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE)   // if player is alliance
            {
                if (tmpIP < 2)
                {
                    if (tmpIP > tmpIT)
                        tmpPrior += MOVE_BACK_PRIOR_MOD;
                    else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                        tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                    else
                        tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                }
                else
                {
                    if (tmpIP > 5)
                    {
                        if (tmpIP < tmpIT)
                            tmpPrior += MOVE_BACK_PRIOR_MOD;
                        else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                            tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                        else
                            tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                    }
                    else
                    {
                        if (tmpIP < 4)
                        {
                            if (tmpIP > tmpIT)
                                tmpPrior += MOVE_BACK_PRIOR_MOD/2;
                            else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                            else
                                tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                        }
                        else
                        {
                            if (tmpIP > 3)
                            {
                                if (tmpIP > tmpIT)
                                    tmpPrior += MOVE_BACK_PRIOR_MOD/3;
                                else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                    tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                else
                                    tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                            }
                        }
                    }
                }
            }
            else
            {
                if (tmpIP > 5)
                {
                    if (tmpIP < tmpIT)
                        tmpPrior += MOVE_BACK_PRIOR_MOD;
                    else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                        tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                    else
                        tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                }
                else
                {
                    if (tmpIP < 2)
                    {
                        if (tmpIP > tmpIT)
                            tmpPrior += MOVE_BACK_PRIOR_MOD;
                        else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                            tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/4 : MOVE_STRAFE_PRIOR_MOD);
                        else
                            tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                    }
                    else
                    {
                        if (tmpIP > 3)
                        {
                            if (tmpIP < tmpIT)
                                tmpPrior += MOVE_BACK_PRIOR_MOD/2;
                            else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                            else
                                tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                        }
                        else
                        {
                            if (tmpIP < 4)
                            {
                                if (tmpIP < tmpIT)
                                    tmpPrior += MOVE_BACK_PRIOR_MOD/3;
                                else if (/*tmpIP == tmpIT && */tmpJP != tmpJT)
                                    tmpPrior += (tmpIP != tmpIT ? MOVE_STRAFE_PRIOR_MOD/8 : MOVE_STRAFE_PRIOR_MOD/4);
                                else
                                    tmpPrior += MOVE_DEFAULT_PRIOR_MOD;
                            }
                        }
                    }
                }
            }
        }
    }

    return tmpPrior;
}

void boss_MedivhAI::ChoosePieceToMove()
{
#ifdef CHESS_EVENT_DISSABLE_MEDIVH_PIECES_MOVEMENT
    return;
#endif

#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie ChoosePieceToMove()");
#endif

    std::list<Priority> possibleMoveList;
    int possibleMovePrioritySum = 0;

    // for each medivh piece
    for (std::list<uint64>::const_iterator pieceItr = medivhSidePieces.begin(); pieceItr != medivhSidePieces.end(); ++pieceItr)
    {
        if (IsInMoveList(*pieceItr))
            continue;

        std::list<Priority> tmpPriorList;
        int priorSum = 0, i, tmpOffsetI, tmpOffsetJ, tmpI, tmpJ;
        // calculate actual square prior
        int actualPriority = CalculatePriority(*pieceItr, FindTriggerGUID(*pieceItr));

        if (!FindPlaceInBoard(*pieceItr, tmpI, tmpJ))
            continue;

        // for each sqare in range
        switch (GetMoveRange(*pieceItr))
        {
            case 25:
                for (i = 0; i < OFFSET25COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab25[i][0];
                    tmpOffsetJ = tmpJ + offsetTab25[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                        chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                        !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                    {
                        Priority prior;
                        prior.GUIDfrom = *pieceItr;
                        prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                        // calculate priority
                        prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                        // if priority is > 0
                        if (prior.prior > 0)
                        {
                            tmpPriorList.push_back(prior);  // add square info (priority) to list
                            priorSum += prior.prior;        // sum priority
                        }
                    }
                }
            case 20:
                for (i = 0; i < OFFSET20COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab20[i][0];
                    tmpOffsetJ = tmpJ + offsetTab20[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                        chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                        !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                    {
                        Priority prior;
                        prior.GUIDfrom = *pieceItr;
                        prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                        // calculate priority
                        prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                        // if priority is > 0
                        if (prior.prior > 0)
                        {
                            tmpPriorList.push_back(prior);  // add square info (priority) to list
                            priorSum += prior.prior;        // sum priority
                        }
                    }

                }
            case 15:
                for (i = 0; i < OFFSET15COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab15[i][0];
                    tmpOffsetJ = tmpJ + offsetTab15[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                        chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                        !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                    {
                        Priority prior;
                        prior.GUIDfrom = *pieceItr;
                        prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                        // calculate priority
                        prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                        // if priority is > 0
                        if (prior.prior > 0)
                        {
                            tmpPriorList.push_back(prior);  // add square info (priority) to list
                            priorSum += prior.prior;        // sum priority
                        }
                    }

                }
            case 8:
                for (i = 0; i < OFFSET8COUNT; i++)
                {
                    tmpOffsetI = tmpI + offsetTab8[i][0];
                    tmpOffsetJ = tmpJ + offsetTab8[i][1];

                    if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
                        tmpOffsetJ >= 0 && tmpOffsetJ < 8 &&
                        chessBoard[tmpOffsetI][tmpOffsetJ].piece == 0 &&                // if square is empty
                        !IsInMoveList(chessBoard[tmpOffsetI][tmpOffsetJ].trigger, true))// and isn't in move list
                    {
                        Priority prior;
                        prior.GUIDfrom = *pieceItr;
                        prior.GUIDto = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                        // calculate priority
                        prior.prior = CalculatePriority(prior.GUIDfrom, prior.GUIDto);

                        // if priority is > 0
                        if (prior.prior > 0)
                        {
                            tmpPriorList.push_back(prior);  // add square info (priority) to list
                            priorSum += prior.prior;        // sum priority
                        }
                    }

                }
                break;
            default:
                me->Say("Jakis dziwaczny range", LANG_UNIVERSAL, 0);
                break;
        }

        // if square info list in not empty
        if (tmpPriorList.empty() || priorSum <= 0)
            continue;

        switch (rand()%2)
        {
            case 0:
            {
                // choose random priority from 0 to priority sum
                int chosenPrior = urand(0, priorSum);
                int tmpPriorSum = 0;
                // search for randomed square
                for (std::list<Priority>::iterator priorItr = tmpPriorList.begin(); priorItr != tmpPriorList.end(); ++ priorItr)
                {
                    if (chosenPrior >= tmpPriorSum && chosenPrior < tmpPriorSum + (*priorItr).prior)
                    {
                        // rand if chosen position is better than actual position
                        if (urand(0, actualPriority + (*priorItr).prior) > actualPriority)
                        {
                            possibleMoveList.push_back(*priorItr);          // add possible move to list
                            possibleMovePrioritySum += (*priorItr).prior;   // sum square move priorities
                        }
#ifdef CHESS_DEBUG_INFO
                        else
                        {
                            if (Creature * tmpC = me->GetCreature(*pieceItr))
                                tmpC->Say("hmm ... Powinienem jednak zostac gdzie stoje ...", LANG_UNIVERSAL, NULL);
                            printf("\nPiece: %u, prior: %i, actual: %i | STAY IN HOME", *pieceItr, (*priorItr).prior, actualPriority);
                        }
#endif

                        break;
                    }

                    tmpPriorSum += (*priorItr).prior;
                }
                break;
            }
            case 1:
            {
                std::list<Priority> bestList;
                if (tmpPriorList.empty())
                    continue;

                Priority best = tmpPriorList.front();
                for (std::list<Priority>::iterator itr = tmpPriorList.begin(); itr != tmpPriorList.end(); ++itr)
                {
                    if (best.prior < (*itr).prior)
                    {
                        best = *itr;
                        bestList.clear();
                        bestList.push_back(*itr);
                    }
                    else if (best.prior == (*itr).prior)
                    {
                        bestList.push_back(*itr);
                    }
                }

                if (bestList.empty())
                    continue;

                std::list<Priority>::iterator itr = bestList.begin();
                advance(itr, urand(0, bestList.size()-1));

                possibleMoveList.push_back(*itr);          // add possible move to list
                possibleMovePrioritySum += (*itr).prior;   // sum square move priorities
                break;
            }
        }
    }

    if (possibleMoveList.empty())
        return;

    Priority chosen;
#ifdef CHESS_DEBUG_INFO
    int method;
#endif
    if (rand()%2)
    {
#ifdef CHESS_DEBUG_INFO
        method = 1;
#endif
        // choose random move from list
        int tmpChosenPrior = urand(0, possibleMovePrioritySum);
        int tmpPriorSum = 0;
        for (std::list<Priority>::iterator itr = possibleMoveList.begin(); itr != possibleMoveList.end(); ++itr)
        {
            if (tmpChosenPrior >= tmpPriorSum && tmpChosenPrior < tmpPriorSum + (*itr).prior)
            {
                chosen = *itr;
                break;
            }

            tmpPriorSum += (*itr).prior;
        }
    }
    else
    {
        #ifdef CHESS_DEBUG_INFO
        method = 2;
        #endif
        // choose best move from list
        Priority best = possibleMoveList.front();
        for (std::list<Priority>::iterator itr = possibleMoveList.begin(); itr != possibleMoveList.end(); ++itr)
            if (best.prior < (*itr).prior)
                best = *itr;

        chosen = best;
    }

    if (!chosen.GUIDfrom || !chosen.GUIDto)
        return;

    // make move to chosen
    Creature * tmpC = me->GetCreature(chosen.GUIDfrom);
    Creature * tmpT = me->GetCreature(chosen.GUIDto);

    if (tmpC && tmpT)
        tmpC->CastSpell(tmpT, GetMoveSpell(tmpC), false);
    else
    {
#ifdef CHESS_DEBUG_INFO
        printf("\nchosen.GUIDfrom: %u, %i | chosen.GUIDto: %u, %i | method: %i | isMedivhPiece: %i", chosen.GUIDfrom, tmpC ? 1 : 0, chosen.GUIDto, tmpT ? 1 : 0, method, IsMedivhsPiece(chosen.GUIDfrom));
#endif
        me->Say("Cosik mi sie wybrany pionek albo trigger gdzies zgubil", LANG_UNIVERSAL, 0);
    }
}

uint32 boss_MedivhAI::GetEntry(uint64 piece)
{
    Creature * tmp = me->GetCreature(piece);
    if (!tmp)
        return 0;

    return tmp->GetEntry();
}

uint32 boss_MedivhAI::GetDeadEntryForPiece(Creature * piece)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetDeadEntryForPiece(Creature * piece = %i)", piece);
#endif
    if (!piece)
        return 0;

    return GetDeadEntryForPiece(piece->GetEntry());
}

uint32 boss_MedivhAI::GetDeadEntryForPiece(uint32 entry)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie GetDeadEntryForPiece(uint32 entry = %u)", entry);
#endif

    switch (entry)
    {
        case NPC_PAWN_H:
            return 16556;
        case NPC_PAWN_A:
            return 16567;
        case NPC_KNIGHT_H:
            return 16561;
        case NPC_KNIGHT_A:
            return 16569;
        case NPC_QUEEN_H:
            return 16557;
        case NPC_QUEEN_A:
            return 16572;
        case NPC_BISHOP_H:
            return 16560;
        case NPC_BISHOP_A:
            return 16571;
        case NPC_ROOK_H:
            return 16562;
        case NPC_ROOK_A:
            return 16570;
        case NPC_KING_H:
            return 16563;
        case NPC_KING_A:
            return 16581;
        default:
            return 0;
    }

    return 0;
}

void boss_MedivhAI::CheckChangeFacing(uint64 piece, int i, int j)
{
#ifdef CHESS_DEBUG_INFO
    printf("\n Wywolanie boss_MedivhAI::CheckChangeFacing(uint64 piece = %u, int i = %i, int j = %i)", piece, i, j);
#endif
    if (i == -1 || j == -1)
        if (!FindPlaceInBoard(piece, i, j))
            return;

    if (IsInMoveList(piece))
        return;

    ChessOrientation actualOri = chessBoard[i][j].ori;
    ChessOrientation tmpOri;
    ChessOrientation targetOri = CHESS_ORI_CHOOSE;
    uint64 target = 0, tmpTarget = 0, targetTrigger = 0;
    int targetPrior = 0, tmpPrior = 0;

    for (int k = 0; k < OFFSETMELEECOUNT; ++k)
    {
        int tmpOffsetI = offsetTabMelee[k][0];
        int tmpOffsetJ = offsetTabMelee[k][1];

        if (tmpOffsetI == 0)
        {
            if (tmpOffsetJ == 1)
                tmpOri = CHESS_ORI_E;
            else
                tmpOri = CHESS_ORI_W;
        }
        else if (tmpOffsetJ == 0)
        {
            if (tmpOffsetI == 1)
                tmpOri = CHESS_ORI_S;
            else
                tmpOri = CHESS_ORI_N;
        }

        tmpOffsetI += i;
        tmpOffsetJ += j;

        if (tmpOffsetI >= 0 && tmpOffsetI < 8 &&
            tmpOffsetJ >= 0 && tmpOffsetJ < 8)
        {
            tmpTarget = chessBoard[tmpOffsetI][tmpOffsetJ].piece;
            if (Enemy(piece, tmpTarget))
            {
                tmpPrior = GetAttackPriority(tmpTarget);

                if (tmpPrior > targetPrior)
                {
                    target = tmpTarget;
                    targetOri = tmpOri;
                    targetPrior = tmpPrior;
                    targetTrigger = chessBoard[tmpOffsetI][tmpOffsetJ].trigger;

                }
            }
        }
    }

    if (targetOri != CHESS_ORI_CHOOSE)
    {
        if (targetOri != actualOri)
        {
            Creature * tmpC = me->GetCreature(piece);
            Creature * tmpT = me->GetCreature(targetTrigger);
            if (tmpC && tmpT)
                tmpC->CastSpell(tmpT, SPELL_CHANGE_FACING, false);
            #ifdef CHESS_DEBUG_INFO
            else
                printf("\nChangeFacing: nima tmpC (%i | guid: %u) lub tmpT (%i | guid: %u), prior: %i", tmpC ? 1 : 0, piece, tmpT ? 1 : 0, targetTrigger, targetPrior);
            #endif
        }
    }
}

//other

bool GossipHello_npc_chesspiece(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = ((ScriptedInstance*)_Creature->GetInstanceData());

    if (!pInstance)
        return false;

    if (pInstance->GetData(CHESS_EVENT_TEAM) == ALLIANCE && _Creature->getFaction() != A_FACTION)
        return false;

    if (pInstance->GetData(CHESS_EVENT_TEAM) == HORDE && _Creature->getFaction() != H_FACTION)
        return false;

    if (player->HasAura(SPELL_RECENTLY_IN_GAME, 0) || _Creature->HasAura(SPELL_RECENTLY_IN_GAME, 0))
    {
        player->SEND_GOSSIP_MENU(10505, _Creature->GetGUID());
        return true;
    }

    if (!(_Creature->isPossessedByPlayer()))
    {
        switch (_Creature->GetEntry())
        {
            case NPC_PAWN_H:
                player->ADD_GOSSIP_ITEM(0, "Control Orc Grunt", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10425, _Creature->GetGUID());
                break;
            case NPC_PAWN_A:
                player->ADD_GOSSIP_ITEM(0, "Control Human Footman", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(8952, _Creature->GetGUID());
                break;
            case NPC_KNIGHT_H:
                player->ADD_GOSSIP_ITEM(0, "Control Orc Wolf", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10439, _Creature->GetGUID());
                break;
            case NPC_KNIGHT_A:
                player->ADD_GOSSIP_ITEM(0, "Control Human Charger", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10414, _Creature->GetGUID());
                break;
            case NPC_QUEEN_H:
                player->ADD_GOSSIP_ITEM(0, "Control Orc Warlock", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10440, _Creature->GetGUID());
                break;
            case NPC_QUEEN_A:
                player->ADD_GOSSIP_ITEM(0, "Control Human Conjurer", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10417, _Creature->GetGUID());
                break;
            case NPC_BISHOP_H:
                player->ADD_GOSSIP_ITEM(0, "Control Orc Necrolyte", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10434, _Creature->GetGUID());
                break;
            case NPC_BISHOP_A:
                player->ADD_GOSSIP_ITEM(0, "Control Human Cleric", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10416, _Creature->GetGUID());
                break;
            case NPC_ROOK_H:
                player->ADD_GOSSIP_ITEM(0, "Control Summoned Daemon", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10426, _Creature->GetGUID());
                break;
            case NPC_ROOK_A:
                player->ADD_GOSSIP_ITEM(0, "Control Conjured Water Elemental", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10413, _Creature->GetGUID());
                break;
            case NPC_KING_H:
                player->ADD_GOSSIP_ITEM(0, "Control Warchief Blackhand", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10442, _Creature->GetGUID());
                break;
            case NPC_KING_A:
                player->ADD_GOSSIP_ITEM(0, "Control King Llane", GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF + 1);
                player->SEND_GOSSIP_MENU(10418, _Creature->GetGUID());
                break;
        }
    }

    return true;
}

void npc_chess_statusAI::Reset()
{
    m_creature->SetLevitate(true);
    m_creature->NearTeleportTo(-11080.599609, -1876.380005, 231.000092, 0.0);
    me->CastSpell(me, SPELL_GAME_IN_SESSION, false);
}

bool GossipSelect_npc_chesspiece(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    ScriptedInstance* pInstance = ((ScriptedInstance*)_Creature->GetInstanceData());
    if (action == GOSSIP_ACTION_INFO_DEF + 1)
    {
        if (_Creature->GetEntry() == NPC_KING_A || _Creature->GetEntry() == NPC_KING_H)
        {
            pInstance->SetData(DATA_CHESS_EVENT, IN_PROGRESS);
            ((boss_MedivhAI*)(_Creature->GetCreature(pInstance->GetData64(DATA_CHESS_ECHO_OF_MEDIVH))->AI()))->StartEvent();
        }

        player->TeleportTo(_Creature->GetMapId(), -11108.2, -1841.56, 229.625, 5.39745);
        player->CastSpell(_Creature, SPELL_POSSES_CHESSPIECE, true);
    }

    player->CLOSE_GOSSIP_MENU();

    return true;
}

bool GossipHello_npc_echo_of_medivh(Player* player, Creature* _Creature)
{
    ScriptedInstance* pInstance = ((ScriptedInstance*)_Creature->GetInstanceData());

    if (pInstance->GetData(DATA_CHESS_EVENT) == IN_PROGRESS)
        return false;

    pInstance->SetData(DATA_CHESS_EVENT, NOT_STARTED);

    player->ADD_GOSSIP_ITEM(0, EVENT_START, GOSSIP_SENDER_MAIN, GOSSIP_ACTION_INFO_DEF);
    player->SEND_GOSSIP_MENU(10506, _Creature->GetGUID());

    return true;
}

bool GossipSelect_npc_echo_of_medivh(Player* player, Creature* _Creature, uint32 sender, uint32 action)
{
    ScriptedInstance* pInstance = ((ScriptedInstance*)_Creature->GetInstanceData());

    if (action == GOSSIP_ACTION_INFO_DEF)
    {
        DoScriptText(SCRIPTTEXT_AT_EVENT_START,_Creature);

        ((boss_MedivhAI*)_Creature->AI())->StartMiniEvent();

        pInstance->SetData(CHESS_EVENT_TEAM, player->GetTeam());
        _Creature->GetMotionMaster()->MoveRandom(10);
    }

    player->CLOSE_GOSSIP_MENU();

    return true;
}

CreatureAI* GetAI_npc_Medivh(Creature * _Creature)
{
    return new boss_MedivhAI (_Creature);
}

CreatureAI* GetAI_npc_chesspiece(Creature *_Creature)
{
    return new npc_chesspieceAI (_Creature);
}

CreatureAI* GetAI_move_trigger(Creature *_Creature)
{
    return new move_triggerAI (_Creature);
}

CreatureAI* GetAI_npc_chess_statusAI(Creature *_Creature)
{
    return new npc_chess_statusAI (_Creature);
}

void AddSC_chess_event()
{
    Script* newscript;

    newscript = new Script;
    newscript->GetAI = &GetAI_npc_chesspiece;
    newscript->Name = "npc_chesspiece";
    newscript->pGossipHello = &GossipHello_npc_chesspiece;
    newscript->pGossipSelect = &GossipSelect_npc_chesspiece;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_echo_of_medivh";
    newscript->GetAI = &GetAI_npc_Medivh;
    newscript->pGossipHello = &GossipHello_npc_echo_of_medivh;
    newscript->pGossipSelect = &GossipSelect_npc_echo_of_medivh;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "chess_move_trigger";
    newscript->GetAI = &GetAI_move_trigger;
    newscript->RegisterSelf();

    newscript = new Script;
    newscript->Name = "npc_chess_status";
    newscript->GetAI = &GetAI_npc_chess_statusAI;
    newscript->RegisterSelf();
}
