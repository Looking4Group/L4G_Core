#ifndef CHESS_EVENT
#define CHESS_EVENT

/* ScriptData
SDName: Chess_Event
SD%Complete: xx
SDCategory: Karazhan

TODO:
 - Fix spells (Game in session, Rain of Fire, Poison Cloud (it's all ? ))
EndScriptData */

#include "precompiled.h"
#include "def_karazhan.h"
#include "instance_karazhan.h"

#define A_FACTION  1690
#define H_FACTION  1691

#define EVENT_START         "Prepare Chess Board" // Maybe should be different gossip, visuals will be fixed at the end :]
#define TRIGGER_ID          22519
#define DUST_COVERED_CHEST  185119

#define DUST_COVERED_CHEST_LOCATION -11061.6, -1900.3, 221.1, 2.219765

#define ALLIANCE_DEAD_X1        -11081.2 //-11047.8
#define ALLIANCE_DEAD_X2        -11082.8 //-11046.1
#define ALLIANCE_DEAD_Y1        -1842.2
#define ALLIANCE_DEAD_Y2        -1840.1 //-1886.4
#define HORDE_DEAD_X1           -11080.4
#define HORDE_DEAD_X2           -11078.7
#define HORDE_DEAD_Y1           -1910.2
#define HORDE_DEAD_Y2           -1912.2
#define POSITION_Z              220.66

                                //x, y, z
#define SPAWN_POS               wLoc.coord_x, wLoc.coord_y, wLoc.coord_z

#define START_PRIORITY                  100
#define RAND_PRIORITY                   100
#define MELEE_PRIORITY                  25

// pawns
#define MELEE_PRIORITY_1_0              30
#define MELEE_PRIORITY_1_1              50
#define MELEE_PRIORITY_1_2              25
#define MELEE_PRIORITY_1_3              -25
#define MELEE_PRIORITY_1_4              -50
// rooks/knights
#define MELEE_PRIORITY_2_0              25
#define MELEE_PRIORITY_2_1              50
#define MELEE_PRIORITY_2_2              75
#define MELEE_PRIORITY_2_3              75
#define MELEE_PRIORITY_2_4              75
// kings
#define MELEE_PRIORITY_3_0              25
#define MELEE_PRIORITY_3_1              50
#define MELEE_PRIORITY_3_2              50
#define MELEE_PRIORITY_3_3              35
#define MELEE_PRIORITY_3_4              -25
// quens/bishops
#define MELEE_PRIORITY_4_0              25
#define MELEE_PRIORITY_4_1              30
#define MELEE_PRIORITY_4_2              0
#define MELEE_PRIORITY_4_3              -25
#define MELEE_PRIORITY_4_4              -50

#define ATTACK_KING_PRIOR               50
#define ATTACK_HEALER_PRIOR             50

#define MELEE_ENEMY_COUNT_PRIOR_MOD_1   50
#define MELEE_ENEMY_COUNT_PRIOR_MOD_2   25
#define MELEE_ENEMY_COUNT_PRIOR_MOD_3   -25
#define MELEE_ENEMY_COUNT_PRIOR_MOD_4   -50

#define MOVE_BACK_PRIOR_MOD             -75
#define MOVE_STRAFE_PRIOR_MOD           -50
#define STAY_IN_PLACE_PRIOR_MOD         0
#define MOVE_DEFAULT_PRIOR_MOD          25

#define ABILITY_CHANCE_MAX      100
#define HEALING_ABILITY_CHANCE  75
#define NORMAL_ABILITY_CHANCE   50
#define ABILITY_1_CHANCE_MIN    25
#define ABILITY_1_CHANCE_MAX    66
#define ABILITY_2_CHANCE_MIN    25
#define ABILITY_2_CHANCE_MAX    66

#define MIN_MOVE_CHANCE         33
#define MAX_MOVE_CHANCE         90

#define MIN_SELF_MOVE_CHANCE    25
#define MAX_SELF_MOVE_CHANCE    50

#define RAND_MAX_VAL            1000

#define attackCooldown          urand(2000, 4000)
#define SHARED_COOLDOWN         5000

#define ADD_PIECE_TO_MOVE_TIMER urand(2000, 5000);

#define ORI_N           0.656777
#define ORI_E           5.391155
#define ORI_S           3.817220
#define ORI_W           2.239354

#define PIECES_HP_SUM           1040000
#define FIRST_CHEAT_HP_MIN      PIECES_HP_SUM/10
#define FIRST_CHEAT_HP_MAX      PIECES_HP_SUM/6
#define SECOND_CHEAT_HP_MIN     PIECES_HP_SUM/5
#define SECOND_CHEAT_HP_MAX     PIECES_HP_SUM/2
#define THIRD_CHEAT_HP_MIN      PIECES_HP_SUM - PIECES_HP_SUM/5
#define THIRD_CHEAT_HP_MAX      PIECES_HP_SUM - PIECES_HP_SUM/9

#define FIRST_CHEAT_TIMER_MIN   60000
#define FIRST_CHEAT_TIMER_MAX   90000
#define SECOND_CHEAT_TIMER_MIN  75000
#define SECOND_CHEAT_TIMER_MAX  120000
#define THIRD_CHEAT_TIMER_MIN   120000
#define THIRD_CHEAT_TIMER_MAX   180000

//#define CHESS_DEBUG_INFO                            1
//#define CHESS_EVENT_DISSABLE_MEDIVH_PIECES_MOVEMENT 1
//#define CHESS_EVENT_DISSABLE_MEDIVH_PIECES_SPELLS   1
//#define CHESS_EVENT_DISSABLE_MELEE                  1
//#define CHESS_EVENT_DISSABLE_FACING                 1

enum SCRIPTTEXTs
{
    SCRIPTTEXT_AT_EVENT_START   =  -1650000,
    SCRIPTTEXT_LOSE_KNIGHT_P    =  -1650001,
    SCRIPTTEXT_LOSE_KNIGHT_M    =  -1650002,
    SCRIPTTEXT_LOSE_PAWN_P_1    =  -1650003,
    SCRIPTTEXT_LOSE_PAWN_P_2    =  -1650004,
    SCRIPTTEXT_LOSE_PAWN_P_3    =  -1650005,
    SCRIPTTEXT_LOSE_PAWN_M_1    =  -1650006,
    SCRIPTTEXT_LOSE_PAWN_M_2    =  -1650007,
    SCRIPTTEXT_LOSE_PAWN_M_3    =  -1650008,
    SCRIPTTEXT_LOSE_QUEEN_P     =  -1650009,
    SCRIPTTEXT_LOSE_QUEEN_M     =  -1650010,
    SCRIPTTEXT_LOSE_BISHOP_P    =  -1650011,
    SCRIPTTEXT_LOSE_BISHOP_M    =  -1650012,
    SCRIPTTEXT_LOSE_ROOK_P      =  -1650013,
    SCRIPTTEXT_LOSE_ROOK_M      =  -1650014,
    SCRIPTTEXT_PLAYER_CHECK     =  -1650015,
    SCRIPTTEXT_MEDIVH_CHECK     =  -1650016,
    SCRIPTTEXT_PLAYER_WIN       =  -1650017,
    SCRIPTTEXT_MEDIVH_WIN       =  -1650018,
    SCRIPTTEXT_MEDIVH_CHEAT_1   =  -1650019,
    SCRIPTTEXT_MEDIVH_CHEAT_2   =  -1650020,
    SCRIPTTEXT_MEDIVH_CHEAT_3   =  -1650021
};

enum NPCs
{
    NPC_MEDIVH   = 16816,
    NPC_PAWN_H   = 17469,
    NPC_PAWN_A   = 17211,
    NPC_KNIGHT_H = 21748,
    NPC_KNIGHT_A = 21664,
    NPC_QUEEN_H  = 21750,
    NPC_QUEEN_A  = 21683,
    NPC_BISHOP_H = 21747,
    NPC_BISHOP_A = 21682,
    NPC_ROOK_H   = 21726,
    NPC_ROOK_A   = 21160,
    NPC_KING_H   = 21752,
    NPC_KING_A   = 21684,
    NPC_STATUS   = 22520
};

enum ChessEventSpells
{
    SPELL_MOVE_1   = 37146,
    SPELL_MOVE_2   = 30012,
    SPELL_MOVE_3   = 37144,
    SPELL_MOVE_4   = 37148,
    SPELL_MOVE_5   = 37151,
    SPELL_MOVE_6   = 37152,
    SPELL_MOVE_7   = 37153,

    SPELL_MOVE_PREVISUAL = 32745,

    SPELL_CHANGE_FACING     = 30284,
    SPELL_MOVE_MARKER       = 32261,
    SPELL_POSSES_CHESSPIECE = 30019,
    SPELL_IN_GAME           = 30532,
    SPELL_GAME_IN_SESSION   = 39331,
    SPELL_RECENTLY_IN_GAME  = 30529,
    SPELL_FURY_OF_MEDIVH    = 39383,  // 1st cheat: AOE spell burn cell under enemy chesspieces.
    SPELL_HAND_OF_MEDIVH    = 39339,  // 2nd cheat: Berserk own chesspieces.
    // 3rd cheat: set own creatures to max health
    SPELL_GAME_OVER         = 39401
};

enum ChessPiecesSpells
{
    //ability 1
    SPELL_KING_H_1    = 37476,    //Cleave
    SPELL_KING_A_1    = 37474,    //Sweep
    SPELL_QUEEN_H_1   = 37463,    //Fireball
    SPELL_QUEEN_A_1   = 37462,    //Elemental Blast
    SPELL_BISHOP_H_1  = 37456,    //Shadow Mend
    SPELL_BISHOP_A_1  = 37455,    //Healing
    SPELL_KNIGHT_H_1  = 37454,    //Bite
    SPELL_KNIGHT_A_1  = 37453,    //Smash
    SPELL_ROOK_H_1    = 37428,    //Hellfire
    SPELL_ROOK_A_1    = 37427,    //Geyser
    SPELL_PAWN_H_1    = 37413,    //Vicious Strike
    SPELL_PAWN_A_1    = 37406,    //Heroic Blow

    //ability 2
    SPELL_KING_H_2    = 37472,    //Bloodlust
    SPELL_KING_A_2    = 37471,    //Heroism
    SPELL_QUEEN_H_2   = 37469,    //Poison Cloud
    SPELL_QUEEN_A_2   = 37465,    //Rain of Fire
    SPELL_BISHOP_H_2  = 37461,    //Shadow Spear
    SPELL_BISHOP_A_2  = 37459,    //Holy Lance
    SPELL_KNIGHT_H_2  = 37502,    //Howl
    SPELL_KNIGHT_A_2  = 37498,    //Stomp
    SPELL_ROOK_H_2    = 37434,    //Fire Shield
    SPELL_ROOK_A_2    = 37432,    //Water Shield
    SPELL_PAWN_H_2    = 37416,    //Weapon Deflection
    SPELL_PAWN_A_2    = 37414     //Shield Block
};

enum MiniEvent
{
    MINI_EVENT_NONE     = 0,
    MINI_EVENT_KING     = 1,
    MINI_EVENT_QUEEN    = 2,
    MINI_EVENT_BISHOP   = 3,
    MINI_EVENT_KNIGHT   = 4,
    MINI_EVENT_ROOK     = 5,
    MINI_EVENT_PAWN     = 6,
    MINI_EVENT_END      = 7
};

enum GameEndEvent
{
    GAMEEND_NONE            = 0,
    GAMEEND_MEDIVH_WIN      = 1,
    GAMEEND_MEDIVH_LOSE     = 2,
    GAMEEND_CLEAR_BOARD     = 3,
    GAMEEND_DESPAWN_CHEST   = 4
};

enum AbilityCooldowns
{
    //ability 1
    CD_KING_1    = 5000,
    CD_QUEEN_1   = 5000,
    CD_BISHOP_1  = 20000,
    CD_KNIGHT_1  = 5000,
    CD_ROOK_1    = 5000,
    CD_PAWN_1    = 5000,

    //ability 2
    CD_KING_2    = 15000,
    CD_QUEEN_2   = 15000,
    CD_BISHOP_2  = 5000,
    CD_KNIGHT_2  = 5000,
    CD_ROOK_2    = 5000,
    CD_PAWN_2    = 5000
};

/*enum AttackSpells
{
    ATTACK              = 6603,
    ATTACK_TIMER        = 32226,
    TAKE_ACTION         = 32225,

    //ally
    ELEMENTAL_ATTACK    = 750,//37142,
    ELEMENTAL_ATTACK2   = 0,//37143,
    FOOTMAN_ATTACK_DMG  = 0,//32247,
    FOOTMAN_ATTACK      = 500,//32227,
    CLERIC_ATTACK       = 1250,//37147,
    CONJURER_ATTACK     = 1500,//37149,
    KING_LLANE_ATTACK   = 1750,//37150,

    //horde
    GRUNT_ATTACK        = 500,//32228,
    NECROLYTE_ATTACK    = 1250,//37337,
    WARLOCK_ATTACK      = 1500,//37345,
    WOLF_ATTACK         = 1000,//37339,
    DEMON_ATTACK        = 750,//37220,
    WARCHIEF_ATTACK     = 1750//37348
};*/

enum ChessPiecesStances
{
    PIECE_NONE          = 0,
    PIECE_MOVE          = 1,
    PIECE_CHANGE_FACING = 2
    //PIECE_DIE           = 3
};

enum ChessOrientation
{
    CHESS_ORI_N      = 0,   //Horde side
    CHESS_ORI_E      = 1,   //Doors to Prince
    CHESS_ORI_S      = 2,   //Alliance side
    CHESS_ORI_W      = 3,   //Medivh side
    CHESS_ORI_CHOOSE = 4    //simple use script to choose orientation
};

struct ChessTile
{
    WorldLocation position;
    uint64 piece;           //GUID;
    uint64 trigger;         //GUID;
    ChessOrientation ori;   //Orientation for GetMeleeTarget(), updated by medivh function SetOrientation();

    ChessTile()
    {
        piece = 0;
        trigger = 0;
        ori = CHESS_ORI_CHOOSE;
        position.coord_z = 220.66f;
    }

    ChessTile(const ChessTile &p)
    {
        piece = p.piece;
        trigger = p.trigger;
        ori = p.ori;
        position = p.position;
    }
};

struct ChessPosition
{
    uint64 GUID;
    int i;
    int j;

    ChessPosition()
    {
        GUID = 0;
        i = -1;
        j = -1;
    }

    ChessPosition(uint64 guid, int i, int j)
    {
        this->GUID = guid;
        this->i = i;
        this->j = j;
    }
};

struct Priority
{
    uint64 GUIDfrom;
    uint64 GUIDto;
    int prior;

    Priority()
    {
        GUIDfrom = 0;
        GUIDto = 0;
        prior = 0;
    }
};

#define OFFSETMELEECOUNT    4
#define OFFSET8COUNT        8
#define OFFSET15COUNT       12
#define OFFSET20COUNT       24
#define OFFSET25COUNT       4

// 0 - caster; 1 - 8yd range; 2 - 15yd range; 3 - 20 yd range; 4 - 25 yd range
//
// 4 3 3 3 3 3 4
// 3 3 2 2 2 3 3
// 3 2 1 1 1 2 3
// 3 2 1 0 1 2 3
// 3 2 1 1 1 2 3
// 3 3 2 2 2 3 3
// 4 3 3 3 3 3 4
//

const int offsetTabMelee[4][2] = {{-1, 0}, {1, 0}, {0, 1}, {0, -1}};

const int offsetTab8[8][2] = {{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}};

const int offsetTab15[12][2] = {{-2, -1}, {-2, 0}, {-2, 1}, {-1, -2}, {-1, 2}, {0, -2}, {0, 2}, {1, -2}, {1, 2}, {2, -1}, {2, 0}, {2, 1}};

const int offsetTab20[24][2] = {{-3, -2}, {-3, -1}, {-3, 0}, {-3, 1}, {-3, 2}, {-2, -3}, {-2, 3}, {-1, -3}, {-1, 3}, {0, -3}, {0, 3}, {1, -3}, {1, 3}, {2, -3}, {2, 3}, {3, -2}, {3, -1}, {3, 0}, {3, 1}, {3, 2}, {2, 2}, {-2, 2}, {2, -2}, {-2, -2}};

const int offsetTab25[4][2] = {{-3, -3}, {3, -3}, {3, 3}, {-3, 3}};

class move_triggerAI : public ScriptedAI
{
private:
    ScriptedInstance* pInstance;

    WorldLocation wLoc;

    uint64 MedivhGUID;

    int32 moveTimer;
    uint64 unitToMove;
    ChessPiecesStances pieceStance;

public:
    move_triggerAI(Creature *c);

    void Reset();

    void Aggro(Unit *){}

    void SpellHit(Unit *caster,const SpellEntry *spell);

    void MakeMove();
    void RemoveFromMove(uint64 piece);

    void UpdateAI(const uint32 diff);
};

class npc_chesspieceAI : public Scripted_NoMovementAI
{
private:
    ScriptedInstance* pInstance;

    Creature * npc_medivh;

    bool ReturnToHome;
    bool CanMove;

    uint64 MedivhGUID;

    int ability1Chance;     //chance to cast spell
    int ability2Chance;
    int attackDamage;

    int32 ability1Timer;
    int32 ability1Cooldown;
    int32 ability2Timer;
    int32 ability2Cooldown;
    int32 attackTimer;

    int32 nextTryTimer;     //try to cast spell after some time

    uint32 changeFacingTimer;

    uint32 ability1ID;
    uint32 ability2ID;
    uint32 moveID;

public:
    bool InGame;

    npc_chesspieceAI(Creature *c);

    void Aggro(Unit *Unit){};

    void EnterEvadeMode();

    void SetSpellsAndCooldowns();
    bool IsOnSelfSpell(uint32 spell);       // check if spell can be only casted on self (like absorb)
    bool IsHealingSpell(uint32 spell);
    bool IsNullTargetSpell(uint32 spell);

    void Reset();

    void MovementInform(uint32 MovementType, uint32 Data);

    void JustRespawned();

    void OnCharmed(bool apply);

    void SpellHit(Unit * caster, const SpellEntry * spell);

    void SpellHitTarget(Unit * caster, const SpellEntry * spell);

    void DamageTaken(Unit * done_by, uint32& damage);

    void JustDied(Unit* killer);

    void UpdateAI(const uint32 diff);
};

class boss_MedivhAI : public ScriptedAI
{
private:
    instance_karazhan* pInstance;

    int16 hordePieces;      //count of alive horde side pieces
    int16 alliancePieces;   //count of alive alliance side pieces

    int16 chanceToMove;     //random chance for medivh to move piece when player moved
                            //when player want to move his piece medivh tests if he can move too

    int16 chanceToSelfMove;

    ChessTile chessBoard[8][8];
    float hordeSideDeadWP[2][16];
    float allianceSideDeadWP[2][16];

    std::list<uint64> medivhSidePieces;     //alive pieces guids

    std::list<uint64> unusedMedivhPieces;   //pieces that was summoned after medivh piece death
    std::list<uint64> unusedPlayerPieces;   //pieces that was summoned after player piece death

    bool eventStarted;

    GameEndEvent endGameEventState;
    MiniEvent miniEventState;

    int endEventCount;

    int32 miniEventTimer;
    uint32 endEventTimer;
    uint32 endEventLightningTimer;

    uint32 firstCheatTimer;
    uint32 secondCheatTimer;
    uint32 thirdCheatTimer;
    double firstCheatDamageReq;
    double secondCheatDamageReq;
    double thirdCheatDamagereq;

    WorldLocation wLoc;     //location of medivh
    WorldLocation tpLoc;    //location of player teleport point

    std::list<uint64> tpList;
    std::list<ChessTile> moveList; //list of triggers to make move

    uint32 moveTimer;
    uint32 addPieceToMoveCheckTimer;

    uint64 chestGUID;

public:
    boss_MedivhAI(Creature *c);

    //remove

    void SayChessPieceDied(Unit * piece);
    void RemoveChessPieceFromBoard(uint64 piece);       //removes dead piece from chess board
    void RemoveChessPieceFromBoard(Creature * piece);   //and spawn them in position near board

    //check

    bool IsChessPiece(Unit * unit);
    bool IsMedivhsPiece(Unit * unit);
    bool IsMedivhsPiece(uint64 unit);
    bool IsEmptySquareInRange(uint64 piece, int range);
    bool IsInMoveList(uint64 unit, bool trigger = false);
    bool IsInMoveRange(uint64 from, uint64 to, int range);
    bool IsKing(uint64 piece);
    bool IsHealer(uint64 piece);
    bool IsKing(Creature * piece);
    bool IsHealer(Creature * piece);

    bool IsHealingSpell(uint32 spell);
    bool Heal(uint32 spell, uint64 guid);   // if isn't healing spell or creature isn't in full hp

    void CheckChangeFacing(uint64 piece, int i = -1, int j = -1);

    //event

    void ClearBoard();
    void PrepareBoardForEvent();
    void StartMiniEvent();
    void StartEvent();
    void SpawnRooks();
    void SpawnKnights();
    void SpawnBishops();
    void SpawnQueens();
    void SpawnKings();
    void SpawnPawns();
    void SpawnTriggers();

    void DeleteChest();

    //move

    int CalculatePriority(uint64 piece, uint64 trigger);
    void ChoosePieceToMove();
    bool ChessSquareIsEmpty(uint64 trigger);
    bool ChessSquareIsEmpty(int i, int j);
    bool CanMoveTo(uint64 trigger, uint64 piece);   //check if player can move to trigger - prevent cheating
    void AddTriggerToMove(uint64 trigger, uint64 piece, bool player);
    void RemoveFromMoveList(uint64 unit);
    Creature * FindTrigger(uint64 piece);               //find trigger where piece actually should be
    uint64 FindTriggerGUID(uint64 piece);
    int GetMoveRange(uint64 piece);
    int GetMoveRange(Unit * piece);
    uint32 GetMoveSpell(uint64 piece);
    uint32 GetMoveSpell(Creature * piece);
    bool FindPlaceInBoard(uint64 unit, int & i, int & j);
    void ChangePlaceInBoard(uint64 piece, uint64 destTrigger);
    void ChangePieceFacing(uint64 piece, uint64 destTrigger);
    void ChangePieceFacing(Creature * piece, Creature * destTrigger);

    //priority

    int GetCountOfEnemyInMelee(uint64 piece, bool strafe = false);
    int GetCountOfPiecesInRange(uint64 trigger, int range, bool friendly);
    int GetLifePriority(uint64 piece);
    int GetAttackPriority(uint64 piece);

    //target

    int GetAbilityRange(uint32 spell);      // return custom ability range <-- needed for target selection
    bool IsPositive(uint32 spell);          // check if spell is positive <-- if true then select friendly target
    uint64 GetSpellTarget(uint64 caster, uint32 spell);
    uint64 GetMeleeTarget(uint64 piece);

    //other

    void SetOrientation(uint64 piece, ChessOrientation ori = CHESS_ORI_CHOOSE);
    bool Enemy(uint64 piece1, uint64 piece2);
    uint32 GetEntry(uint64 piece);
    uint32 GetDeadEntryForPiece(Creature * piece);
    uint32 GetDeadEntryForPiece(uint32 entry);

    void Reset();
    void UpdateAI(const uint32 diff);
};

class npc_chess_statusAI : public ScriptedAI
{
public:
    npc_chess_statusAI(Creature *c) : ScriptedAI(c) {}

    void Reset();

    void UpdateAI(const uint32 diff) {}
};

#endif
