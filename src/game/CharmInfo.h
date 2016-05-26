#ifndef __CHARMINFO_H
#define __CHARMINFO_H

#include "Common.h"
#include "Unit.h"

struct SpellEntry;

enum ReactStates
{
    REACT_PASSIVE    = 0,
    REACT_DEFENSIVE  = 1,
    REACT_AGGRESSIVE = 2
};

enum CommandStates
{
    COMMAND_STAY    = 0,
    COMMAND_FOLLOW  = 1,
    COMMAND_ATTACK  = 2,
    COMMAND_ABANDON = 3
};

struct CharmSpellEntry
{
    uint16 spellId;
    uint16 active;
};

enum ActiveStates
{
    ACT_ENABLED  = 0xC100,
    ACT_DISABLED = 0x8100,
    ACT_COMMAND  = 0x0700,
    ACT_REACTION = 0x0600,
    ACT_CAST     = 0x0100,
    ACT_PASSIVE  = 0x0000,
    ACT_DECIDE   = 0x0001
};

struct UnitActionBarEntry
{
    uint32 Type;
    uint32 SpellOrAction;
};

struct Cooldown
{
    explicit Cooldown(uint32 _dur = 0, uint32 _time = 0) : duration(_dur), cast_time(_time) {}

    uint32 duration;
    uint32 cast_time;
};

typedef UNORDERED_MAP<uint32 /*category*/, Cooldown> CooldownList;

class LOOKING4GROUP_IMPORT_EXPORT CooldownMgr
{
    public:
        CooldownMgr() {}

    public:
        bool HasGlobalCooldown(SpellEntry const* spellInfo) const;
        void AddGlobalCooldown(SpellEntry const* spellInfo, uint32 gcd);
        void CancelGlobalCooldown(SpellEntry const* spellInfo);

        bool HasSpellCategoryCooldown(SpellEntry const* spellInfo) const;
        void AddSpellCategoryCooldown(SpellEntry const* spellInfo, uint32 cd);
        void CancelSpellCategoryCooldown(SpellEntry const* spellInfo);

        bool HasSpellIdCooldown(SpellEntry const* spellInfo) const;
        void AddSpellIdCooldown(SpellEntry const* spellInfo, uint32 cd);
        void CancelSpellIdCooldown(SpellEntry const* spellInfo);

    private:
        CooldownList m_GlobalCooldowns;
        CooldownList m_CategoryCooldowns;
        CooldownList m_SpellCooldowns;
};

struct LOOKING4GROUP_IMPORT_EXPORT CharmInfo
{
    public:
        explicit CharmInfo(Unit* unit);
        ~CharmInfo();
        uint32 GetPetNumber() const { return m_petnumber; }
        void SetPetNumber(uint32 petnumber, bool statwindow);

        void SetCommandState(CommandStates st) { m_CommandState = st; }
        CommandStates GetCommandState() { return m_CommandState; }
        bool HasCommandState(CommandStates state) { return (m_CommandState == state); }

        void InitPossessCreateSpells();
        void InitCharmCreateSpells();
        void InitPetActionBar();
        void InitEmptyActionBar(bool withAttack = true);
                                                            //return true if successful
        bool AddSpellToActionBar(uint32 oldid, uint32 newid, ActiveStates newstate = ACT_DECIDE);
        void ToggleCreatureAutocast(uint32 spellid, bool apply);

        UnitActionBarEntry* GetActionBarEntry(uint8 index) { return &(PetActionBar[index]); }
        CharmSpellEntry* GetCharmSpell(uint8 index) { return &(m_charmspells[index]); }

        CooldownMgr& GetCooldownMgr() { return m_CooldownMgr; }

        void HandleStayCommand();
        void HandleFollowCommand();
        void HandleAttackCommand(uint64 targetGUID);
        void HandleSpellActCommand(uint64 targetGUID, uint32 spellId);

    private:
        Unit* m_unit;
        UnitActionBarEntry PetActionBar[10];
        CharmSpellEntry m_charmspells[CREATURE_MAX_SPELLS];

        CommandStates   m_CommandState;

        uint32          m_petnumber;
        bool            m_barInit;

        //for restoration after charmed
        ReactStates     m_oldReactState;

        CooldownMgr m_CooldownMgr;
};

#endif
